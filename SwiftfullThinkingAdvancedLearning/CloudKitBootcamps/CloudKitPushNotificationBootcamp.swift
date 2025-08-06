//
//  CloudKitPushNotificationBootcamp.swift
//  SwiftfullThinkingAdvancedLearning
//
//  Created by Akram Husseini on 06/08/2025.
//

import SwiftUI
import CloudKit

class CloudKitPushNotificationsBootcampViewModel: ObservableObject {
    
    func requestNotificationPermissions() {
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, errror in
            if let error = errror {
                print(error)
            } else if success {
                print("Notification permissions success!")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                print("Notification permissions failure.")
            }
        }
    }
    
    func subscribeToNotifications() {
        
        let predicate = NSPredicate(value: true)
        let subscription = CKQuerySubscription(recordType: "Fruits", predicate: predicate, subscriptionID: "fruit_added_to_database", options: .firesOnRecordCreation)
        
        let notification = CKSubscription.NotificationInfo()
        notification.title = "There is a new fruit!"
        notification.alertBody = "Open the app to check your fruits."
        notification.soundName = "default"
        subscription.notificationInfo = notification
        CKContainer.default().publicCloudDatabase.save(subscription) { returnedSubscription, returnedError in
            if let error = returnedError {
                print(error)
            } else {
                print("Successfully subscribed to notifications!")
            }
            
        }
    }
    
    func unsubscribeToNotifications() {
        
        //        CKContainer.default().publicCloudDatabase.fetchAllSubscriptions
        CKContainer.default().publicCloudDatabase.delete(withSubscriptionID: "fruit_dded_to_database")  { returnedSubscription, returnedError in
            if let error = returnedError {
                print(error)
            } else {
                print("Successfully un-subscribed!")
            }
        }
    }
    
}

struct CloudKitPushNotificationBootcamp: View {
    
    @StateObject private var vm = CloudKitPushNotificationsBootcampViewModel()
    
    var body: some View {
        
        VStack(spacing: 40) {
            
            Button("Request notification permissions") {
                vm.requestNotificationPermissions()
            }
            
            Button("Subscribe to notificaitons") {
                vm.subscribeToNotifications()
            }
            
            Button("unsubscribe to notificaitons") {
                vm.unsubscribeToNotifications()
            }
        }
    }
}

#Preview {
    CloudKitPushNotificationBootcamp()
}
