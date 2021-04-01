//
//  ReceipeDetailVC.swift
//  Swate
//
//  Created by Prateek Arora on 17/11/20.
//  Copyright © 2020 Saurav Garg. All rights reserved.
//

import UIKit
import ProgressHUD

class ReceipeDetailVC: BaseViewController, UIPopoverPresentationControllerDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var tblDetail: UITableView!
    
    // MARK: - Variables
    var recipeData : RecipesDetailsViewModel?
    var selectedInventoryIDs = [Int]()
    var availableFilters = [Ingredients]()
    var arrValue = 1
    var quantity = 1
    var listIngrds = [Ingredients]()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true

        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tblDetail.register(UINib(nibName: "ReceipeDetailCellone", bundle: nil), forCellReuseIdentifier: "ReceipeDetailCellone")
        self.tblDetail.register(UINib(nibName: "IngredientCell", bundle: nil), forCellReuseIdentifier: "IngredientCell")
        self.tblDetail.register(UINib(nibName: "DirectionCell", bundle: nil), forCellReuseIdentifier: "DirectionCell")
        
        availableFilters = recipeData?.ingrdeinets.filter { $0.is_available == false } ?? []
        if recipeData?.currentServing != nil {
           //arrValue = recipeData?.currentServing ?? 1
            arrValue = Int(quantity)
        }else {
            arrValue = Int(quantity )

        }
        self.listIngrds = recipeData?.ingrdeinets ?? []
        self.tblDetail.reloadData()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        if Display.typeIsLike == DisplayType.iphoneX {
            self.tblDetail.contentInset = UIEdgeInsets(top: -44, left: 0, bottom: 0, right: 0);

        }else {
            self.tblDetail.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);

        } 
        self.tabBarController?.tabBar.isHidden = true

    }
    // MARK: - Actions
     @IBAction func backAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
     }

    @objc func cookedThisTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    

    @objc func addFavTapped (sender : UIButton){
        if recipeData?.isFavourite ?? false{
            recipeData?.isFavourite = false

        }else {
            recipeData?.isFavourite = true

        }
        self.tblDetail.reloadData()
    }
    
    // MARK: -  API methods
    
    
    fileprivate func setLogicForMissingIngredientOnMinus(){
        // For example if User is current serving to 2 people and he is receving user quantity 4 and getting recipe quantity 1 the total quantity would be 2 and he has 4 in the bucket that means available is 1 no missing ingredinets, but if he increased serving people to 5 and total quantity will change to 5 then it would be missing because he has 4 in the bucket and for to cook that recipe it required 5 which is less than user quantity
        let datat = recipeData?.ingrdeinets
        for (index, element) in datat!.enumerated() {
          print("get Index \(index): getString \(element)")
            let data = recipeData?.ingrdeinets[index]
            let intQn = Int(data?.quantity ?? "1") ?? 1
            
            let totalQnt = arrValue * intQn

            let userQn = Int(element.user_quantity ?? "0") ?? 0
            if totalQnt <= userQn{
                data?.is_available = true
            }

        }
        availableFilters = recipeData?.ingrdeinets.filter { $0.is_available == false } ?? []

        self.tblDetail.reloadData()

        
    }
    
    fileprivate  func setLogicForMissingIngredient(){
        let datat = recipeData?.ingrdeinets
        for (index, element) in datat!.enumerated() {
            print("get Index \(index): getString \(element)")
            let data = recipeData?.ingrdeinets[index]
            let intQn = Int(data?.quantity ?? "1") ?? 1
            
            let totalQnt = arrValue * intQn
            
            let userQn = Int(element.user_quantity ?? "0") ?? 0
            if totalQnt > userQn{
                data?.is_available = false
            }
            
        }
        availableFilters = recipeData?.ingrdeinets.filter { $0.is_available == false } ?? []
        
        self.tblDetail.reloadData()
    }
    

}
  // MARK: - UITableViewDelegate UITableViewDataSource
extension ReceipeDetailVC :  UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1{
            return recipeData?.ingrdeinets.count ?? 0
        }
           return 1
    }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReceipeDetailCellone", for: indexPath) as! ReceipeDetailCellone
            cell.btnBack.addTarget(self, action: #selector(backAction(_:)), for: .touchUpInside)
            cell.lblVegname.text = recipeData?.recipeName
            cell.topImg.sd_setIndicatorStyle(UIActivityIndicatorView.Style.medium)
            cell.topImg.sd_setImage(with: URL.init(string:recipeData?.recipeImage ?? ""), placeholderImage: UIImage(named: "placeholderimage"))
            cell.lblMealtype.text = recipeData?.diet
            cell.lblTime.text = "\(recipeData?.cookingTime ?? "") min"
            cell.btnStar.setImage((recipeData?.isFavourite == true) ? #imageLiteral(resourceName: "starselected") : #imageLiteral(resourceName: "star"), for: .normal)
            cell.delegates = self
            cell.btnStar.addTarget(self, action: #selector(addFavTapped(sender:)), for: .touchUpInside)
            cell.lblServing.text = "\(arrValue)"
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as! IngredientCell
            let ingredients = recipeData?.ingrdeinets[indexPath.row]
            if ingredients?.is_available ??  false {
                cell.chkMarkImg.isHidden = false
                cell.vwBottom.backgroundColor  = .white

            }else {
                cell.chkMarkImg.isHidden = true
                cell.vwBottom.backgroundColor  = UIColor.init(red: 251/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)

            }
            let intQn = Int(ingredients?.quantity ?? "1") ?? 1
            let totalQnt = arrValue * intQn
            cell.lblFoodname.text = "\(totalQnt) \(ingredients?.unit?.unit ?? "") \(ingredients?.ingredient_name ?? "")"
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "DirectionCell", for: indexPath) as! DirectionCell
        cell.btnCooked.addTarget(self, action: #selector(cookedThisTapped), for: .touchUpInside)
        cell.lblData.text = recipeData?.directions ?? ""
        return cell
     
           
       }
    
    private func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        if indexPath.section == 0 {
                     return 447
                 }
        else if indexPath.section == 1{
                     return 79
                 }
                   
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
          return  UIView()
        }else if section == 1{
            let vw = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 45))
            let lbl = UILabel.init(frame: CGRect.init(x: 28, y: 0, width: 160, height: 45))
            lbl.text = "Ingredients"
            lbl.font = UIFont.init(name: "Roboto-Medium", size: 24) // my custom font
            lbl.textColor = UIColor(red: 0.071, green: 0.082, blue: 0.239, alpha: 1) // my custom colour
            let lbl1 = UILabel.init(frame: CGRect.init(x: self.view.frame.size.width - 180, y: 0, width: 200, height: 45))
            let msgText = (availableFilters.count == 1) ? "missing ingredient" : "missing ingredients"
            lbl1.text = "\(availableFilters.count) \(msgText)"
            lbl1.font = UIFont.init(name: "Roboto-Normal", size: 12) // my custom font
            lbl1.textColor = UIColor(red: 235/255.0, green: 87/255.0, blue: 87/255.0, alpha: 1)
            lbl1.text = (availableFilters.count == 0) ? "No missing ingredients" : "\(availableFilters.count) \(msgText)"

            vw.addSubview(lbl1)

            vw.addSubview(lbl)

            return vw
            
        }
        let vw = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 45))
        let lbl = UILabel.init(frame: CGRect.init(x: 28, y: 0, width: self.view.frame.size.width, height: 45))
        lbl.text = "Directions"
        lbl.font = UIFont.init(name: "Roboto-Medium", size: 24) // my custom font
        lbl.textColor = UIColor(red: 0.071, green: 0.082, blue: 0.239, alpha: 1) // my custom colour
        vw.addSubview(lbl)

        return vw
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.01
        }
        else if section == 1{
            return 45
        }
        return 45
    }
   
    
}

extension ReceipeDetailVC : DetailsDelegates {
    func plusActionPerformed() {
        arrValue += 1

        recipeData?.currentServing = arrValue
        let cell = tblDetail.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! ReceipeDetailCellone
        cell.lblServing.text = "\(arrValue)"
        self.tblDetail.reloadData()

      //  setLogicForMissingIngredient()
        

    }
    
    func minusActionPerformed() {
        if arrValue != 1 {
            arrValue -= 1
            recipeData?.currentServing = arrValue
            let cell = tblDetail.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! ReceipeDetailCellone
            cell.lblServing.text = "\(arrValue)"
            self.tblDetail.reloadData()

           // setLogicForMissingIngredientOnMinus()


        }
    }
    
    
}
