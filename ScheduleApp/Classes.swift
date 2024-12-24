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
    var weekDay: String
    var lessons: [String]
    var times: [String]
    var fullTimes: [String]
    var teachers: [String]
    var rooms: [String]
    private enum CodingKeys : String, CodingKey { case group, weekDay, lessons, times, fullTimes, teachers, rooms }
}

struct ScheduleFull: Decodable, Identifiable {
    var id = UUID()
    var schedule: [Schedule]
    private enum CodingKeys : String, CodingKey { case schedule }
}

