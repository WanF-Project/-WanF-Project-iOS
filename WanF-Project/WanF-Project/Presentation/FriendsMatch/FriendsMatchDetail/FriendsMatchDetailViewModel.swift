//
//  FriendsMatchDetailViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/11.
//

import Foundation

import RxSwift
import RxCocoa

struct FriendsMatchDetailViewModel {
    
    let disposeBag = DisposeBag()
    
    let detailInfoViewModel = FriendsMatchDetailInfoViewModel()
    let lectureInfoViewModel = FriendsMatchDetailLectureInfoViewModel()
    let detailTextViewModel = FriendsMatchDetailTextViewModel()
    
    // View -> ViewModel
    let shouldLoadDetail = PublishSubject<Void>()
    
    // ViewModel -> View
    let detailData: Observable<FriendsMatchDetail>
    
    // ViewModel -> ChildViewModel
    let detailInfo: Observable<(String, String)>
    let detailLectureInfo: Observable<LectureInfoModel>
    let detailText: Observable<(String, String)>
    
    init(_ model: FriendsMatchDetailModel = FriendsMatchDetailModel()) {
        
        //글 상세 데이터 받기
        let loadDetailResult = shouldLoadDetail
            .flatMap(model.loadDetail)
            .share()
        
        let loadDetailValue = loadDetailResult
            .compactMap(model.getDetailValue)
        
        let loadDetailError = loadDetailResult
            .compactMap(model.getDetailError)
        
        //각 SubView에 데이터 전달
        detailData = loadDetailValue
  
        detailInfo = detailData
            .map({ data in
                (data.nickname, data.date)
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
    }
}
