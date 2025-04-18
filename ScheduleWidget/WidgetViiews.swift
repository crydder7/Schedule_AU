//
//  WidgetViiews.swift
//  ScheduleApp
//
//  Created by lonely. on 4/18/25.
//

import SwiftUI

struct ScheduleWidgetSmallView : View {
    var lessons: [Lesson]
    var group: String

    var body: some View {
        VStack{
            if lessons.isEmpty == false{
                HStack{
                    Circle().fill(Color.purple)
                        .frame(width: 7, height: 7)
                    Text("Пары:")
                        .font(.caption)
                        .bold()
                }
                Divider()
                ForEach(lessons) { lesson in
                    HStack{
                        Circle().fill(Color.blue)
                            .frame(width: 5, height: 5)
                        Text(lesson.name)
                        Spacer()
                    }
                    .frame(alignment: .leading)
//                    .font(.system(size: 7))
                    .font(.caption2)
                    Divider()
                }
            } else{
                Text("Сегодня пар нет, отдыхайте!")
                    .font(.caption)
                    .bold()
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct ScheduleWidgetMediumView : View {
    var lessons: [Lesson]
    var group: String

    var body: some View {
        VStack{
            if lessons.isEmpty == false{
                HStack{
                    Circle().fill(Color.purple)
                        .frame(width: 7, height: 7)
                    Text("Пары для группы \(group) на сегодня:")
                        .font(.caption)
                        .bold()
                }
                Divider()
                ForEach(lessons) { lesson in
                    HStack{
                        Circle().fill(Color.blue)
                            .frame(width: 5, height: 5)
                        Text(lesson.time)
                        Divider()
                        Text(lesson.name)
                        Spacer()
                        Divider()
                        Text(lesson.room)
                    }
                    .frame(alignment: .leading)
//                    .font(.system(size: 7))
                    .font(.caption2)
                    Divider()
                }
            } else{
                Text("Сегодня пар нет, отдыхайте!")
                    .font(.caption)
                    .bold()
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct ScheduleWidgetLargeView : View {
    var lessons: [Lesson]
    var group: String

    var body: some View {
        VStack{
            if lessons.isEmpty == false{
                HStack{
                    Circle().fill(Color.purple)
                        .frame(width: 7, height: 7)
                    Text("Пары для группы \(group) на сегодня:")
                        .font(.headline)
                        .bold()
                }
                Divider()
                ForEach(lessons) { lesson in
                    HStack{
                        Circle().fill(Color.blue)
                            .frame(width: 5, height: 5)
                        Text(lesson.time)
                        Divider()
                        Text(lesson.name)
                        Spacer()
                        Divider()
                        Text(lesson.room)
                    }
                    .frame(alignment: .leading)
//                    .font(.system(size: 7))
                    .font(.caption)
                    Divider()
                }
            } else{
                Text("Сегодня пар нет, отдыхайте!")
                    .font(.caption)
                    .bold()
                    .multilineTextAlignment(.center)
            }
        }
    }
}

//struct ScheduleWidgetExtraLargeView : View {
//    var lessons: ([Lesson],[Lesson],[Lesson],[Lesson])
//    var group: String
//    var days: (String, String, String, String)
//
//    var body: some View {
//        VStack{
//            Text("Группа \(group)")
//            HStack{
//                VStack{
//                    if lessons.0.isEmpty == false{
//                        HStack{
//                            Circle().fill(Color.purple)
//                                .frame(width: 7, height: 7)
//                            Text("\(days.0):")
//                                .font(.caption)
//                                .bold()
//                        }
//                        Divider()
//                        ForEach(lessons.0) { lesson in
//                            HStack{
//                                Circle().fill(Color.blue)
//                                    .frame(width: 5, height: 5)
//                                Text(lesson.time)
//                                Divider()
//                                Text(lesson.name)
//                                Spacer()
//                                Divider()
//                                Text(lesson.room)
//                            }
//                            .frame(alignment: .leading)
//        //                    .font(.system(size: 7))
//                            .font(.caption2)
//                            Divider()
//                        }
//                    } else{
//                        Text("Сегодня пар нет, отдыхайте!")
//                            .font(.caption)
//                            .bold()
//                            .multilineTextAlignment(.center)
//                    }
//                    if lessons.1.isEmpty == false{
//                        HStack{
//                            Circle().fill(Color.purple)
//                                .frame(width: 7, height: 7)
//                            Text("\(days.1):")
//                                .font(.caption)
//                                .bold()
//                        }
//                        Divider()
//                        ForEach(lessons.1) { lesson in
//                            HStack{
//                                Circle().fill(Color.blue)
//                                    .frame(width: 5, height: 5)
//                                Text(lesson.time)
//                                Divider()
//                                Text(lesson.name)
//                                Spacer()
//                                Divider()
//                                Text(lesson.room)
//                            }
//                            .frame(alignment: .leading)
//        //                    .font(.system(size: 7))
//                            .font(.caption2)
//                            Divider()
//                        }
//                    } else{
//                        Text("Сегодня пар нет, отдыхайте!")
//                            .font(.caption)
//                            .bold()
//                            .multilineTextAlignment(.center)
//                    }
//                }
//            }
//            HStack{
//                VStack{
//                    if lessons.2.isEmpty == false{
//                        HStack{
//                            Circle().fill(Color.purple)
//                                .frame(width: 7, height: 7)
//                            Text("\(days.2):")
//                                .font(.caption)
//                                .bold()
//                        }
//                        Divider()
//                        ForEach(lessons.2) { lesson in
//                            HStack{
//                                Circle().fill(Color.blue)
//                                    .frame(width: 5, height: 5)
//                                Text(lesson.time)
//                                Divider()
//                                Text(lesson.name)
//                                Spacer()
//                                Divider()
//                                Text(lesson.room)
//                            }
//                            .frame(alignment: .leading)
//        //                    .font(.system(size: 7))
//                            .font(.caption2)
//                            Divider()
//                        }
//                    } else{
//                        Text("Сегодня пар нет, отдыхайте!")
//                            .font(.caption)
//                            .bold()
//                            .multilineTextAlignment(.center)
//                    }
//                    if lessons.3.isEmpty == false{
//                        HStack{
//                            Circle().fill(Color.purple)
//                                .frame(width: 7, height: 7)
//                            Text("\(days.3):")
//                                .font(.caption)
//                                .bold()
//                        }
//                        Divider()
//                        ForEach(lessons.3) { lesson in
//                            HStack{
//                                Circle().fill(Color.blue)
//                                    .frame(width: 5, height: 5)
//                                Text(lesson.time)
//                                Divider()
//                                Text(lesson.name)
//                                Spacer()
//                                Divider()
//                                Text(lesson.room)
//                            }
//                            .frame(alignment: .leading)
//        //                    .font(.system(size: 7))
//                            .font(.caption2)
//                            Divider()
//                        }
//                    } else{
//                        Text("Сегодня пар нет, отдыхайте!")
//                            .font(.caption)
//                            .bold()
//                            .multilineTextAlignment(.center)
//                    }
//                }
//            }
//        }
//    }
//}

//
//#Preview {
//    WidgetViiews()
//}
