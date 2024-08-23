//
//  File.swift
//  Breatheee Watch App
//
//  Created by Kevin Fairuz on 18/08/24.
//

import Foundation

class TabViewManager: ObservableObject {
    @Published var currentTab = 1
    
    func changeCurrentTab(selectTab: Int) {
        currentTab = selectTab
    }
}

class Router: ObservableObject {
    @Published var hideTabView: Bool = false
    @Published var selectedTab: Int = 1
}
