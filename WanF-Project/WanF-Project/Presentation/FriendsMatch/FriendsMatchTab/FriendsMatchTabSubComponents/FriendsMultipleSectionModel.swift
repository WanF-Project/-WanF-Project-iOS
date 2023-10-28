//
//  FriendsMultipleSectionModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/10/26.
//

import UIKit

import RxDataSources

/// FriendsMatchList 화면 다중 Section을 위한 메서드 및 열거형
typealias FriendsMultipleSectionDataSource = RxCollectionViewSectionedReloadDataSource<MultipleSectionModel>

func dataSource() -> FriendsMultipleSectionDataSource {
    return FriendsMultipleSectionDataSource { dataSource, collectionView, indexPath, item in
        switch dataSource[indexPath] {
        case let .BannerItem(banner):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerSection", for: indexPath)
            return cell
        case let .PostItme(post):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsMatchListCell", for: indexPath) as? FriendsMatchListCell else { return UICollectionViewCell() }
            cell.configureCell(post)
            return cell
        }
    }
}

enum MultipleSectionModel {
    case BannerSection(items:[SectionItem])
    case PostSection(items:[SectionItem])
}

enum SectionItem {
    case BannerItem(_ banner: BannerEntity)
    case PostItme(_ post: PostListResponseEntity)
}

extension MultipleSectionModel: SectionModelType {
    typealias Item = SectionItem
    
    var items: [SectionItem] {
        switch self {
        case let .BannerSection(items: items):
            return items
        case let .PostSection(items: items):
            return items
        }
    }
    
    init(original: MultipleSectionModel, items: [SectionItem]) {
        switch original {
        case let .BannerSection(items: items):
            self = .BannerSection(items: items)
        case let .PostSection(items: items):
            self = .PostSection(items: items)
        }
    }
}
