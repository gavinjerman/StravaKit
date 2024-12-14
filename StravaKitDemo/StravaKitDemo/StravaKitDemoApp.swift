//
//  StravaKitDemoApp.swift
//  StravaKitDemo
//
//  Created by Gustavo Ferrufino on 2024-12-14.
//

import SwiftUI

@main
struct StravaKitDemoApp: App {
    private let container: DIContainer
    
    init() {
        self.container = DIContainer()
    }
    var body: some Scene {
        WindowGroup {
            ContentView(container: container)
        }
    }
}
