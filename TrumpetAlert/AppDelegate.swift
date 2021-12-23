//
//  AppDelegate.swift
//  TrumpetAlert
//
//  Created by reza wanted on 9/18/1400 AP.
//

import UIKit
import Firebase
import FirebaseAnalytics
import IQKeyboardManagerSwift
import SwiftyJSON



@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let defult = UserDefaults.standard
    
    var list_json : [JSON] = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self

        // 2
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions) { _, _ in }
        // 3
        application.registerForRemoteNotifications()
        
        
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


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    
  func userNotificationCenter(_ center: UNUserNotificationCenter,willPresent notification: UNNotification,withCompletionHandler completionHandler:@escaping (UNNotificationPresentationOptions) -> Void) {
    print("data is = >" , JSON(notification.request.content.userInfo))
    print("data2 is = >" , notification.request.content.userInfo as! [String: AnyObject])
    let defult = UserDefaults.standard
    let json1 = JSON(notification.request.content.userInfo)
      
      
  //    let aps = JSON(notification.request.content.userInfo["aps"])
      
   //   let json = JSON(notification.request.content.userInfo)
      
      list_json = getJSON("list_json")?.array ?? []
      if list_json.contains(json1) {
          print("yes")
      }else{
          list_json.append(json1)
      }
    //  defult.set(list_json, forKey: "list_json")
      saveJSON(json: JSON(list_json), key: "list_json")
      print("data is = >" , JSON(notification.request.content.userInfo))

      NotificationCenter.default.post(name: Notification.Name(rawValue: "refresh1"), object: nil)
      
    if #available(iOS 14.0, *) {
        completionHandler([[.banner, .sound]])
    } else {
        // Fallback on earlier versions
    }
  }
    
    func application(
      _ application: UIApplication,
      didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
      Messaging.messaging().apnsToken = deviceToken
    }

  func userNotificationCenter(_ center: UNUserNotificationCenter,didReceive response: UNNotificationResponse,withCompletionHandler completionHandler: @escaping () -> Void) {
      
      let aps = JSON(response.notification.request.content.userInfo["aps"])
      print("data is = >" , JSON(response.notification.request.content.userInfo))
      
      let json1 = JSON(response.notification.request.content.userInfo)
      
      list_json = getJSON("list_json")?.array ?? []
      if list_json.contains(json1) {
          print("yes")
      }else{
          list_json.append(json1)
      }
      saveJSON(json: JSON(list_json), key: "list_json")
      
      NotificationCenter.default.post(name: Notification.Name(rawValue: "refresh1"), object: nil)
      
    completionHandler()
  }
    
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        let json1 = JSON(userInfo)
        
        list_json = getJSON("list_json")?.array ?? []
        if list_json.contains(json1) {
            print("yes")
        }else{
            list_json.append(json1)
        }
        saveJSON(json: JSON(list_json), key: "list_json")
  

        NotificationCenter.default.post(name: Notification.Name(rawValue: "refresh1"), object: nil)
      /*
        guard let aps = userInfo["aps"] as? [String: AnyObject] else {
            completionHandler(.failed)
            return
          }
        */
        
        

        
       //handle the content here...

    }
}



extension AppDelegate: MessagingDelegate {
  func messaging(
    _ messaging: Messaging,
    didReceiveRegistrationToken fcmToken: String?
  ) {
    let tokenDict = ["token": fcmToken ?? ""]
    print("fbc token = >" ,fcmToken)
    Messaging.messaging().subscribe(toTopic: "FilamingoIOS")
    let defult = UserDefaults.standard
    defult.set(fcmToken, forKey: "fcmToken")
   

  }
    

}

