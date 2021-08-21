//
//  SampleApp.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/21.
//

import SwiftUI

@main
struct SampleApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        /*
        WindowGroup {
            ContentView()
        }*/
        WindowGroup {
            ContentView()
                .onAppear {
                    print("ContentView appeared")
                }.onDisappear {
                    print("ContentView disappeared")
                }
                .onChange(of:scenePhase) { newScenePhase in
                    switch newScenePhase{
                    case.background:
                        print("App background")
                    case.inactive:
                        print("App inactive")
                    case.active:
                        print("App active")
                    @unknown default:
                        fatalError()
                    }
                }
                .onOpenURL { url in
                  print("onOpenURL \(url)")
                }
        }               
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("\(String(describing: type(of: self))) \(#function)")
        return true
    }
}
