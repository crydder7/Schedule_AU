import SwiftUI
import EventKit


struct TabsView: View {
    @StateObject private var calendarManager = CalendarManager()
    @State private var accessGranted = false
    @State private var error: Error?
    @State private var picked = 0

    var body: some View {
        TabView(selection: $picked){
//            Tab("Schedule", systemImage: "calendar", value: 0) {
//                ScheduleView()
//            }
//            Tab("Info", systemImage: "info.circle.fill", value: 1) {
//               InfoView()
//            }
            Tab(value: 0) {
                ScheduleView()
            } label: {
                Text("Расписание")
                Image(systemName: "calendar")
            }
            Tab(value: 1) {
                InfoView()
            } label: {
                Text("Информация")
                Image(systemName: "info.circle.fill")
            }

        }
        .tabViewStyle(.sidebarAdaptable)
        .animation(.smooth)
    }
}



#Preview {
    TabsView()
}
