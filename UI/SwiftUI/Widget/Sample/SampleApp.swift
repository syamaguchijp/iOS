//
//  SampleApp.swift
//  Sample
//
//  Created by Yamaguchi on 2022/06/22.
//

import SwiftUI
import WidgetKit

@main
struct SampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    // WidgetのTimelineを更新する要請をする（無くても大丈夫だが）
                    WidgetCenter.shared.reloadAllTimelines()
                }
                .onOpenURL { url in
                    print("onOpenURL \(url)")
                }
        }
    }
}
