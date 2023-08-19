//
//  WanfShareAcitivityItemSource.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/19.
//

import UIKit
import LinkPresentation

/// 강의 모임 공유 시 사용되는 Custom ActivituItemSource
class WanfShareActivityItemSource: NSObject, UIActivityItemSource {
    
    private let title: String
    private var metadata = LPLinkMetadata()
    
    init(_ title: String) {
        self.title = title
        super.init()
        
        configureLinkMetadata()
    }
    
    func configureLinkMetadata() {
        guard let url = Bundle.main.url(forResource: "WanF", withExtension: "plist"),
              let dictionary = NSDictionary(contentsOf: url),
              let value = dictionary["ShareURL"] as? String,
              let url = URL(string: value)
        else { return }
        
        metadata.originalURL = url
        metadata.url = metadata.originalURL
        metadata.title = self.title
        
        let representationImage = NSItemProvider(object: UIImage(named: "AppIcon") ?? UIImage())
        metadata.imageProvider = representationImage
        metadata.iconProvider = representationImage
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return title
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return metadata.url
    }
    
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        return metadata
    }
}
