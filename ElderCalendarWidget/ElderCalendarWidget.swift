import SwiftUI
import WidgetKit

struct ElderCalendarEntry: TimelineEntry {
    let date: Date
}

struct ElderCalendarProvider: TimelineProvider {
    func placeholder(in context: Context) -> ElderCalendarEntry {
        ElderCalendarEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (ElderCalendarEntry) -> Void) {
        completion(ElderCalendarEntry(date: Date()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<ElderCalendarEntry>) -> Void) {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = CalendarInfo.taipei
        let now = Date()
        let startOfToday = calendar.startOfDay(for: now)

        // One entry now, then an entry at the start of each subsequent day.
        // No network requests and no minute-by-minute widget refreshes.
        var entries = [ElderCalendarEntry(date: now)]
        for offset in 1...30 {
            if let nextDay = calendar.date(byAdding: .day, value: offset, to: startOfToday) {
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
            let base = min(geometry.size.width * 0.265, geometry.size.height * 0.245)
            VStack(spacing: max(3, geometry.size.height * 0.018)) {
                Text(CalendarInfo.gregorian(entry.date))
                    .font(.system(size: base, weight: .heavy))
                Text(CalendarInfo.weekday(entry.date))
                    .font(.system(size: base * 0.93, weight: .heavy))
                Text(CalendarInfo.lunar(entry.date))
                    .font(.system(size: base * 0.57, weight: .bold))
                    .foregroundStyle(Color(red: 1, green: 0.9, blue: 0.64))
            }
            .foregroundStyle(.primary)
            .lineLimit(1)
            .minimumScaleFactor(0.60)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 4)
        }
        .containerBackground(for: .widget) {
            Color(red: 0.063, green: 0.094, blue: 0.149)
        }
    }
}

struct ElderCalendarWidget: Widget {
    let kind = "ElderCalendarWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ElderCalendarProvider()) { entry in
            ElderCalendarWidgetView(entry: entry)
        }
        .configurationDisplayName("長輩大字農曆")
        .description("大字顯示國曆、星期與農曆，支援 iPhone 待機模式。")
        .supportedFamilies([.systemSmall])
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
