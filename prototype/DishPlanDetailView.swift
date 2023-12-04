import SwiftUI
import Combine

class DishPlanDetailView_Model: ObservableObject {
    // Published property to hold the recipe image ID
    @Published var recipeImage: String
    
    @Published var recipeName: String
    @Published var recipeID: Int
    @ObservedObject var settings = UserSettings.shared

    

    // Initialize with a default URL
    init(RecipeImageURL: String = "http://192.168.1.31/images/recipe_3.jpg",
         RecipeName: String = "Default Recipe Name",
         RecipeID: Int = 0) {
        self.recipeImage = RecipeImageURL
        self.recipeName = RecipeName
        self.recipeID = RecipeID
        
        
    }//default initial URL string tp capture if none is passed
    
    
    static func createModel(with item: Recipe?) -> DishPlanDetailView_Model {
        let recipeImageURL = item != nil ? Constants.imagePath + item!.recipeImage + ".jpg" : "http://192.168.1.31/images/recipe_3.jpg"
        let recipeName = item?.recipeName ?? "Default Recipe Name"
        let recipeID = item?.recipeID ?? 0
        return DishPlanDetailView_Model(RecipeImageURL: recipeImageURL, RecipeName: recipeName, RecipeID: recipeID)
    }
    
    
    // Function to update the image URL
    func updateRecipeImage(newURL: String) {
        recipeImage = newURL
    }
    
    private let myFunctionsInstance = myFunctions()

    func loadData() {
        
        myFunctionsInstance.suggestRecipe(baseURL: Constants.baseURL, parameters: [
            "salt": settings.saltIndex,
            "sour": settings.sourIndex,
            "sweet": settings.sweetIndex,
            "bitter": settings.bitterIndex,
            "umami": settings.umamiIndex,
            "fat": settings.fatIndex,
            "spice": settings.spiceIndex
        ]) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let recipeData):

                    self.recipeImage = (Constants.imagePath + recipeData.recipeImage + ".jpg")
                    self.recipeID = recipeData.recipeID
                    self.recipeName = recipeData.recipeName
                   

                    
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")

                }
            }
        }
    }
}

struct DishPlanDetailView: View {

    //@ObservedObject var viewModel = DishPlanDetailView_Model()
    @StateObject var viewModel: DishPlanDetailView_Model
    
    @State var item: Recipe? //to hold a loaded recipe from a draft_meal plan
    
    @EnvironmentObject var draft: DraftPlan //this is the draft meal plan
    
    @State private var recipeChanged = false //variable to capture if editing a recipe and the recipe has changed or not. This impacts saving
    
    // Use MealType enum for meal types
    @State private var mealType: MealType
    let mealTypes = MealType.allCases
    
    @Environment(\.dismiss) private var dismiss

    init(item: Recipe?, initialMealType: MealType = .dinner) {
        self._item = State(initialValue: item)
        self._mealType = State(initialValue: initialMealType)
        self._viewModel = StateObject(wrappedValue: DishPlanDetailView_Model.createModel(with: item))
        
       
    }
    
    
    
    
    
    var body: some View {
        
        
        
        VStack(alignment: .center, spacing: 0) {
            // Image view that reflects the recipeImage from the view model
            AsyncImage(url: URL(string: viewModel.recipeImage)) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(maxWidth: UIDevice.current.userInterfaceIdiom == .pad ? 600 : .infinity)
                    .frame(maxWidth: UIDevice.current.userInterfaceIdiom == .pad ? 600 : .infinity)
            } placeholder: {
                ProgressView() // Shown while the image is loading
            }
            .scaledToFit()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .frame(height: 250)
            
            
            
            Text(viewModel.recipeName)
                .font(.title2)
                .padding([.top, .bottom], 10) // Reduced padding on top and bottom
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec facilisis tincidunt lorem sit amet fringilla. Cras scelerisque scelerisque purus, a tincidunt neque commodo sed. Donec et tristique mauris, sit amet posuere nunc. Phasellus elementum, turpis ac vulputate dignissim, nunc nunc gravida enim, ut blandit lorem massa eget nunc. Aliquam ut pharetra nunc. Quisque in quam fermentum, vestibulum justo quis, porttitor neque. Quisque cursus semper lacinia. ")
                .padding(5)
            
            NavigationLink(destination: RecipeDetailView(recipeID:viewModel.recipeID,recipeName: viewModel.recipeName)) {
                        Text("Recipe Detail")
                    }
            
            
            Picker("Meal type:", selection: $mealType) {
                ForEach(mealTypes, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding(5)
            
            if let currentItem = item {
                Button("Save Changes") {
                    let updatedItem = Recipe(id: currentItem.id, recipeID: viewModel.recipeID, recipeImage: "recipe_" + String(viewModel.recipeID), recipeName: viewModel.recipeName, meal: mealType.rawValue)

                    // Determine the original meal type
                    let originalMealType = MealType(rawValue: currentItem.meal) ?? .dinner

                    // Use the updated edit method
                    if recipeChanged {
                        // If the recipe has changed entirely
                        draft.edit(recipe: updatedItem, in: "Monday", from: originalMealType, to: mealType)
                    } else {
                        // If only the meal type might have changed
                        draft.edit(recipe: updatedItem, in: "Monday", from: originalMealType, to: mealType)
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding(5)
            } else {
                Button("Choose This Dish") {
                    addNewDish()
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .padding(5)
            }
            
            //Text("Meal Type: \(mealType.rawValue)") // used for debugging incoming parameters

            
            Spacer()
            Button("Suggest Another Recipe") {
                
                viewModel.loadData() //loading new data
                
                if item != nil{
                    recipeChanged = true //need to capture if the recipe has changed for saving changes
                }
                
            }
            
            
        }
        .onAppear {
                   //print("DishPlanDetailView appeared")
            

                   // Setting the picker to match the item's meal type
                  /* if let itemMeal = item?.meal, let itemMealType = MealType(rawValue: itemMeal) {
                       mealType = itemMealType
                   } else {
                       mealType = .lunch // Default value if meal type is not set or item is nil
                   }*/

                   if item == nil {
                       viewModel.loadData() // Load data if adding a new dish
                   }
               }

    }
    
    func addNewDish() {
        // Assuming you have a way to determine the day for the new dish
        let day = "Monday" // Replace with actual day logic
        let newDish = Recipe(id: UUID(), recipeID: viewModel.recipeID, recipeImage: "recipe_" + String(viewModel.recipeID), recipeName: viewModel.recipeName, meal: mealType.rawValue)
        draft.add(recipe: newDish, to: day, for: mealType)
    }
    
    
    
}


        /*
        let example = Recipe.example
        return DishPlanDetailView(item: example)
        */
        
        struct DishPlanDetailView_Previews: PreviewProvider {
            static var previews: some View {
                
                // Previewing DishPlanDetailView without passing a Recipe item
                DishPlanDetailView(item: nil, initialMealType: .dinner)
                    .environmentObject(DraftPlan()) // Providing DraftPlan as an EnvironmentObject
            }
        }

//the old draftPlan

class draftPlan: ObservableObject {
    @Published var dishes: [Recipe] = []
    func add(item: Recipe) {
            dishes.append(item)
      
        print("Added item: \(item)")
        }

        func remove(item: Recipe) {
            if let index = dishes.firstIndex(of: item) {
                dishes.remove(at: index)
            }
        }
    
    func update(item: Recipe) {
            if let index = dishes.firstIndex(where: { $0.id == item.id }) {
                dishes[index] = item
            }
        }
    }



