//
//  Mini3_AsthmaAppApp.swift
//  Mini3_AsthmaApp Watch App
//
//  Created by Jonathan Aaron Wibawa on 15/08/24.
//

import SwiftUI

@main
struct Mini3_AsthmaApp_Watch_AppApp: App {
    @WKApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
