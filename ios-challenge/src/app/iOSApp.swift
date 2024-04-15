//
//  iOSApp.swift
//  ios-challenge
//
//  Created by Marc Flores on 10/4/24.
//

import SwiftUI
import Swinject

@main
struct iOSApp: App {
    
    static let container = Container()
    
    init() {
        Self.container.registerDependencies()
        _ = Self.container.resolve(TransactionsService.self)
    }

    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}
