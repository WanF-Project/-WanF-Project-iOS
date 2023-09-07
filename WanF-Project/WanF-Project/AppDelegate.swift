//
//  AppDelegate.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/01.
//

import UIKit
import UserNotifications

import Firebase
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [ .badge, .alert, .sound ]) { granted, error in
            
        }
        
        // Delegate 연결 시 자동으로 APNs이 FCM으로 device token 전송
        Messaging.messaging().delegate = self
        application.registerForRemoteNotifications() // deviceToken을 요청하는 메서드
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // APN가 성공적으로 등록되면 아래 메서드를 통해 deviceToken이 전달
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("DeviceToken: \(deviceToken)")
    }
    
    // APN 등록을 실패하면 호출되는 메서드
    // 사용자의 기기가 네트워크에 연결되어 있지 않다면 기기 등록 실패할 수 있다
    // 앱이 적절한 code-signing entitlement를 갖지 못했다면 실패할 수 있다
    // 그러면 앱은 후에 다시 시도한다
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Error: \(error)")
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // 앱이 실행되고 있는 동안 알림이 올 경우 호출되는 메서드
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [ .banner, .sound ]
    }
    
    // 앱이 backgorund에 있는 동안 알림이 올 경우 호출되는 메서드
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo
        let scene = UIApplication.shared.connectedScenes.first
        guard let sceneDelegate = scene?.delegate as? SceneDelegate else { return }
        print(userInfo)
        
        if let senderProfileId = userInfo["senderProfileId"] as? String {
            sceneDelegate.pushToViewController(.messages, id: Int(senderProfileId)!)
        }
        else if let postId = userInfo["postId"] as? String {
            sceneDelegate.pushToViewController(.friends, id: Int(postId)!)
        }
    }
    
    // 사용자가 알림을 tap할때 호출되는 자동 푸시 알림 처리
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
        print("didReceiveRemoteNotification \(userInfo)")
        
        return UIBackgroundFetchResult.newData
    }
}

extension AppDelegate: MessagingDelegate {
    // 앱 시작 시 새로운 또는 기존의 FCM 토큰을 반환한다
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("FcmToken \(fcmToken)")
        
    }
}
