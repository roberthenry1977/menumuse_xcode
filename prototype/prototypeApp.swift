//
//  prototypeApp.swift
//  prototype
//
//  Created by Robert Henry on 15/11/2023.
//

import SwiftUI

@main
struct prototypeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                //.environmentObject(draftPlan())
                .environmentObject(DraftPlan())
        }
    }
}
