
import SwiftUI
import WidgetKit

struct ElderCalendarEntry: TimelineEntry {
    let date: Date
}

struct ElderCalendarProvider: TimelineProvider {
    func placeholder(in context: Context) -> ElderCalendarEntry {
        ElderCalendarEntry(date: Date())
    }

    func getSnapshot(
        in context: Context,
        completion: @escaping (ElderCalendarEntry) -> Void
    ) {
        completion(ElderCalendarEntry(date: Date()))
    }

    func getTimeline(
        in context: Context,
        completion: @escaping (Timeline<ElderCalendarEntry>) -> Void
    ) {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = CalendarInfo.taipei

        let now = Date()
        let startOfToday = calendar.startOfDay(for: now)

        var entries = [ElderCalendarEntry(date: now)]

        for offset in 1...30 {
            if let nextDay = calendar.date(
                byAdding: .day,
                value: offset,
                to: startOfToday
            ) {
                entries.append(ElderCalendarEntry(date: nextDay))
            }
        }

        completion(Timeline(entries: entries, policy: .atEnd))
    }
}

struct ElderCalendarWidgetView: View {
    let entry: ElderCalendarEntry

    var body: some View {
        GeometryReader { geometry in
            let base = min(
                geometry.size.width * 0.34,
                geometry.size.height * 0.265
            )

            let fullLunar = CalendarInfo.lunar(entry.date)
            let lunarDate = fullLunar.hasPrefix("農曆 ")
                ? String(fullLunar.dropFirst(3))
                : fullLunar

            VStack(spacing: max(2, geometry.size.height * 0.012)) {

                Text(CalendarInfo.gregorian(entry.date))
                    .font(.system(
                        size: base * 1.12,
                        weight: .heavy
                    ))
                    .lineLimit(1)
                    .minimumScaleFactor(0.42)

                Text(CalendarInfo.weekday(entry.date))
                    .font(.system(
                        size: base * 1.05,
                        weight: .heavy
                    ))
                    .lineLimit(1)
                    .minimumScaleFactor(0.42)

                (
                    Text("農曆 ")
                        .font(.system(
                            size: base * 0.42,
                            weight: .bold
                        ))
                    +
                    Text(lunarDate)
                        .font(.system(
                            size: base * 0.96,
                            weight: .heavy
                        ))
                )
                .foregroundStyle(
                    Color(red: 1, green: 0.9, blue: 0.64)
                )
                .lineLimit(1)
                .minimumScaleFactor(0.42)
            }
            .foregroundStyle(.primary)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .padding(.horizontal, 3)
            .padding(.vertical, 2)
        }
        .containerBackground(for: .widget) {
            Color(
                red: 0.063,
                green: 0.094,
                blue: 0.149
            )
        }
    }
}

struct ElderCalendarWidget: Widget {
    let kind = "ElderCalendarWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: ElderCalendarProvider()
        ) { entry in
            ElderCalendarWidgetView(entry: entry)
        }
        .configurationDisplayName("長輩大字農曆")
        .description("大字顯示國曆、星期與農曆，支援 iPhone 待機模式。")
        .supportedFamilies([.systemSmall])
        .contentMarginsDisabled()
    }
}

@main
struct ElderCalendarWidgetBundle: WidgetBundle {
    var body: some Widget {
        ElderCalendarWidget()
    }
}

#Preview(as: .systemSmall) {
    ElderCalendarWidget()
} timeline: {
    ElderCalendarEntry(date: Date())
}
