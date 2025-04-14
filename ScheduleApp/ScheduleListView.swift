import SwiftUI
import EventKit
import SwiftData

struct ScheduleListView: View {
    @Binding var group: String
    @Binding var weekDays: [WeekDays]
    @Binding var pickedDay: String
    @State var textColor: [Color] = [.blue, .red]
    @State var isVariable: Bool = false
    @State var animateSymbol: Bool = false
    @Environment(\.modelContext) private var context
    
    var body: some View {
            List(weekDays) { weekDay in
                if weekDay.lessons.isEmpty{
                    Section("Group: \(group) - \(weekDay.dayOfWeek.uppercased())"){
                        HStack{
                            Text("Сегодня нет пар, можно отдыхать!")
                                .font(.title)
                                .multilineTextAlignment(.center)
                            Spacer()
                            Image(systemName: animateSymbol ? "calendar.badge.checkmark" : "calendar")
                                .renderingMode(.template)
                                .symbolEffect(.bounce.up.byLayer, value: animateSymbol)
                                .aspectRatio(contentMode: .fit)
                                .font(.system(size: 70))
                                .foregroundStyle(.blue)
                                .multilineTextAlignment(.center)
                                .contentTransition(.symbolEffect(.replace))
                                .onAppear(){
                                    animateSymbol = true
                                }
                        }
                    }
                    .multilineTextAlignment(.center)
                } else{
                    Section("Group: \(group) - \(weekDay.dayOfWeek.uppercased())"){
                        ForEach(weekDay.lessons) {lesson in
                            HStack{
                                Text(lesson.name)
                                Spacer()
                                Text(lesson.time)
                            }
                            .contextMenu {
                                Label(lesson.room, systemImage: "location.fill")
                                Divider()
                                Label(lesson.teacher, systemImage: "person.fill")
                                Divider()
                                Label(lesson.fullTime, systemImage: "clock.fill")
                            }
                        }
                    }
                    .multilineTextAlignment(.center)
                }
            }
            .listStyle(.insetGrouped)
            .background(.blue, in: .rect(cornerRadius: 10))
            .contentTransition(.identity)
            .transition(.scale)
    }
}

//#Preview {
//    ScheduleListView(lessons: , group: , weekDay: )
//}
