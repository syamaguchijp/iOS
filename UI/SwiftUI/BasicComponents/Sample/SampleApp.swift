//
//  SampleApp.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/19.
//

import SwiftUI

@main
struct SampleApp: App {
    @Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onChange(of:scenePhase){newScenePhase in
                    switch newScenePhase{
                    case.background:
                        print("background")
                    case.inactive:
                        print("inactive")
                    case.active:
                        print("active")
                    @unknown default:
                        fatalError()
                    }
                }
        }
    }
}
