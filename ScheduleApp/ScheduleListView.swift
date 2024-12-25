//
//  ScheduleListView.swift
//  ScheduleApp
//
//  Created by lonely. on 12/24/24.
//


import SwiftUI
import EventKit

struct ScheduleListView: View {
    @Binding var pickedSchedule: [Schedule]
    var body: some View {
        List(pickedSchedule) { schedule in
            Section(header: Text("Group \(schedule.group) - \(schedule.weekDay.capitalized)").foregroundStyle(.black)) {
                ForEach(Array(zip(schedule.lessons, schedule.times)), id: \.0) { lesson, time in
                    HStack {
                        Text(lesson)
                        Spacer()
                        Text(time)
                    }
                    .contextMenu(menuItems: {
                        ForEach(Array(zip(schedule.lessons, schedule.teachers)), id: \.0){ l, teacher in
                            if l==lesson {
                                Text("Преподаватель:\(teacher)")
                                
                            }
                        }
                        Divider()
                        ForEach(Array(zip(schedule.lessons, schedule.fullTimes)), id: \.0){ l, fullTime in
                            if l==lesson {
                                Text("Время:\(fullTime)")
                                
                            }
                        }
                        Divider()
                        ForEach(Array(zip(schedule.lessons, schedule.rooms)), id: \.0){ l, room in
                            if l==lesson {
                                Text("Аудитория:\(room)")
                                
                            }
                        }
                    }).buttonStyle(.borderedProminent)
                        .transition(.slide)
                    .frame(minHeight: 30)
                }
            }
        }
        .backgroundStyle(.white)
        .listStyle(InsetGroupedListStyle())
    }
}
