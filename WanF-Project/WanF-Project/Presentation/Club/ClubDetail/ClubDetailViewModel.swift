//
//  ClubDetailViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/22.
//

import Foundation

import RxSwift
import RxCocoa

struct ClubDetailViewModel {
    
    // SubcomponenetViewModel
    let cellViewModel = ClubDetailTableViewCellViewModel()
    
    let id = PublishRelay<Int>()
    
    // ViewModel -> View
    let cellData: Driver<ClubPostListResponseEntity>
    let clubName = PublishRelay<String>()
    
    init() {
        cellData = Observable
            .just([
                ClubPostResponseEntity(id: 0, createdDate: "2023-08-29T14:29:15.056216", nickname: "원프", content: "Table views in iOS display rows of vertically scrolling content in a single column. Each row in the table contains one piece of your app’s content. For example, the Contacts app displays the name of each contact in a separate row, and the main page of the Settings app displays the available groups of settings. You can configure a table to display a single long list of rows, or you can group related rows into sections to make navigating the content easier.", image: nil),
                ClubPostResponseEntity(id: 0, createdDate: "2023-08-29T14:29:15.056216", nickname: "원프", content: "Table views in iOS display rows of vertically scrolling content in a single column. ", image: nil)
            ])
            .asDriver(onErrorDriveWith: .empty())
    }
}

