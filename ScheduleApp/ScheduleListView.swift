import SwiftUI
import EventKit

struct ScheduleListView: View {
    @Binding var group: String
    @Binding var weekDays: [WeekDays]
    @Binding var pickedDay: String
    
    var body: some View {
        
        if pickedDay == "full week"{
            List(weekDays) { weekDay in
                if weekDay.lessons.isEmpty{
                    Section("Group: \(group) - \(weekDay.dayOfWeek.uppercased())"){
                        Text("Сегодня нет пар, можно отдыхать!")
                            .font(.title)
                            .foregroundStyle(.black)
                            .multilineTextAlignment(.center)
                        Image(systemName: "heart.fill")
                            .symbolEffect(.bounce.up.byLayer, options: .nonRepeating)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .font(.system(size: 70))
                            .foregroundStyle(.red)
                            .multilineTextAlignment(.center)
                    }
                } else{
                    Section("Group: \(group) - \(weekDay.dayOfWeek.uppercased())"){
                        ForEach(weekDay.lessons) { lesson in
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
            .transition(.slide)
            .listStyle(InsetGroupedListStyle())
            .background(.blue, in: .rect(cornerRadius: 10))
        } else{
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
                if weekDays[0].lessons.isEmpty{
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            Text("Сегодня нет пар, можно отдыхать!")
                                .font(.title)
                                .foregroundStyle(.black)
                            Spacer()
                        }
                        Image(systemName: "heart.fill")
                            .symbolEffect(.bounce.up.byLayer, options: .nonRepeating)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .font(.system(size: 70))
                            .foregroundStyle(.red)
                        Spacer()
                    }
                    .background(.blue, in: .rect(cornerRadius: 10))
                    .transition(.slide)
                    .padding()
                } else{
                    VStack{
                        Section("Group \(group) - \(pickedDay.uppercased())"){
                            List(weekDays[0].lessons) { lesson in
                                HStack{
                                    Text(lesson.name)
                                    Spacer()
                                    Text(lesson.time)
                                }
                                .contextMenu {
                                    Text("Преподаватель: \(lesson.teacher)")
                                    Divider()
                                    Text("Время: \(lesson.fullTime)")
                                    Divider()
                                    Text("Аудитория: \(lesson.room)")
                                }
                            }
                            .listStyle(InsetGroupedListStyle())
                        }
                        .background(.blue, in: .rect(cornerRadius: 10))
                        .transition(.slide)
                    }
                }
            }
        }
    }
}

//#Preview {
//    ScheduleListView(lessons: , group: , weekDay: )
//}
