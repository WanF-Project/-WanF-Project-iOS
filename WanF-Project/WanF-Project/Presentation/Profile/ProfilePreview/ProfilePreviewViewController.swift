//
//  ProfilePreviewViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/06/04.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class ProfilePreviewViewController: UIViewController {
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    
    //MARK: - View
    let scrollView = UIScrollView()
    let profileContentView = ProfileContentView()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        layout()
    }
    
    //MARK: - Function
    func bind(_ viewModel: ProfilePreviewViewModel, id: Int) {
        // Bind Subcomponent View
        profileContentView.bind(viewModel.profileContentViewModel)
        
        // Load Profile Preview
        viewModel.shouldLoadProfilePreview.accept(id)
        
        // Present ActivityView for Contact
        profileContentView.profileContactButton.rx.tap
            .bind(to: viewModel.shouldPresentActivity)
            .disposed(by: disposeBag)
        
        viewModel.presentActivity
            .drive(onNext: { contact in
                let activityVC = UIActivityViewController(activityItems: [contact], applicationActivities: [])
                self.present(activityVC, animated: true)
            })
            .disposed(by: disposeBag)
        
    }
}

//MARK: - Configure
private extension ProfilePreviewViewController {
    func configureView() {
        
        view.backgroundColor = .wanfBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(profileContentView)
    }
    
    func layout() {
        
        let inset = 50.0
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        profileContentView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(inset)
            make.horizontalEdges.equalToSuperview().inset(inset)
            make.width.equalTo(scrollView.snp.width).inset(inset)
        }
    }
}
