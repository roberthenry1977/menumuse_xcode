//
//  dayPlanView.swift
//  prototype
//
//  Created by Robert Henry on 21/11/2023.
//

import SwiftUI

struct dayPlanView: View {
    @EnvironmentObject var draftPlan: DraftPlan
    let day: String

    var body: some View {
        
        
        List {
           
            ForEach(MealType.allCases, id: \.self) { mealType in
                Section(header: Text(mealType.rawValue)) {
                    ForEach(draftPlan.dayPlans.first(where: { $0.day == day })?.meals[mealType] ?? [], id: \.id) { recipe in
                        
                        NavigationLink(destination: DishPlanDetailView(item: recipe)) {
                            DishPlanRowView(recipe: recipe) // Pass mealType here
                        }
                        //
                    }
                    .onDelete { indices in
                        deleteItems(at: indices, for: mealType)
                    }

                    //DebugView(message: "Adding a dish for meal type: \(mealType.rawValue)")
                    
                    // Link for adding a new dish
                    NavigationLink("Add a dish", destination: DishPlanDetailView(item: nil, initialMealType: mealType))
                        //.onAppear {
                           // print("Preparing to add a dish for meal type: \(mealType.rawValue)")
                        //}
                }
            }
        }
        .navigationTitle("Meals for \(day)")
        
    }
    private func deleteItems(at offsets: IndexSet, for mealType: MealType) {
            guard let dayPlan = draftPlan.dayPlans.first(where: { $0.day == day }) else { return }

            offsets.forEach { index in
                if let recipe = dayPlan.meals[mealType]?[index] {
                    draftPlan.delete(recipe: recipe, from: day, for: mealType)
                }
            }
        }
    
}


struct dayPlanView_Previews: PreviewProvider {
    static var previews: some View {
        dayPlanView(day: "Monday").environmentObject(DraftPlan())
    }
}


struct DebugView: View {
    var message: String

    var body: some View {
        EmptyView()
            .onAppear {
                print(message)
            }
    }
}
