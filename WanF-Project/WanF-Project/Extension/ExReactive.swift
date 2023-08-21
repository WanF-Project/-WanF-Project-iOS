//
//  ExReactive.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/10.
//

import UIKit

import RxSwift
import RxCocoa

extension Reactive where Base: UIControl {
    public var tap: ControlEvent<Void> {
        controlEvent(.touchUpInside)
    }
}
