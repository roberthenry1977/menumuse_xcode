//
//  dataModels.swift
//  prototype
//
//  Created by Robert Henry on 16/11/2023.
//

import Foundation
import Foundation

struct RecipeData: Codable {
    var recipeID: Int    // Changed from String to Int to match your JSON
    var recipeImage: String
    var recipeName: String
    // Removed otherField if not needed
}

class fetched_RecipeData: ObservableObject {
    static  let RecipeData = fetched_RecipeData()
    
    @Published var recipeImage = "place hoder"
    @Published var recipeName = "recipe name"
    @Published var recipeID = 2
}



class UserSettings: ObservableObject {
    static let shared = UserSettings()
    
    @Published var saltPreference: String {
        didSet {
            UserDefaults.standard.set(saltPreference, forKey: "SaltPreference")
        }
    }

    @Published var sweetPreference: String {
        didSet {
            UserDefaults.standard.set(sweetPreference, forKey: "SweetPreference")
        }
    }
    
    @Published var sourPreference: String {
        didSet {
            UserDefaults.standard.set(sourPreference, forKey: "SourPreference")
        }
    }
    
    @Published var bitterPreference: String {
        didSet {
            UserDefaults.standard.set(bitterPreference, forKey: "bitterPreference")
        }
    }
    
    @Published var umamiPreference: String {
        didSet {
            UserDefaults.standard.set(umamiPreference, forKey: "umamiPreference")
        }
    }
    
    @Published var fatPreference: String {
        didSet {
            UserDefaults.standard.set(fatPreference, forKey: "fatPreference")
        }
    }
    
    @Published var spicePreference: String {
        didSet {
            UserDefaults.standard.set(spicePreference, forKey: "spicePreference")
        }
    }



    init() {
        saltPreference = UserDefaults.standard.string(forKey: "SaltPreference") ?? "neutral"
        sweetPreference = UserDefaults.standard.string(forKey: "SweetPreference") ?? "neutral"
        sourPreference = UserDefaults.standard.string(forKey: "sourPreference") ?? "neutral"
        bitterPreference = UserDefaults.standard.string(forKey: "bitterPreference") ?? "neutral"
        umamiPreference = UserDefaults.standard.string(forKey: "umamiPreference") ?? "neutral"
        fatPreference = UserDefaults.standard.string(forKey: "fatPreference") ?? "neutral"
        spicePreference = UserDefaults.standard.string(forKey: "spicePreference") ?? "neutral"
        
    }
    
    private let preferenceIndices = ["hate": "1", "neutral": "2", "love": "3"]

    var saltIndex: String {
        preferenceIndices[saltPreference] ?? "0"
    }

    var sweetIndex: String {
        preferenceIndices[sweetPreference] ?? "0"
    }
    var sourIndex: String {
        preferenceIndices[sourPreference] ?? "0"
    }
    var bitterIndex: String {
        preferenceIndices[bitterPreference] ?? "0"
    }
    var umamiIndex: String {
        preferenceIndices[umamiPreference] ?? "0"
    }
    var fatIndex: String {
        preferenceIndices[fatPreference] ?? "0"
    }
    
    var spiceIndex: String {
        preferenceIndices[spicePreference] ?? "0"
    }
    
    
}

struct Recipe: Codable, Hashable, Identifiable {
    var id: UUID
    var recipeID: Int
    var recipeImage: String
    var recipeName: String
    var meal : String

    #if DEBUG
    static let example = Recipe(id: UUID(),recipeID: 0, recipeImage: "recipe_1", recipeName: "Cooked Chicken", meal:"Dinner")
    #endif
    
}


//struct to hold the ingredients for a recipe
//need to expand this guy for all fields in the ingredients tbl

struct Ingredient: Identifiable {
    let id = UUID()
    var quantity: String
    var unit: String
    var name: String
    var comment: String?
}


//struct to hold the directions for a recipe
//need to expand this guy for all fields in the directions tbl
struct Direction: Identifiable {
    let id = UUID()
    var step: String
}
