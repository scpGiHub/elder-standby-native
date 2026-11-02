import Foundation

/// Traditional Chinese / Taiwan dates. All calculations are local; no network is used.
enum CalendarInfo {
    static let taipei = TimeZone(identifier: "Asia/Taipei")!
    static let taiwanLocale = Locale(identifier: "zh_TW")

    static func time(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.timeZone = taipei
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

    static func gregorian(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = taiwanLocale
        formatter.timeZone = taipei
        formatter.dateFormat = "M月d日"
        return formatter.string(from: date)
    }

    static func weekday(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = taiwanLocale
        formatter.timeZone = taipei
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }

    static func lunar(_ date: Date) -> String {
        var calendar = Calendar(identifier: .chinese)
        calendar.timeZone = taipei
        let components = calendar.dateComponents([.month, .day, .isLeapMonth], from: date)
        guard let month = components.month, let day = components.day,
              (1...12).contains(month), (1...30).contains(day) else {
            return "農曆日期未提供"
        }
        let monthNames = ["正", "二", "三", "四", "五", "六", "七", "八", "九", "十", "冬", "臘"]
        let prefix = (components.isLeapMonth == true) ? "閏" : ""
        return "農曆 \(prefix)\(monthNames[month - 1])月\(lunarDay(day))"
    }

    private static func lunarDay(_ day: Int) -> String {
        let digits = ["", "一", "二", "三", "四", "五", "六", "七", "八", "九"]
        switch day {
        case 1...9: return "初" + digits[day]
        case 10: return "初十"
        case 11...19: return "十" + digits[day - 10]
        case 20: return "二十"
        case 21...29: return "廿" + digits[day - 20]
        case 30: return "三十"
        default: return ""
        }
    }
}
