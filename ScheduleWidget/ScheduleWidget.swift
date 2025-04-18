import WidgetKit
import SwiftUI

//let dateForm: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.locale = Locale(identifier: "ru_RU")
//    return formatter
//}()

let dateForm = DateFormatter()

func loadLessonsFromDefaults(day:String) -> (lessons:[Lesson],group:String) {
    let defaults = UserDefaults(suiteName: "group.dev.kaidder.ScheduleApp")
    guard let group = defaults!.string(forKey: "favGroup") else {
        return ([Lesson(name: "No such group", room: "", time: "Error", fullTime: "", teacher: "")],"0")
    }
    if let data = defaults?.data(forKey: "\(day)_\(group)") {
        let decoder = JSONDecoder()
        if let lessons = try? decoder.decode([Lesson].self, from: data) {
            return (lessons,group)
        }
    }
    return ([lessonPlaceholder],"0")
}

let lessonPlaceholder = Lesson(name: "Мат.Анализ", room: "431СЛК", time: "10:00", fullTime: "-", teacher: "-")

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), lessons: [lessonPlaceholder], group: "0")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), lessons: [lessonPlaceholder], group: "0")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [SimpleEntry] = []
        let calendar = Calendar.current
        let nextMidnight = calendar.nextDate(after: Date(), matching: DateComponents(hour: 0), matchingPolicy: .nextTime)!
        let currentDate = Date()
        let weekDay = Calendar.current.component(.weekday, from: currentDate) - 1
        let day = dateForm.weekdaySymbols[weekDay].lowercased()
//        let days: (String, String, String, String)
//        days.0 = dateForm.weekdaySymbols[weekDay].lowercased()
//        days.1 = dateForm.weekdaySymbols[weekDay+1].lowercased()
//        days.2 = dateForm.weekdaySymbols[weekDay+2].lowercased()
//        days.3 = dateForm.weekdaySymbols[weekDay+3].lowercased()
//        let lessonsAll: ([Lesson],[Lesson],[Lesson],[Lesson])
//        lessonsAll.0 = loadLessonsFromDefaults(day: days.0).lessons
//        lessonsAll.1 = loadLessonsFromDefaults(day: days.1).lessons
//        lessonsAll.2 = loadLessonsFromDefaults(day: days.2).lessons
//        lessonsAll.3 = loadLessonsFromDefaults(day: days.3).lessons
        let parsedData = loadLessonsFromDefaults(day: day)
        let lessons = parsedData.lessons
        let group = parsedData.group
        let nextUpdate = Calendar.current.date(byAdding: .day, value: 1, to: nextMidnight)!
//         Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        for dayOffset in 0 ..< 7 {
//            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, lessons: lessons)
//            entries.append(entry)
//        }
        let entry = SimpleEntry(date: currentDate, lessons: lessons, group: group)
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let lessons: [Lesson]
//    let lessons: (today:[Lesson],tommorow:[Lesson],thirdDay:[Lesson],fourthDay:[Lesson])
    let group: String
//    let days: (String, String, String, String)
}

struct ScheduleWidgetView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family{
        case .systemSmall: ScheduleWidgetSmallView(lessons: entry.lessons, group: entry.group)
        case .systemMedium: ScheduleWidgetMediumView(lessons: entry.lessons, group: entry.group)
        case .systemLarge: ScheduleWidgetLargeView(lessons: entry.lessons, group: entry.group)
//        case .systemExtraLarge: ScheduleWidgetExtraLargeView(lessons: entry.lessons, group: entry.group, days: entry.days)
        default: ScheduleWidgetMediumView(lessons: entry.lessons, group: entry.group)
        }
    }
}

struct ScheduleWidget: Widget {
    let kind: String = "ScheduleWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                ScheduleWidgetView(entry: entry)
                        .containerBackground(.fill.tertiary, for: .widget)
            } else {
                ScheduleWidgetView(entry: entry)
                        .padding()
                        .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

//#Preview(as: .systemSmall) {
//    ScheduleWidget()
//} timeline: {
//    SimpleEntry(date: .now, lessons: loadLessonsFromDefaults(day: "monday").lessons, group: "302", days: ("monday", "tuesday", "wednesday", "thursday"))
//    SimpleEntry(date: .now, lessons: [], group: "0")
//}
