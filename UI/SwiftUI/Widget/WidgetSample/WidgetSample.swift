//
//  WidgetSample.swift
//  WidgetSample
//
//  Created by Yamaguchi on 2022/06/22.
//

import WidgetKit
import SwiftUI
import Intents

// Providerは、Widgetを更新するためのTimelineを決定する
struct Provider: IntentTimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        
        SimpleEntry(date: Date(), memo: "", configuration: ConfigurationIntent())
    }

    // Widgetをプレビューするときにコールされる
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        
        let entry = SimpleEntry(date: Date(), memo: "",  configuration: configuration)
        completion(entry)
    }

    // OSから適宜のタイミングでコールされる
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
                                            
        var entries: [SimpleEntry] = []

        // 20分間隔
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 20, to: Date())!
        
        // アプリ本体と共有しているユーザーデフォルトから値を取得して表示するサンプルだが、
        // ここでサーバと通信してデータを取得することを実装することなども可能である。
        let memo = UserDefaultsManager.shared.memo ?? ""
        let entry = SimpleEntry(date: Date(), memo: memo, configuration: configuration)
        entries.append(entry)
        // システム側にTimelineの更新時期を要求するReloadPolicyを設定
        let timeline = Timeline(entries: entries, policy: .after(refreshDate))
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    
    let date: Date
    let memo: String
    let configuration: ConfigurationIntent
}

struct WidgetSampleEntryView : View {
    
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.date, style: .time)
            Text(entry.memo)
        }
        .widgetURL(URL(string: "sampleApp://hoge")) // アプリ本体側のonOpenURLがコールされる
    }
}

@main
struct WidgetSample: Widget {
    let kind: String = "WidgetSample"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WidgetSampleEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget") // 1アプリに複数のWidgetがありえるための識別名
        .description("This is an example widget.")
        //.supportedFamilies([.systemSmall]) // SupportSizeはデフォルトでは大、中、小
    }
}

struct WidgetSample_Previews: PreviewProvider {
    static var previews: some View {
        WidgetSampleEntryView(entry: SimpleEntry(date: Date(), memo: "",  configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
