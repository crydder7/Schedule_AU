import SwiftUI

struct ScheduleTableView: View {
    @Binding var weekDays: [WeekDays]
    @Binding var pickedDay: String
    @Binding var group: String

    var body: some View {
        Table(weekDays) {
            TableColumn("WeekDay", value: \.dayOfWeek)
        }
    }
}

