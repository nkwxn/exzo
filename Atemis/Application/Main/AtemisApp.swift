//
//  AtemisApp.swift
//  Atemis
//
//  Created by Nicholas on 26/10/21.
//

import SwiftUI

@main
struct AtemisApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//            TabContainer()
            ProductView()
        }
    }
}
