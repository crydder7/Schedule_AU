import SwiftUI
import EventKit


struct TabsView: View {
    @StateObject private var calendarManager = CalendarManager()
    @State private var accessGranted = false
    @State private var error: Error?

    var body: some View {
        TabView {
            Tab("Schedule", systemImage: "calendar") {
                ScheduleView()
            }
            Tab("Info", systemImage: "info.circle.fill") {
               InfoView()
            }
            
        }
        .tabViewStyle(.sidebarAdaptable)
        .animation(.snappy)
    }
}



#Preview {
    TabsView()
}
