//
//  WorkTimeTrackerProApp.swift
//  WorkTimeTrackerPro
//
//  Created by Bootan Majeed on 2023-11-19.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
          return true
  }
}

@main
struct WorkTimeTrackerProApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    

    var body: some Scene {
        WindowGroup {
            StartView()
        }
    }
}
