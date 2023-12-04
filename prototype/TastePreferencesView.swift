//
//  TastePreferencesView.swift
//  prototype
//
//  Created by Robert Henry on 16/11/2023.
//

import SwiftUI

struct TastePreferencesView: View {
    
    @ObservedObject var settings = UserSettings.shared
    
    @State private var showSweetPopover: Bool = false
    @State private var showSaltPopover: Bool = false
    @State private var showSourPopover: Bool = false
    @State private var showBitterPopover: Bool = false
    @State private var showUmamiPopover: Bool = false
    @State private var showFatPopover: Bool = false
    @State private var showSpicePopover: Bool = false
    
    let preferenceTypes = ["love", "neutral", "hate"]
    
    var body: some View {
        //NavigationView{
            Form{
                Section{
                    HStack{
                        Text("How do you feel about sweet food?")
                        Spacer()
                        Button(action: {
                            self.showSweetPopover = true
                        }) {
                            Image(systemName: "info.circle")
                        }
                        .popover(isPresented: $showSweetPopover) {
                            InfoPopover(infoText: "Sweet foods refers to the level of sweetness in food, ranging from desserts to subtly sweet elements in savory dishes.", show: $showSweetPopover)
                        }
                    }
                    Picker("sweet preference:", selection: $settings.sweetPreference){
                        ForEach(preferenceTypes, id: \.self){
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section{
                    HStack{
                        Text("How do you feel about sour food?")
                        Spacer()
                        Button(action: {
                            self.showSourPopover = true
                        }) {
                            Image(systemName: "info.circle")
                        }
                        .popover(isPresented: $showSourPopover) {
                            InfoPopover(infoText: "Sour Food describes the tangy or tart taste found in foods like citrus fruits, fermented products, and certain dressings or sauces.", show: $showSourPopover)
                        }
                    }
                    Picker("sour preference:", selection: $settings.sourPreference){
                        ForEach(preferenceTypes, id: \.self){
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section{
                    HStack{
                        Text("How do you feel about salty food?")
                        Spacer()
                        Button(action: {
                            self.showSaltPopover = true
                        }) {
                            Image(systemName: "info.circle")
                        }
                        .popover(isPresented: $showSaltPopover) {
                            InfoPopover(infoText: "Salty food refers to the presence and impact of salt used to enhance and balance the flavors in a variety of foods, from snacks to main courses.", show: $showSaltPopover)
                        }
                        
                    }
                    Picker("Salt preference:", selection: $settings.saltPreference){
                        ForEach(preferenceTypes, id: \.self){
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section{
                    HStack{
                        Text("How do you feel about bitter food?")
                        Spacer()
                        Button(action: { self.showBitterPopover = true }) {
                            Image(systemName: "info.circle")
                            
                        }
                        .popover(isPresented: $showBitterPopover) {
                            InfoPopover(infoText: "Bitter food refers to the distinct, sometimes sharp taste ranging from subtle hints in leafy greens and certain vegetables to more pronounced bitterness in dark chocolate, coffee, and some beers.", show: $showBitterPopover)
                        }
                    }
                    Picker("Bitter preference:", selection: $settings.bitterPreference){
                        ForEach(preferenceTypes, id: \.self){
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section{
                    HStack{
                        Text("How do you feel about Umami rich food?")
                        Spacer()
                        Button(action: {
                            self.showUmamiPopover = true
                        }) {
                            Image(systemName: "info.circle")
                        }
                        .popover(isPresented: $showUmamiPopover) {
                            InfoPopover(infoText: "Umami rich foods describes the savory depth found in foods like broths, meats, mushrooms, and aged cheeses, often perceived as a rich or meaty flavor.", show: $showUmamiPopover)
                        }
                    }
                    Picker("Umami preference:", selection: $settings.umamiPreference){
                        ForEach(preferenceTypes, id: \.self){
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section{
                    HStack{
                        Text("How do you feel about fat rich food?")
                        Spacer()
                        Button(action: {
                            self.showFatPopover = true
                        }) {
                            Image(systemName: "info.circle")
                        }
                        .popover(isPresented: $showFatPopover) {
                            InfoPopover(infoText: "Fat rich foods describes foods with varying levels of fat content, contributing to a range of textures and flavors, from the subtle richness in dairy and oils to the more pronounced creaminess in avocados, nuts, and well-marbled meats.", show: $showFatPopover)
                        }
                    }
                    Picker("Spice Preference:", selection: $settings.fatPreference){
                        ForEach(preferenceTypes, id: \.self){
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section{
                    HStack{
                        Text("How do you feel about spice rich food?")
                        Spacer()
                        Button(action: {
                            self.showSpicePopover = true
                        }) {
                            Image(systemName: "info.circle")
                        }
                        .popover(isPresented: $showSpicePopover) {
                            InfoPopover(infoText: "Spice-rich foods encompasses a range of flavors from mildly aromatic herbs and spices to intensely hot elements like chili peppers, adding warmth and complexity to dishes.", show: $showSpicePopover)
                        }
                    }
                    Picker("Spice Preference:", selection: $settings.spicePreference){
                        ForEach(preferenceTypes, id: \.self){
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Taste Preferences")
        }
    //}
}

struct InfoPopover: View {
    let infoText: String
    @Binding var show: Bool

    var body: some View {
        VStack {
            Text(infoText)
                .padding()

            Button("Dismiss") {
                self.show = false
            }
            .padding()
        }
        .frame(width: 300, height: 200) // Adjust as needed
    }
}



#Preview {
    TastePreferencesView()
}
