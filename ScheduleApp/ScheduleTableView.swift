import SwiftUI

struct ScheduleTableView: View {
    @Binding var weekDays: [WeekDays]
    @Binding var pickedDay: String
    @Binding var group: String
    @State var animateSymbol: Bool = false
    
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
            Table(of: WeekDays.self) {
                TableColumn("Lessons") { day in
                    Text("Group: \(group) - \(day.dayOfWeek)")
                        .font(.title2)
                        .fontWeight(.bold)
                    if day.lessons.isEmpty {
                        HStack{
                            Text("Сегодня нет пар, можно отдыхать!")
                                .font(.title)
                                .foregroundStyle(.black)
                                .multilineTextAlignment(.center)
                            
                            Image(systemName: animateSymbol ? "calendar.badge.checkmark" : "calendar")
                                .symbolEffect(.bounce.up.byLayer, options: .nonRepeating)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .font(.system(size: 70))
                                .foregroundStyle(.blue)
                                .multilineTextAlignment(.center)
                                .contentTransition(.symbolEffect(.replace))
                                .onAppear(){
                                    animateSymbol = true
                                }
                        }
                        .background(.white, in: .rect(cornerRadius: 10))
                    } else{
                        ForEach(day.lessons) { lesson in
                            HStack{
                                Text("\(lesson.name)")
                                    .multilineTextAlignment(.leading)
                                Spacer()
                                Text("\(lesson.time)")
                                    .multilineTextAlignment(.trailing)
                            }
                            .background(.white, in: .rect(cornerRadius: 10))
                        }
                    }
                }
            } rows: {
                ForEach(weekDays){ day in
                    TableRow(day)
                }
            }
            .background(.blue, in: .rect(cornerRadius: 10))
            .tableColumnHeaders(.visible)
            .tableStyle(.inset)
            .contentTransition(.identity)
            .transition(.slide)
        }
    }
}

