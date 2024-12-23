import Foundation

struct Schedule: Decodable, Identifiable {
    var id = UUID()
    var group: String
    var weekDay: String
    var lessons: [String]
    var times: [String]
    var fullTimes: [String]
    var teachers: [String]
    private enum CodingKeys : String, CodingKey { case group, weekDay, lessons, times, fullTimes, teachers }
}

struct ScheduleFull: Decodable, Identifiable {
    var id = UUID()
    var schedule: [Schedule]
    private enum CodingKeys : String, CodingKey { case schedule }
}
