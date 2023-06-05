//
//  FriendsMatchDetailViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/11.
//

import UIKit

import RxSwift
import RxCocoa

struct FriendsMatchDetailViewModel {
    
    let disposeBag = DisposeBag()
    
    let detailInfoViewModel = FriendsMatchDetailInfoViewModel()
    let lectureInfoViewModel = FriendsMatchDetailLectureInfoViewModel()
    let detailTextViewModel = FriendsMatchDetailTextViewModel()
    let commentListViewModel = FriendsMatchCommentListViewModel()
    
    // View -> ViewModel
    let shouldLoadDetail = PublishSubject<Void>()
    let menueButtonTapped = PublishRelay<Void>()
    let deleteButtonTapped = BehaviorRelay(value: Void())
    let loadFriendsMatchDetail = PublishRelay<Void>()
    let didTabNickname = PublishRelay<Void>()
    
    // ViewModel -> View
    let detailData: Observable<FriendsMatchDetailEntity>
    let presentMenueActionSheet: Signal<Void>
    let popToRootViewController: Driver<Void>
    let presentProfilePreview: Driver<Int>
    
    // ViewModel -> ChildViewModel
    let detailInfo: Observable<(String, String)>
    let detailLectureInfo: Observable<LectureInfoEntity>
    let detailText: Observable<(String, String)>
    
    init(_ model: FriendsMatchDetailModel = FriendsMatchDetailModel(), id: Int) {
        
        //글 상세 데이터 받기
        let loadDetailResult = loadFriendsMatchDetail
            .flatMap { _ in
                model.loadDetail(id)
            }
            .share()
        loadDetailResult.subscribe().disposed(by: disposeBag)
        
        // 성공 - 각 SubView에 데이터 전달
        let loadDetailValue = loadDetailResult
            .compactMap(model.getDetailValue)
        
        detailData = loadDetailValue
            .share()
  
        presentProfilePreview = Observable
            .combineLatest(detailData, didTabNickname)
            .map({ data, _ in
                return data.profile.id
            })
            .asDriver(onErrorDriveWith: .empty())
        
        detailInfo = detailData
            .map({ data in
                (data.profile.nickname ?? "", data.date ?? "")
            })
        
        detailInfo
            .bind(to: detailInfoViewModel.detailInfo)
            .disposed(by: disposeBag)


        detailLectureInfo = detailData
            .map({ data in
                data.lectureInfo
            })

        detailLectureInfo
            .bind(to: lectureInfoViewModel.detailLectureInfo)
            .disposed(by: disposeBag)

        detailText = detailData
            .map({ data in
                (data.title, data.content)
            })

        detailText
            .bind(to: detailTextViewModel.detailText)
            .disposed(by: disposeBag)
        
        // TODO: - 추후 구현
        // 실패 -
        let loadDetailError = loadDetailResult
            .compactMap(model.getDetailError)
        
        // Tap the MenueButton
        presentMenueActionSheet = menueButtonTapped
            .asSignal(onErrorSignalWith: .empty())
        
        //Tap the Delete Button
        let deleteDetailResult = deleteButtonTapped
            .flatMap({ _ in
                model.deleteDetail(id)
            })
            .share()
        
        let deleteDetailValue = deleteDetailResult
            .compactMap(model.getDeleteDetailValue)
        
        let deleDetailError = deleteDetailResult
            .compactMap(model.getDeleteDetailError)
        
        popToRootViewController = deleteDetailValue
            .asDriver(onErrorDriveWith: .empty())
    }
}
