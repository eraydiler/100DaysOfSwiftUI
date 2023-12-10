//
//  LocalNotifications.swift
//  HotProspects
//
//  Created by Eray Diler on 10.12.2023.
//

import SwiftUI
import UserNotifications

/**
  Important: Once the notification has been added press Cmd+L in the simulator to lock the
             screen. After a few seconds have passed the device should wake up with a sound,
             and show the message.
 */
struct LocalNotificationsView: View {
    var body: some View {
        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter
                    .current()
                    .requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("All set!")
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                    }
            }

            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default

                // show this notification five seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                // choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                // add our notification request
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

#Preview {
    LocalNotificationsView()
}
