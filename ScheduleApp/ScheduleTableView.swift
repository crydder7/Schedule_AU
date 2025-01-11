import SwiftUI

struct ScheduleTableView: View {
    @Binding var weekDays: [WeekDays]
    @Binding var pickedDay: String
    @Binding var group: String
    @State var animateSymbol: Bool = false
    
    var body: some View {
        if weekDays.isEmpty{
            PickGroupView()
        } else{
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.blue)
                Table(of: WeekDays.self) {
                    TableColumn("Lessons") { day in
                        Text("GROUP: \(group) - \(day.dayOfWeek.uppercased())")
                            .font(.title2)
                            .fontWeight(.bold)
                        if day.lessons.isEmpty {
                            HStack{
                                Text("Сегодня нет пар, можно отдыхать!")
                                    .font(.title)
                                    .multilineTextAlignment(.center)
                                Spacer()
                                Image(systemName: animateSymbol ? "calendar.badge.checkmark" : "calendar")
                                    .renderingMode(.template)
    //                                .symbolEffect(.bounce.up.byLayer, options: .nonRepeating)
                                    .symbolEffect(.bounce.up.byLayer, value: animateSymbol)
    //                                .aspectRatio(contentMode: .fit)
    //                                .frame(width: 100, height: 100)
                                    .font(.system(size: 70))
                                    .foregroundStyle(.blue)
                                    .multilineTextAlignment(.center)
                                    .contentTransition(.symbolEffect(.replace))
                                    .onAppear{
                                        animateSymbol = true
                                    }
                            }
                        } else{
                            ForEach(day.lessons) { lesson in
                                HStack{
                                    Text("\(lesson.name)")
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                    Text("\(lesson.time)")
                                        .multilineTextAlignment(.trailing)
                                }
                            }
                        }
                    }
                } rows: {
                    ForEach(weekDays){ day in
                        TableRow(day)
                    }
                }
                .tableColumnHeaders(.visible)
                .tableStyle(.inset)
                .clipShape(.rect(cornerRadius: 10))
                .padding()
            }
            .contentTransition(.identity)
            .transition(.scale)
        }
    }
}

