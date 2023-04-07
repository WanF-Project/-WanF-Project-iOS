//
//  EmailStackViewCellViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/07.
//

import Foundation

import RxSwift
import RxCocoa

struct EmailStackViewCellViewModel {
    
    // View -> ViewModel
    let inputedIDText = PublishRelay<String?>()
    
    init() {
        
        let ID = inputedIDText
            .compactMap { $0 }
        let emailAddress = Observable.just("@")
        
        let emailText = Observable
            .combineLatest(ID, emailAddress) { ID,  address in
                ID + address
            }
    }
    
}
