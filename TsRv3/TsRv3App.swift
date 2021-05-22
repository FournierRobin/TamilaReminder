//
//  TsRv3App.swift
//  TsRv3
//
//  Created by Robin Fournier on 22/05/2021.
//

import SwiftUI

@main
struct TsRv3App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
