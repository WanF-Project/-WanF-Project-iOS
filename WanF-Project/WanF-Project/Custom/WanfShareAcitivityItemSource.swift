//
//  WanfShareAcitivityItemSource.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/19.
//

import UIKit
import LinkPresentation

/// 강의 모임 공유 시 사용되는 Custom ActivituItemSource
class WanfShareActivityItemSource: NSObject, UIActivityItemSource {
    
    private let title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return title
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return title
    }
    
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        metadata.originalURL = URL(string: "https://github.com/WanF-Project/WanF-Project-iOS")
        metadata.url = metadata.originalURL
        metadata.title = self.title
        
        let representationImage = NSItemProvider(object: UIImage(named: "AppIcon") ?? UIImage())
        metadata.imageProvider = representationImage
        metadata.iconProvider = representationImage
        
        return metadata
    }
}
