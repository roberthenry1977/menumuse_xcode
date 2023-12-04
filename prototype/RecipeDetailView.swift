//
//  RecipeDetailView.swift
//  Menu Muse
//
//  Created by Robert Henry on 4/12/2023.
//

import SwiftUI

struct RecipeDetailView: View {
    
    let recipeID: Int
    let recipeName: String
    
    
    // Mock Data for demonstration
    let ingredients: [Ingredient] = [
        Ingredient(quantity: "1", unit: "cup", name: "Sugar", comment: "Preferably brown sugar"),
        Ingredient(quantity: "2", unit: "tbsp", name: "Butter", comment: nil)
    ]

    let directions: [Direction] = [
        Direction(step: "Mix all the ingredients."),
        Direction(step: "Bake for 45 minutes.")
    ]

    var body: some View {
        ScrollView {
            Text("Recipe ID: \(recipeID)") //will delete later
            VStack(alignment: .leading, spacing: 10) {
                Text("Ingredients")
                    .font(.title)

                ForEach(ingredients) { ingredient in
                    VStack(alignment: .leading) {
                        Text("\(ingredient.quantity) \(ingredient.unit) \(ingredient.name)")
                        if let comment = ingredient.comment {
                            Text(comment)
                                .italic()
                                .font(.caption)
                        }
                    }
                }

                Text("Directions")
                    .font(.title)

                ForEach(directions) { direction in
                    Text(direction.step)
                }
            }
            .padding()
        }
        .navigationTitle(recipeName + "Recipe Detail")
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Providing mock data for the preview
        RecipeDetailView(recipeID: 123, recipeName: "Mock Recipe Name")
    }
}
