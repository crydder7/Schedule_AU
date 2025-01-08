import SwiftUI
import EventKit


struct TabsView: View {
    @StateObject private var calendarManager = CalendarManager()
    @State private var accessGranted = false
    @State private var error: Error?
    @State private var picked = 0

    var body: some View {
        TabView(selection: $picked){
            Tab("Schedule", systemImage: "calendar", value: 0) {
                ScheduleView()
            }
            Tab("Info", systemImage: "info.circle.fill", value: 1) {
               InfoView()
            }

        }
        .tabViewStyle(.sidebarAdaptable)
        .animation(.snappy, value: picked)
    }
}



#Preview {
    TabsView()
}
