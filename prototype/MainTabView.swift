//
//  MainTabView.swift
//  prototype
//
//  Created by Robert Henry on 22/11/2023.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            basePlanView() // Your existing view for planning
                .tabItem {
                    Label("Plan", systemImage: "calendar")
                }

            settingsView() // Replace with your actual settings view
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }

            HomeView() // Replace with your actual home view
                .tabItem {
                    Label("Home", systemImage: "house")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
