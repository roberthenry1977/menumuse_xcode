import Foundation

class DraftPlan: ObservableObject {
    @Published var dayPlans: [DayPlan] = [] {
        didSet {
            saveToUserDefaults()
        }
    }

    init() {
        loadFromUserDefaults()
    }

    // Adds a recipe to a specific day and meal type
    func add(recipe: Recipe, to day: String, for mealType: MealType) {
        if let index = dayPlans.firstIndex(where: { $0.day == day }) {
            var updatedDayPlan = dayPlans[index]
            updatedDayPlan.meals[mealType, default: []].append(recipe)
            dayPlans[index] = updatedDayPlan
        } else {
            let newDayPlan = DayPlan(day: day, meals: [mealType: [recipe]])
            dayPlans.append(newDayPlan)
        }
    }

    // Edit an existing recipe in a specific day and meal type
    func edit(recipe: Recipe, in day: String, from oldMealType: MealType, to newMealType: MealType) {
        // Remove from old meal type if the meal type has changed
        if oldMealType != newMealType,
           let dayIndex = dayPlans.firstIndex(where: { $0.day == day }),
           let mealIndex = dayPlans[dayIndex].meals[oldMealType]?.firstIndex(where: { $0.id == recipe.id }) {
            dayPlans[dayIndex].meals[oldMealType]?.remove(at: mealIndex)
        }

        // Add or update in new meal type
        if let dayIndex = dayPlans.firstIndex(where: { $0.day == day }),
           let mealIndex = dayPlans[dayIndex].meals[newMealType]?.firstIndex(where: { $0.id == recipe.id }) {
            dayPlans[dayIndex].meals[newMealType]?[mealIndex] = recipe
        } else {
            add(recipe: recipe, to: day, for: newMealType)
        }
    }


    // Delete a recipe from a specific day and meal type
    func delete(recipe: Recipe, from day: String, for mealType: MealType) {
        guard let dayIndex = dayPlans.firstIndex(where: { $0.day == day }),
              let mealIndex = dayPlans[dayIndex].meals[mealType]?.firstIndex(where: { $0.id == recipe.id }) else {
            return
        }

        dayPlans[dayIndex].meals[mealType]?.remove(at: mealIndex)
    }

    private func saveToUserDefaults() {
        // Convert dayPlans to Data and save to UserDefaults
        if let encodedData = try? JSONEncoder().encode(dayPlans) {
            UserDefaults.standard.set(encodedData, forKey: "dayPlans")
        }
    }

    private func loadFromUserDefaults() {
        // Load and convert Data from UserDefaults to dayPlans
        if let savedData = UserDefaults.standard.data(forKey: "dayPlans"),
           let loadedDayPlans = try? JSONDecoder().decode([DayPlan].self, from: savedData) {
            dayPlans = loadedDayPlans
        }
    }
}

// DayPlan and MealType should be Codable for UserDefaults persistence
struct DayPlan: Codable {
    var day: String
    var meals: [MealType: [Recipe]]

    init(day: String, meals: [MealType: [Recipe]] = [:]) {
        self.day = day
        self.meals = meals
    }
}

enum MealType: String, Codable, CaseIterable {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case snacks = "Snacks"
}
