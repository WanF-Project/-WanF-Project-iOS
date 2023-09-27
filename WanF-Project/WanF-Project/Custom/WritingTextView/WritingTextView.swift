//
//  WritingTextView.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/26.
//

import UIKit

import RxSwift
import RxCocoa

/// placeholder를 가지는 글 작성 Custom TextView
class WritingTextView: UITextView {
    
    let disposeBag = DisposeBag()
    var placeholder = ""
    
    //MARK: - Initialize
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeholder: String, font: UIFont = .wanfFont(ofSize: 15, weight: .regular)) {
        super.init(frame: .zero, textContainer: .none)
        
        self.placeholder = placeholder
        self.font = font
        configure()
    }
    
    //MARK: - Function
    func bind(_ viewModel: WritingTextViewModel) {
        
        self.rx.didBeginEditing
            .map {
                viewModel.shouldActiveDoneButton.accept(true)
                return .writing
            }
            .bind(to: self.rx.state)
            .disposed(by: disposeBag)
        
        self.rx.didEndEditing
            .map {
                if self.text.isEmpty {
                    viewModel.shouldActiveDoneButton.accept(false)
                    return .placeholder
                }
                else {
                    viewModel.shouldActiveDoneButton.accept(true)
                    return .writing
                }
            }
            .bind(to: self.rx.state)
            .disposed(by: disposeBag)
        
        self.rx.didChange
            .subscribe(onNext: { _ in
                if self.text.isEmpty {
                    viewModel.shouldActiveDoneButton.accept(false)
                }
                else {
                    viewModel.shouldActiveDoneButton.accept(true)
                }
            })
            .disposed(by: disposeBag)
    }
}

//MARK: - Configure
private extension WritingTextView {
    func configure() {
        self.isScrollEnabled = false
        self.isEditable = true
        self.tintColor = .wanfMint
        self.textColor = .placeholderText
        self.text = placeholder
    }
}

//MARK: - Reactive
enum WritingState {
    case placeholder
    case writing
}

extension Reactive where Base: WritingTextView {
    var state: Binder<WritingState> {
        return Binder(base) { base, state in
            switch state {
            case .placeholder:
                base.text = base.placeholder
                base.textColor = .placeholderText
            case .writing:
                base.text = base.text == base.placeholder ? "" : base.text
                base.textColor = .wanfLabel
            }
        }
    }
}
