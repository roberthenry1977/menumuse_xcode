//
//  helperFunctions.swift
//  prototype
//
//  Created by Robert Henry on 15/11/2023.
//

import Foundation
import SwiftUI

//functions that are used through out the application: preventing duplication
struct myFunctions {
    @ObservedObject var settings = UserSettings.shared //getting the settings from the shared object - refer to dataModels
    
    
    func suggestRecipe(baseURL: String, parameters: [String: String], forPreview: Bool = false, completion: @escaping (Result<RecipeData, Error>) -> Void) {
        //print(baseURL) //debug statement - uncomment if there are issues with pulling data
        if forPreview {
            print("Mock fetchData called for preview")
            let mockData = RecipeData(recipeID: 12, recipeImage: "MockImage.jpg", recipeName: "Mock Recipe Name")
            completion(.success(mockData))
            return
        }
        else{
            var components = URLComponents(string: baseURL + "/search")!
            components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
            
            var request = URLRequest(url: components.url!)
            request.timeoutInterval = 20 // Set the timeout interval to 20 seconds
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                //URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    DispatchQueue.main.async {
                        completion(.failure(URLError(.badServerResponse)))
                    }
                    return
                }
                
                if let data = data {
                        do {
                        let decoder = JSONDecoder()
                        let recipeData = try decoder.decode(RecipeData.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(recipeData))
                        }
                            
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(URLError(.badServerResponse)))
                    }
                }
            }.resume()
            
            
        }
    }
    func generateTastePreferences() -> [String: Any] {
        return [
            "salt": settings.saltIndex ,
            "sour": settings.sourIndex ,
            "sweet": settings.sweetIndex ,
            "bitter": settings.bitterIndex ,
            "umami": settings.umamiIndex ,
            "fat": settings.fatIndex ,
            "spice": settings.spiceIndex 
        ]
    }

    
}

//required struct to load images from outsidfe the app (i.e. not from the assets) - debugging is needed in case the image could not be found to prevent the app from crashing.
struct ImageView: View {
   
    var imageUrl: URL?
    @State var uiImage: UIImage?
    
   
    
    var body: some View {
       
        Group {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else {
               //print("loading default image")
                Image("recipe_0") // Default image from assets
                    .resizable()
                    .scaledToFit()
            }
        }
        .onAppear {

            if let url = imageUrl {
                loadNetworkImage(from: url)
                
                //print("Loading image from URL: \(url)")
            }
        }
    }

    func loadNetworkImage(from url: URL) {
        //print("Loading image from URL: \(url)")
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                //print("Image loaded successfully")
                DispatchQueue.main.async {
                    self.uiImage = image
                }
            }
         else {
            print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
        }
        }.resume()
    }
    
    
}





