//
//  ClubListViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/09.
//

import UIKit

import RxSwift
import RxCocoa

class ClubListViewController: UIViewController {
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    
    //MARK: - View
    private let profileBarButton = ProfileBarButtonItem()
    private let addBarButton = AddBarButtonItem()
    private let clubListView = ClubListTableView()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        layout()
    }
    
    //MARK: - Function
    func bind(_ viewModel: ClubListViewModel) {
        
        // Bind Subcomponent ViewModel
        clubListView.bind(viewModel.clubListTableViewModel)
        
        // View -> ViewModel
        viewModel.loadClubsSubject.onNext(Void())
        
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { _ in
                viewModel.clubsSubject.onNext(viewModel.refreshClubsSubject)
                viewModel.refreshClubsSubject.onNext(Void())
                self.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)
        
        addBarButton.rx.tap
            .bind(to: viewModel.addButtonTapped)
            .disposed(by: disposeBag)
        
        // ViewModel -> View
        viewModel.presentAddActionSheet
            .drive(onNext: {
                self.presentAddActionSheet(viewModel)
            })
            .disposed(by: disposeBag)
        
        viewModel.presentCreateAlert
            .drive(onNext: {
                self.presentCreateAlert(viewModel)
            })
            .disposed(by: disposeBag)
        
        viewModel.presentJoinAlert
            .drive(onNext: {
                self.presentJoinAlert(viewModel)
            })
            .disposed(by: disposeBag)
        
        viewModel.presentShareActivity
            .drive(onNext: { info in
                let title = "\(info.clubName)"
                let content = "모임 ID: \(info.clubID) \n비밀번호: \(info.clubPassword)"
                let image = UIImage(named: "AppIcon") ?? UIImage()
                
                let activityItems = [WanfShareActivityItemSource(title), content, image]
                let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
                self.present(activityVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.pushToClubDetail
            .drive(onNext: {
                let clubDetailVC = ClubDetailViewController()
                clubDetailVC.bind($0.viewModel)
                $0.viewModel.id.accept($0.info.id)
                $0.viewModel.clubName.accept($0.info.name)
                self.navigationController?.pushViewController(clubDetailVC, animated: true)
            })
            .disposed(by: disposeBag)
        
    }
    
    func presentAddActionSheet(_ viewModel: ClubListViewModel) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let createAction = UIAlertAction(title: "모임 생성", style: .default) { _ in
            viewModel.createActionTapped.accept(Void())
        }
        let joinAction = UIAlertAction(title: "모임 입장", style: .default) { _ in
            viewModel.joinActionTapped.accept(Void())
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        [
            createAction,
            joinAction,
            cancelAction
        ]
            .forEach {  actionSheet.addAction($0) }
        
        self.present(actionSheet, animated: true)
    }
    
    func presentCreateAlert(_ viewModel: ClubListViewModel) {
        let alert = UIAlertController(title: "모임 생성", message: nil, preferredStyle: .alert)
        
        alert.addTextField() { $0.placeholder = "모임명" }
        alert.addTextField() {
            $0.placeholder = "모임 최대 인원수"
            $0.keyboardType = .numberPad
        }
        alert.addTextField() {
            $0.placeholder = "모임 입장 비밀번호"
            $0.keyboardType = .numberPad
        }
        
        let doneAction = UIAlertAction(title: "완료", style: .default) { _ in
            guard let texts = alert.textFields,
                  let name = texts[0].text,
                  let maxText = texts[1].text,
                  let max = Int(maxText),
                  let password = texts[2].text else { return }
            
            viewModel.createClubTapped.accept(ClubRequestEntity(name: name, maxParticipants: max, password: password))
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        [
            doneAction,
            cancelAction
        ]
            .forEach {  alert.addAction($0) }
        
        self.present(alert, animated: true)
    }
    
    func presentJoinAlert(_ viewModel: ClubListViewModel) {
        let alert = UIAlertController(title: "모임 입장", message: nil, preferredStyle: .alert)
        
        alert.addTextField() { $0.placeholder = "ID" }
        alert.addTextField() {
            $0.placeholder = "비밀번호"
            $0.keyboardType = .numberPad
        }
        
        let doneAction = UIAlertAction(title: "완료", style: .default) {_ in
            guard let texts = alert.textFields,
                  let idText = texts[0].text,
                  let id = Int(idText),
                  let password = texts[1].text else { return }
            
            viewModel.joinClubTapped.accept(ClubPwdRequestEntity(clubId: id, password: password))
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        [
            doneAction,
            cancelAction
        ]
            .forEach {  alert.addAction($0) }
        
        self.present(alert, animated: true)
    }
}

private extension ClubListViewController {
    
    func configureNavigationBar() {
        
        navigationItem.title = "나의 모임"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.wanfLabel,
            NSAttributedString.Key.font : UIFont.wanfFont(ofSize: 15, weight: .bold)
        ]
        navigationController?.navigationBar.tintColor = .wanfMint
        navigationItem.leftBarButtonItem = profileBarButton
        navigationItem.rightBarButtonItem = addBarButton
    }
    
    func configure() {
        
        view.backgroundColor = .wanfBackground
        configureNavigationBar()
        
        clubListView.refreshControl = self.refreshControl
        
        view.addSubview(clubListView)
    }
    
    func layout() {
        clubListView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(5)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
    }
}
