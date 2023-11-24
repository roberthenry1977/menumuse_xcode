//
//  settingsView.swift
//  prototype
//
//  Created by Robert Henry on 16/11/2023.
//

import SwiftUI

struct settingsView: View {
    var body: some View{
        VStack{
            NavigationStack{
                List{
                    Section("Preferences"){
                        NavigationLink("Taste Preference"){
                            TastePreferencesView()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    settingsView()
}
