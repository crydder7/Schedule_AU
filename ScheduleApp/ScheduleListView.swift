import SwiftUI
import EventKit

struct ScheduleListView: View {
    @Binding var group: String
    @Binding var weekDays: [WeekDays]
    @Binding var pickedDay: String
    @State var textColor: [Color] = [.blue, .red]
    @State var isVariable: Bool = false
    
    var body: some View {
        
        if weekDays.isEmpty{
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Text("Выберете день и группу")
                        .foregroundStyle(.black)
                        .font(.title)
                    Spacer()
                }
                Spacer()
            }
            .background(.blue, in: .rect(cornerRadius: 10))
            .transition(.slide)
            .padding()
        } else{
            List(weekDays) { weekDay in
                if weekDay.lessons.isEmpty{
                    Section("Group: \(group) - \(weekDay.dayOfWeek.uppercased())"){
                        Text("Сегодня нет пар, можно отдыхать!")
                            .font(.title)
                            .foregroundStyle(.black)
                            .multilineTextAlignment(.center)
                        
                        
                        Image(systemName: "calendar")
//                            .symbolEffect(.bounce.up.byLayer, options: .nonRepeating)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .font(.system(size: 70))
                            .foregroundStyle(.blue)
                            .multilineTextAlignment(.center)
                            .contentTransition(.symbolEffect(.replace))
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
                                Text("Аудитория: \(lesson.room)").foregroundColor(.red)
                                Divider()
                                Text("Преподаватель: \(lesson.teacher)").foregroundColor(.blue)
                                Divider()
                                Text("Время: \(lesson.fullTime)").foregroundStyle(.green)
                            }
                        }
                    }
                }
            }
            .background(.blue, in: .rect(cornerRadius: 10))
            .listStyle(InsetGroupedListStyle())
            .contentTransition(.identity)
            .transition(.slide)
        }
    }
}

//#Preview {
//    ScheduleListView(lessons: , group: , weekDay: )
//}
