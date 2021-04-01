//
//  RecipeListVM.swift
//  DemoCode
//
//  Created by apple on 01/04/21.
//

import Foundation

class RecipeListVM : BaseViewModel{
    
    // MARK: letiables
    var userService: UserServiceProtocol
    var recipesList:[Recipes]?
    var searchrecipesList:[Recipes]?
    var favRecipesList:[Recipes]?

    private var cellViewModels: [RecipeListCellViewModel] = [RecipeListCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var reloadTableViewClosure: (()->())?
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    
    var selectedRecipe : RecipesDetailsViewModel?
    
    // MARK: Initialization
    // Putting dependency injection by paasing the service object in constructor and not giving the responsibility
    init(userService: UserServiceProtocol) {
      self.userService = userService
    }
    
    func initFetch(params : [String : Any]?) {
        self.isLoading = false
        ApiManager.shared.getMyReceipesData(params: params) { (responseList,errorMesg) in
            if responseList != nil{
                self.processFetchedRecipesData(fetchedRecipes: responseList!)
                
            }  else {
                self.alertMessage = errorMesg
            }
        }
    }
    
    private func processFetchedRecipesData( fetchedRecipes: [Recipes] ) {
        if fetchedRecipes.count > 0 {
            var availblarr = [Recipes]()
            for (_, elemts) in fetchedRecipes.enumerated(){
                    let data = elemts
                    let availableFilters = data.ingrdeinets?.filter { $0.is_available == false } ?? []
                    data.totalAvailablCount = availableFilters.count
                    availblarr.append(data)
                    
                }
            let sortedRecipes = availblarr.sorted {
                $0.totalAvailablCount ?? 0 < $1.totalAvailablCount ?? 0
                   
               }
            self.recipesList = sortedRecipes // Cache
            var vms = [RecipeListCellViewModel]()
            for recipe in fetchedRecipes {
                vms.append( createCellViewModel(recipe: recipe) )
            }
            self.cellViewModels = vms

        }
        
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> RecipeListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel( recipe: Recipes ) -> RecipeListCellViewModel {
        
        return RecipeListCellViewModel.init(recipeImage: recipe.receipe_image ?? "", recipeName: recipe.receipe_name ?? "", recipeId: recipe.receipe_id ?? 0, isFavourite: recipe.is_favourite ?? false)
    }
    

    
}
struct RecipeListCellViewModel {
    let recipeImage: String
    let recipeName: String
    let recipeId: Int
    let isFavourite : Bool
}

struct RecipesDetailsViewModel {
  
    let cookingTime : String
    let cuisine : String
    let diet : String
    let directions : String
    let dish : String
    let recipeId : Int
    let recipeImage : String
    let recipeName : String
    let ingrdeinets : [Ingredients]
    var isFavourite : Bool
    let userQuantity : String
    var currentServing : Int
    let totalAvailablCount : Int
    
}

extension RecipeListVM {
    func userPressed( at indexPath: IndexPath ){
        let recipeDetail = self.recipesList?[indexPath.row]
       
        self.selectedRecipe = RecipesDetailsViewModel.init(cookingTime: recipeDetail?.cooking_time ?? "", cuisine: recipeDetail?.cuisine ?? "", diet: recipeDetail?.diet ?? "", directions: recipeDetail?.directions ?? "", dish: recipeDetail?.dish ?? "", recipeId: recipeDetail?.receipe_id ?? 0, recipeImage: recipeDetail?.receipe_image ?? "", recipeName: recipeDetail?.receipe_name ?? "", ingrdeinets: (recipeDetail?.ingrdeinets!)! , isFavourite: recipeDetail?.is_favourite ?? false, userQuantity: recipeDetail?.user_quantity ?? "", currentServing: recipeDetail?.currentServing ?? 0, totalAvailablCount: recipeDetail?.totalAvailablCount ?? 0)
     
        
    }
}
