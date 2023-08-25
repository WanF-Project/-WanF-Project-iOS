//
//  ProfileTapBackgroundControl.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/25.
//

import UIKit

import RxSwift
import RxCocoa

/// TouchUpInSide 이벤트가 가능한 불투명 background Control
class ProfileTapBackgroundControl: UIControl {
    
    //MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .wanfLabel.withAlphaComponent(0.5)
        addTarget(self, action: #selector(didTouchUpInSide), for: .touchUpInside)
    }
    
    //MARK: - Function
    @objc func didTouchUpInSide(_ sender: UIControl) {
        sender.isHidden.toggle()
    }
    
}

extension Reactive where Base: ProfileTapBackgroundControl {
    /// 해당 View의 isHidden 상태와 반대의 값 반환
    var tapForHidden: ControlEvent<Bool> {
        
        let observable = base.rx.tap
            .map { _ in
                !base.isHidden
            }
        
        return ControlEvent(events: observable)
    }
}
