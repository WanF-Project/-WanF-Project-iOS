//
//  CSSearchBarView.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/07/28.
//

import UIKit

import RxSwift
import RxCocoa

class CSSearchBarView: UISearchBar {
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        
        configureView()
    }
    
    //MARK: - Function
    func bind(_ viewModel: CSSearchBarViewModel) {
        self.rx.searchButtonClicked
            .bind(to: viewModel.searchButtonTapped)
            .disposed(by: disposeBag)
        
        self.rx.text
            .bind(to: viewModel.searchWord)
            .disposed(by: disposeBag)
        
        viewModel.searchButtonTapped
            .bind(to: self.rx.endEditing)
            .disposed(by: disposeBag)
    }
}

//MARK: - Configure
private extension CSSearchBarView {
    func configureView() {
        self.searchBarStyle = .minimal
        self.tintColor = .wanfMint
    }
}

//MARK: - Reactive
extension Reactive where Base: CSSearchBarView {
    var endEditing: Binder<Void> {
        return Binder(base) { base, _ in
            base.endEditing(true)
        }
    }
}
