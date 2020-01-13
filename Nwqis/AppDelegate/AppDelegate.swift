//
//  AppDelegate.swift
//  Nwqis
//
//  Created by Farido on 11/19/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import UserNotifications
import FirebaseInstanceID
import FirebaseMessaging
import FacebookCore
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let gcmMessageIDKey = "gcm.message_id"
    var window: UIWindow?
    var countOfAppIconMessage = 0
    var countOfAppIconRequests = 0
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        // [START set_messaging_delegate]
        Messaging.messaging().delegate = self
        // [END set_messaging_delegate]
        // Register for remote notifications. This shows a permission dialog on first run, to
        // show the dialog at a more appropriate time move this registration accordingly.
        // [START register_for_notifications]
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        IQKeyboardManager.shared.enable = true
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        
        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        BarButtonItemAppearance.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -200, vertical: 0), for:UIBarMetrics.default)
        
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        API_Notifactions.countNewMessage(url: URLs.countNewMessages) { (error, success, Data, suscess) in
            self.countOfAppIconMessage = Data ?? 0
            application.applicationIconBadgeNumber = self.countOfAppIconMessage + self.countOfAppIconRequests
        }
        
        API_Notifactions.countNewMessage(url: URLs.countNewNotifications) { (error, success, Data, suscess) in
            self.countOfAppIconRequests = Data ?? 0
            application.applicationIconBadgeNumber = self.countOfAppIconMessage + self.countOfAppIconRequests
        }
        
        return true
    }
    
    func getCountOfMessages(){
        API_Notifactions.countNewMessage(url: URLs.countNewMessages) { (error, success, Data, suscess) in
            self.countOfAppIconMessage = Data ?? 0
        }
        
    }
    
    func getCountOfRequests(){
        API_Notifactions.countNewMessage(url: URLs.countNewNotifications) { (error, success, Data, suscess) in
            self.countOfAppIconRequests = Data ?? 0
        }
        
    }
    
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        guard let urlScheme = url.scheme else { return false }
        if urlScheme.hasPrefix("fb") {
            return ApplicationDelegate.shared.application(app, open: url, options: options)
        }
        return true
    }
    
    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print("ssssssss\(userInfo)")
    }
    
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print("ssssssss\(userInfo)")
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    // [END receive_message]
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the FCM registration token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        
        // With swizzling disabled you must set the APNs token here.
        // Messaging.messaging().apnsToken = deviceToken
    }
}

// This method will be called when app received push notifications in foreground
extension AppDelegate {
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
//    {
//        completionHandler([.alert, .badge, .sound])
//    }
}
// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        let application = UIApplication.shared
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        completionHandler([.alert, .badge, .sound])
        // Print full message.
        print("llllll\(userInfo)")
        API_Notifactions.countNewMessage(url: URLs.countNewMessages) { (error, success, Data, suscess) in
            self.countOfAppIconMessage = Data ?? 0
            application.applicationIconBadgeNumber =  self.countOfAppIconMessage + self.countOfAppIconRequests
        }
        
        API_Notifactions.countNewMessage(url: URLs.countNewNotifications) { (error, success, Data, suscess) in
            self.countOfAppIconRequests = Data ?? 0
            application.applicationIconBadgeNumber = self.countOfAppIconMessage + self.countOfAppIconRequests
        }
        // Change this to your preferred presentation option
        completionHandler([])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,didReceive response: UNNotificationResponse,withCompletionHandler completionHandler: @escaping () -> Void) {
        let application = UIApplication.shared
        
        if(application.applicationState == .active){
            
            print("user tapped the notification bar when the app is in foreground")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            // instantiate the view controller from storyboard
            if  let conversationVC = storyboard.instantiateViewController(withIdentifier: "controller1VC") as? profileVC {
                
                // set the view controller as root
                self.window?.rootViewController = conversationVC
            }
            
            
        }
        
        if(application.applicationState == .inactive)
        {
            print("user tapped the notification bar when the app is in background")
        }
        
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print("hhhh\(userInfo)")
        
        completionHandler()
    }
}
// [END ios_10_message_handling]
extension AppDelegate : MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        API_Notifactions.sendKayFireBase(firebaseToken: fcmToken) { (error, succes, data, states) in
            if succes {
                if states == true {
                    print(data ?? "")
                }
            }
        }
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    // [END refresh_token]
    // [START ios_10_data_message]
    // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
    // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(String(describing: remoteMessage.appData["notification"]))")
    }
    // [END ios_10_data_message]
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


