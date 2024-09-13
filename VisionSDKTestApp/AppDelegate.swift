//
//  AppDelegate.swift
//  VisionSDKTestApp
//
//  Created by Guillaume Laurent on 26/08/2024.
//

import UIKit
import SightcallVision

/**
 Example of full implementation of AppDelegate as required by the VisionSDK.

 See below for a simpler implementation, leveraging SightcallSDKAppDelegate, a convenience AppDelegate
 implementation included in the VisionSDK
 */
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    public var sdkLayer: SightCallSDKManager!

    public override init() {
        super.init()
        sdkLayer = SightCallSDKManager(delegate: self)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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

    open func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        sdkLayer.handleShortcut(shortcutItem, completionHandler: completionHandler)
    }

    open func applicationDidEnterBackground(_ application: UIApplication) {
        sdkLayer.resetAndCancel()
    }

    open func applicationWillTerminate(_ application: UIApplication) {
        sdkLayer.disconnect()
    }

    open func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        SightCallSDKManager.updatePushNotificationToken(deviceToken)
    }

    open func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: any Error) {
        SightCallSDKManager.failedToRegisterForRemoteNotifications(error)
    }

    open func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let stringUserInfo = userInfo as? [String: Any] {
            sdkLayer.apnsPayloadAvailable(stringUserInfo, fetchCompletionHandler: completionHandler)
        }
    }

}

// Make sure app fails with useful error if SightCallSDKManager.delegate is not set
//
extension AppDelegate: SightCallSDKManagerDelegate {
    public func sdkManagerParentViewController() -> UINavigationController? {
        fatalError("delegate not set on SightcallSDKAppDelegate.sdkLayer. You need to set sdkLayer.delegate to a class implementing SightCallSDKManagerDelegate.")
    }
}

/**
 Simpler implementation of AppDelegate, using SightcallSDKAppDelegate
 */
//class AppDelegate: SightcallSDKAppDelegate {
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//        return true
//    }
//
//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
//}

