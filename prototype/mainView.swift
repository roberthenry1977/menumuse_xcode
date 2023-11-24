//
//  mainView.swift
//  prototype
//
//  Created by Robert Henry on 15/11/2023.
//

import SwiftUI

struct mainView: View {
    var body: some View {
        TabView{
            //ContentView()
              //  .tabItem {
                //    Label("Menu",systemImage: "list.dash")
                //}
            basePlanView()
                .tabItem {
                    Label("Plan",systemImage: "square.and.pencil")
                }
            settingsView()
                .tabItem {
                    Label("Settings",systemImage: "gear")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        mainView()
            //.environmentObject(Order())
        .environmentObject(draftPlan())
    }
}
