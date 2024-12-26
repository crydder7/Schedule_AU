import Foundation
import EventKit

class CalendarManager: ObservableObject {
    let eventStore = EKEventStore()
    
    func requestAccess(completion: @escaping (Bool, Error?) -> Void) {
        eventStore.requestFullAccessToEvents(){granted, error in
            DispatchQueue.main.async {
                completion(granted, error)
            }
        }
    }
    func createEvent(title: String, startDate: Date, endDate: Date, completion: @escaping (Bool, Error?) -> Void) {
        let event = EKEvent(eventStore: eventStore)
        
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.calendar = eventStore.defaultCalendarForNewEvents
        
        do {
            try eventStore.save(event, span: .thisEvent)
            completion(true, nil)
        } catch {
            completion(false, error)
        }
    }
}

struct Schedule: Decodable, Identifiable {
    var id = UUID()
    var group: String
    var weekDays: [WeekDays]
    private enum CodingKeys : String, CodingKey { case group, weekDays }
}

struct ScheduleFull: Decodable, Identifiable {
    var id = UUID()
    var schedule: [Schedule]
    private enum CodingKeys : String, CodingKey { case schedule }
}

struct WeekDays: Decodable, Identifiable{
    var id = UUID()
    var dayOfWeek: String
    var lessons: [Lesson]
    private enum CodingKeys : String, CodingKey { case dayOfWeek, lessons }
}

struct Lesson: Decodable, Identifiable{
    var id = UUID()
    var name: String
    var room: String
    var time: String
    var fullTime: String
    var teacher: String
    private enum CodingKeys : String, CodingKey { case name, room, time, fullTime, teacher}
}
