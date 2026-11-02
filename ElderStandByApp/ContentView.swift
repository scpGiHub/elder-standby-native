
import SwiftUI
import UIKit

private enum Colors {
    static let background = Color(red: 0.031, green: 0.051, blue: 0.086)
    static let panel = Color(red: 0.063, green: 0.094, blue: 0.149)
    static let gold = Color(red: 1.0, green: 0.898, blue: 0.635)
}

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            let landscape = geometry.size.width > geometry.size.height

            Group {
                if landscape {
                    HStack(spacing: 6) {
                        clockPanel()
                        calendarPanel()
                    }
                } else {
                    VStack(spacing: 6) {
                        clockPanel()
                        calendarPanel()
                    }
                }
            }
            .padding(6)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Colors.background.ignoresSafeArea())
        .preferredColorScheme(.dark)
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear {
            UIApplication.shared.isIdleTimerDisabled = false
        }
    }

    private func clockPanel() -> some View {
        GeometryReader { geometry in
            TimelineView(.periodic(from: .now, by: 1)) { timeline in
                let large = min(
                    geometry.size.width * 0.56,
                    geometry.size.height * 0.80
                )

                Text(CalendarInfo.time(timeline.date))
                    .font(.system(
                        size: large,
                        weight: .heavy,
                        design: .rounded
                    ))
                    .monospacedDigit()
                    .lineLimit(1)
                    .minimumScaleFactor(0.42)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 3)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Colors.panel,
            in: RoundedRectangle(cornerRadius: 18)
        )
    }

    private func calendarPanel() -> some View {
        GeometryReader { geometry in
            TimelineView(.periodic(from: .now, by: 60)) { timeline in
                let large = min(
                    geometry.size.width * 0.245,
                    geometry.size.height * 0.31
                )

                VStack(spacing: max(3, geometry.size.height * 0.012)) {
                    Text(CalendarInfo.gregorian(timeline.date))
                        .font(.system(size: large, weight: .heavy))
                        .lineLimit(1)
                        .minimumScaleFactor(0.38)

                    Text(CalendarInfo.weekday(timeline.date))
                        .font(.system(size: large, weight: .heavy))
                        .lineLimit(1)
                        .minimumScaleFactor(0.38)

                    Text(CalendarInfo.lunar(timeline.date))
                        .font(.system(size: large * 0.78, weight: .bold))
                        .lineLimit(1)
                        .minimumScaleFactor(0.38)
                        .foregroundStyle(Colors.gold)
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 4)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Colors.panel,
            in: RoundedRectangle(cornerRadius: 18)
        )
    }
}

#Preview {
    ContentView()
}
