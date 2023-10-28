//
//  FriendsMultipleListView.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/01.
//

import UIKit

class FriendsMultipleListView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero, collectionViewLayout: .init())
        self.collectionViewLayout = layout()
        configure()
    }
}

private extension FriendsMultipleListView {
    func configure() {
        self.backgroundColor = .wanfBackground
        self.register(FriendsMatchListCell.self, forCellWithReuseIdentifier: "FriendsMatchListCell")
    }
}

// CollectionView Compositional Layout
private extension FriendsMultipleListView {
    func layout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout(section: postSectionLayout())
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
