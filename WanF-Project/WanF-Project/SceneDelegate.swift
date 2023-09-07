//
//  SceneDelegate.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/01.
//

import UIKit

/// 알람 타입
enum NotificationType {
    case friends
    case messages
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    public static let shared = SceneDelegate()
    
    var window: UIWindow?
    let rootViewModel = SignInViewModel()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let rootViewController = SignInViewController()
        rootViewController.bind(rootViewModel)
        
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        window?.makeKeyAndVisible()
    }
    
    func updateRootViewController(_ rootViewController: UIViewController) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        
        guard let window = self.window else { return }
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    /// 알람 타입에 따른 화면 전환 작업
    func pushToViewController(_ type: NotificationType, id: Int) {
        switch type {
        case .friends:
            rootViewModel.mainTabViewModel.friendsMaychViewModel.friendsMatchListItemSelected.accept(id)
        case .messages:
            rootViewModel.mainTabViewModel.messageListViewModel.didSelectItem.accept(id)
        }
    }
}
