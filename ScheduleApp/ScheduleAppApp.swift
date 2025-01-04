//
//  ScheduleAppApp.swift
//  ScheduleApp
//
//  Created by lonely. on 12/21/24.
//

import SwiftUI
import SwiftData

@main
struct ScheduleAppApp: App {
    
    var body: some Scene {
        WindowGroup {
            TabsView()
        }
        .modelContainer(for: Note.self)
    }
}
