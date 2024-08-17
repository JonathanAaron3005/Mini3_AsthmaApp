//
//  Mini3_AsthmaAppApp.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 15/08/24.
//

import SwiftUI

@main
struct Mini3_AsthmaAppApp: App {

    var body: some Scene {
        WindowGroup {
            if UIDevice.current.userInterfaceIdiom == .phone {
                ContentView()
            } else {
                //watch view
            }
        }
    }
}
