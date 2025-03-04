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
        sdkLayer = SightCallSDKManager(delegate: nil) // delegate is set afterwards by ViewController
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        sdkLayer.updateApplicationMenu()

        if let url = sdkLayer?.defaultStartupUrl {
            DispatchQueue.main.async {
                self.sdkLayer?.startSdk(url: url, data: nil, forceReload: false)
            }
        }

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

    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        sdkLayer.resetAndCancel()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        sdkLayer.disconnect()
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        SightCallSDKManager.updatePushNotificationToken(deviceToken)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: any Error) {
        SightCallSDKManager.failedToRegisterForRemoteNotifications(error)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let stringUserInfo = userInfo as? [String: Any] {
            sdkLayer.apnsPayloadAvailable(stringUserInfo, fetchCompletionHandler: completionHandler)
        }
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

