import SwiftUI

struct DishPlanRowView: View {
    let recipe: Recipe
    

    var body: some View {
        HStack {
            // Placeholder for the image
            /*Image(systemName: "photo")
                .resizable()
                .frame(width: 50, height: 50)
                .aspectRatio(contentMode: .fit)*/
            AsyncImage(url: URL(string: Constants.imagePath + recipe.recipeImage + ".jpg")) { image in
                image.resizable()
                    .frame(width: 80, height: 60)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(.gray, lineWidth: 2))
                    //.clipped()
            } placeholder: {
                ProgressView() // Shown while the image is loading
            }
            VStack(alignment: .leading) {
                Text(recipe.recipeName)
                    .font(.headline)
                Text("some more info")
                
            }
        }
    }
}

// MARK: - Previews
struct DishPlanRowView_Previews: PreviewProvider {
    static var previews: some View {
        // Assuming 'meal' in Recipe is a String matching MealType's raw values
        
            DishPlanRowView(recipe: Recipe.example)
        
    }
}
