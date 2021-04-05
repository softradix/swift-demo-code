//
//  RecipeListVC.swift
//  DemoCode
//
//  Created by apple on 01/04/21.
//

import UIKit
import ProgressHUD
import SDWebImage


class RecipeListVC: BaseViewController {

    // MARK: - IBOutlets
 @IBOutlet weak var tableRecipes: UITableView!
 @IBOutlet weak var collectionVw: UICollectionView!
 @IBOutlet weak var btnSaved: UIButton!
 @IBOutlet weak var btnDiscover: UIButton!
 @IBOutlet weak var leadingSpace: NSLayoutConstraint!
 @IBOutlet weak var collectionHeightConstaint: NSLayoutConstraint!
    
    
    // MARK: - Variables
    var data = ["Filters", "Ingredients"]
    var selectedIndexTime = ""
    var arrCuisineSelected = [Int]()
    var arrdishSelected = [Int]()
    var isFilter = false
    var totalFilterCount = 0
    var selectedIndx = -1
    lazy var viewModel: RecipeListVM = {
        let obj = RecipeListVM(userService: UserService())
        self.baseVwModel = obj
        return obj
    }()
    var refreshControl = UIRefreshControl()
    var isDataLoading:Bool=false
    var pageNo:Int=1
    var savedpageNo:Int=1
    var arrSelectedIngredients = [Int]()
    var fromSaved = false
    var directIngredients = false
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpUI()
        self.initVM()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(true)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.viewDidLayoutSubviews()

     }
    
    // MARK: - UI Initialisation

    fileprivate func setNavigationItems(){
        let imageSearch = UIImage(named: "search")
        let searcgbarButtons = UIBarButtonItem.init(image: imageSearch, style: .plain, target: self, action: #selector(searchActionTapped))
        navigationItem.leftBarButtonItem = searcgbarButtons
        btnSaved.setTitleColor( AppColors.lightTextColor, for: .normal)
        btnDiscover.setTitleColor(UIColor.black, for: .normal)
        self.navigationController?.navigationBar.shadowImage = UIImage()


    }
    fileprivate func setUpUI(){
        self.setNavigationItems()
        self.tableRecipes.register(UINib(nibName: "RecipeDiscoverCell", bundle: nil), forCellReuseIdentifier: "RecipeDiscoverCell")

        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
          refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.darkGray
        tableRecipes.addSubview(refreshControl)

    }
  
    // MARK: - Init View Model
    func initVM() {
        
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    ProgressHUD.show()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tableRecipes.alpha = 0.0
                    })
                }else {
                    ProgressHUD.dismiss()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tableRecipes.alpha = 1.0
                    })
                }
            }
        }
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableRecipes.reloadData()
                
            }
        }
        
        self.getRecipesData(showLoader: true)
        
    }
    
    // MARK: - Class methods
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        if fromSaved {
           // self.getFavRecipesAPI()
        }else {
            isFilter = false
            selectedIndx = -1
            totalFilterCount = 0
            self.collectionVw.reloadData()
            selectedIndexTime = ""
            arrdishSelected.removeAll()
            arrCuisineSelected.removeAll()
            self.getRecipesData(showLoader: true)
        }
    }
    @objc func searchActionTapped(){
        
    }
    
    // MARK: - Actions
    @IBAction func discoverAction(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.5, delay: 0.1, options: UIView.AnimationOptions(), animations: { () -> Void in
            self.btnSaved.setTitleColor( AppColors.lightTextColor, for: .normal)
            self.btnDiscover.setTitleColor(UIColor.black, for: .normal)
            self.leadingSpace.constant = 5
            self.view.layoutIfNeeded()
            self.fromSaved = false
            self.collectionHeightConstaint.constant = 48
            self.viewModel.recipesList?.removeAll()
            self.viewModel.favRecipesList?.removeAll()
            self.getRecipesData(showLoader: true)
        }, completion: { (finished: Bool) -> Void in
            
            
        })
    }
    
    @IBAction func savedAction(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.5, delay: 0.1, options: UIView.AnimationOptions(), animations: { () -> Void in
            self.btnDiscover.setTitleColor(AppColors.lightTextColor, for: .normal)
            self.btnSaved.setTitleColor(UIColor.black, for: .normal)
            self.leadingSpace.constant = self.btnSaved.frame.origin.x
            self.view.layoutIfNeeded()
            self.fromSaved = true
            self.collectionHeightConstaint.constant = 0
            self.viewModel.recipesList?.removeAll()
            self.viewModel.favRecipesList?.removeAll()
        }, completion: { (finished: Bool) -> Void in
            
        })
    }
    
    // MARK: -  API methods
    fileprivate func getRecipesData( showLoader : Bool){
        if showLoader {
            ProgressHUD.show()

        }
        if isFilter {
            self.viewModel.recipesList?.removeAll()
            let parameters = [Keys.time : selectedIndexTime, Keys.dishtype : arrdishSelected, Keys.cuisine : arrCuisineSelected, ] as [String : Any]
            let filPar = [Keys.filter : parameters, "limit" : "10", "page" : self.pageNo] as [String : Any]

            viewModel.initFetch(params: filPar)
        }else {
            let parameters = ["limit" : "10", "page" : self.pageNo] as [String : Any]
            viewModel.initFetch(params: parameters)

        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - UITableViewDelegate UITableViewDataSource
extension RecipeListVC :  UITableViewDelegate, UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (fromSaved == true) ? viewModel.numberOfCells : viewModel.numberOfCells
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if fromSaved {
          return self.configureSavedTableCell(tableView, cellForRowAt: indexPath)
          
      }else{
          return self.configureTableCell(tableView, cellForRowAt: indexPath)
          
      }
      
  }
  
  private func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
      return  222
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.viewModel.userPressed(at: indexPath)

    if let selected = self.viewModel.selectedRecipe {
        let vc = NavigationHelper.shared.viewController(VCIdentifier.recipeDetail, .main) as! ReceipeDetailVC
           
        vc.recipeData = selected
        self.navigationController?.pushViewController(vc, animated: true)

    }
    

      
  }
  
  func configureSavedTableCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
      let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeDiscoverCell", for: indexPath) as! RecipeDiscoverCell
    let cellVM = viewModel.getCellViewModel( at: indexPath )
    
    cell.lblFoodTitle.text = cellVM.recipeName
    cell.imgFood.sd_setIndicatorStyle(UIActivityIndicatorView.Style.medium)
    cell.imgFood.sd_setImage(with: URL.init(string:cellVM.recipeImage), placeholderImage: UIImage(named: "placeholderimage"))
    cell.btnStar.setImage( #imageLiteral(resourceName: "starselected") , for: .normal)
    cell.btnStar.tag = indexPath.row
    //    cell.btnStar.addTarget(self, action: #selector(addFavTapped(sender:)), for: .touchUpInside)
    //     let availableFilters = data?.ingrdeinets?.filter { $0.is_available == false } ?? []
    //     let msgText = (availableFilters.count == 1) ? "missing ingredient" : "missing ingredients"

      cell.lblIngredients.text = "No missing ingredients"//(availableFilters.count == 0) ? "No missing ingredients" : "\(availableFilters.count) \(msgText)"
      cell.lblIngredients.textColor =    #colorLiteral(red: 0.5450980392, green: 0.8901960784, blue: 0.5490196078, alpha: 1)
      return cell
  }
  
    func configureTableCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeDiscoverCell", for: indexPath) as! RecipeDiscoverCell
        let cellVM = viewModel.getCellViewModel( at: indexPath )
        
        cell.lblFoodTitle.text = cellVM.recipeName
        cell.imgFood.sd_setIndicatorStyle(UIActivityIndicatorView.Style.medium)
        cell.imgFood.sd_setImage(with: URL.init(string:cellVM.recipeImage), placeholderImage: UIImage(named: "placeholderimage"))
        cell.btnStar.setImage( #imageLiteral(resourceName: "starselected") , for: .normal)
        cell.btnStar.tag = indexPath.row
        //    cell.btnStar.addTarget(self, action: #selector(addFavTapped(sender:)), for: .touchUpInside)
        //     let availableFilters = data?.ingrdeinets?.filter { $0.is_available == false } ?? []
        //     let msgText = (availableFilters.count == 1) ? "missing ingredient" : "missing ingredients"

          cell.lblIngredients.text = "No missing ingredients"//(availableFilters.count == 0) ? "No missing ingredients" : "\(availableFilters.count) \(msgText)"
          cell.lblIngredients.textColor =    #colorLiteral(red: 0.5450980392, green: 0.8901960784, blue: 0.5490196078, alpha: 1)
      return cell
  }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension RecipeListVC : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return data.count
      
  }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
      return self.configureCollectionCell(collectionView, cellForItemAt: indexPath)
      
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: 96, height: 30)
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     /* selectedIndx = indexPath.row
      if indexPath.row == 0 {
          let vc = NavigationHelper.shared.viewController(VCIdentifier.filterRecipe, .main) as! RecipeFiltersVC
          vc.selectedIndexTime = Int(selectedIndexTime) ?? -1
          vc.selectedIndexCuisine = arrCuisineSelected
          vc.selectedIndexDishtype = arrdishSelected
          self.navigationController?.pushViewController(vc, animated: true)

      }else {
          let vc = NavigationHelper.shared.viewController(VCIdentifier.searchRecipeVC, .main) as! SearchRecipeVC
          vc.arrSelectedRows = self.arrSelectedIngredients
          self.navigationController?.pushViewController(vc, animated: true)

      }*/

  }
  
  func configureCollectionCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCollectionCell", for: indexPath) as! DiscoverCollectionCell
      if selectedIndx == indexPath.row {
          cell.vwBottom.backgroundColor = AppColors.appGreenColor
          cell.lblTitle.textColor = UIColor.black
          cell.vwBottom.borderColor = AppColors.appGreenColor
      }else {
          cell.vwBottom.backgroundColor = .white
          cell.lblTitle.textColor = AppColors.lightTextColor
          cell.vwBottom.borderColor = AppColors.lightGray

      }
      if indexPath.item == 0 {
          if totalFilterCount > 0{
              cell.lblTitle.text = "Filters • \(totalFilterCount)"

          }else {
              cell.lblTitle.text = self.data[indexPath.item]
          }
      }else {
          cell.lblTitle.text = self.data[indexPath.item]

      }

      return cell

  }
}
