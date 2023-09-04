//
//  MessageDetailViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/04.
//

import UIKit

import MessageKit
import InputBarAccessoryView

class MessageDetailViewController: MessagesViewController {
    
    //MARK: - Properties
    var sender = SenderEntity(senderId: "1", displayName: "name")
    var messages: [MessageEntity] = []
    
    //MARK: -  LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        configureMessageCollectionView()
        configureMessageInputBar()
        
        messagesCollectionView.reloadData()
    }
}

//MARK: - Configure
private extension MessageDetailViewController {
    func configure() {
        view.backgroundColor = .wanfBackground
    }
    
    func configureMessageCollectionView() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messagesLayoutDelegate = self
        
        scrollsToLastItemOnKeyboardBeginsEditing = true
    }
    
    func configureMessageInputBar() {
        messageInputBar.delegate = self
        
        let key = NSAttributedString.Key.self
        let attributesText = [
            key.font : UIFont.wanfFont(ofSize: 15, weight: .regular),
            key.foregroundColor : UIColor.wanfLabel
        ]
        let text = NSAttributedString(string: "", attributes: attributesText)
        
        messageInputBar.tintColor = .wanfMint
        messageInputBar.sendButton.setTitle("전송", for: .normal)
        messageInputBar.sendButton.setTitleColor(.wanfMint, for: .normal)
        messageInputBar.inputTextView.attributedText = text
    }
}

//MARK: - MessageKit Protocol
extension MessageDetailViewController: MessagesDataSource {
    var currentSender: MessageKit.SenderType {
        return sender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let key = NSAttributedString.Key.self
        let attributes = [
            key.font : UIFont.wanfFont(ofSize: 15, weight: .bold),
            key.foregroundColor : UIColor.wanfLabel
        ]
        return NSAttributedString(string: message.sender.displayName, attributes: attributes)
    }
    
    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let key = NSAttributedString.Key.self
        let attributes = [
            key.font : UIFont.wanfFont(ofSize: 12, weight: .light),
            key.foregroundColor : UIColor.wanfLabel
        ]
        let dateString = DateFormatter().wanfDateFormatted(from: message.sentDate) ?? ""
        
        return NSAttributedString(string: dateString, attributes: attributes)
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        avatarView.bounds.size = CGSize(width: 0, height: 0)
    }
    
}

extension MessageDetailViewController: MessagesDisplayDelegate, MessagesLayoutDelegate {
    
    func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 0, height: 8.0)
    }
    
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return CGFloat(30.0)
    }
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return CGFloat(30.0)
    }
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .wanfLightMint : .wanfLightGray
    }
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return .wanfLabel
    }
}

//MARK: - InputBar Protocol
extension MessageDetailViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        print("Press")
    }
}



