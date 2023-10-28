//
//  FriendsMultipleListView.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/01.
//

import UIKit

class FriendsMultipleListView: UICollectionView {
    
    let types: [MultipleSectionType]
    
    //MARK: - Initialize
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        self.types = []
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ types: [MultipleSectionType]) {
        self.types = types
        super.init(frame: .zero, collectionViewLayout: .init())
        
        self.collectionViewLayout = layout()
        configure()
    }
}

private extension FriendsMultipleListView {
    func configure() {
        self.backgroundColor = .wanfBackground
        
        self.register(FriendsMatchListCell.self, forCellWithReuseIdentifier: "FriendsMatchListCell")
        self.register(BannerListCell.self, forCellWithReuseIdentifier: "BannerListCell")
        
        self.register(BannerListSupplementaryFooterView.self, forSupplementaryViewOfKind: "section-footer-element-kind", withReuseIdentifier: "BannerListSupplementaryFooterView")
    }
}

// CollectionView Compositional Layout
private extension FriendsMultipleListView {
    func layout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] (sectionIndex, _) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            switch self.types[sectionIndex] {
            case .bannerSection:
                print("bannerSection")
                return self.bannerSectionLayout()
            case .postSection:
                print("postSection")
                return self.postSectionLayout()
            }
        }
    }
    
    func bannerSectionLayout() -> NSCollectionLayoutSection {
        // Item
        let sizeItem = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: sizeItem)
        
        // Group
        let sizeGroup = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: sizeGroup, subitems: [item])
        
        // Supplementary Item
        let sizeFooter = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(10))
        let footerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sizeFooter, elementKind: "section-footer-element-kind", alignment: .bottom)
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [footerItem]
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    func postSectionLayout() -> NSCollectionLayoutSection {
        // Item
        let sizeItem = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: sizeItem)
        
        // Group
        let sizeGroup = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: sizeGroup, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
        
        return section
    }
}
