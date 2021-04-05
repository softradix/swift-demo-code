//
//  SignupVC.swift
//  DemoCode
//
//  Created by apple on 02/04/21.
//

import UIKit
import ProgressHUD

class SignupVC: BaseViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tfLastname: UITextField!
    @IBOutlet weak var tfFirstname: UITextField!
    @IBOutlet weak var btnPromotions: UIButton!
    @IBOutlet weak var btnAgree: UIButton!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    
    
    // MARK: - Variables
    lazy var viewModel: SignupVM = {
        let obj = SignupVM(userService: UserService())
        self.baseVwModel = obj
        return obj
    }()
    
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tfLastname.attributedPlaceholder = NSAttributedString(string:"Last name", attributes:[NSAttributedString.Key.foregroundColor: UIColor.white])
        tfFirstname.attributedPlaceholder = NSAttributedString(string:"First name", attributes:[NSAttributedString.Key.foregroundColor: UIColor.white])
        tfPassword.attributedPlaceholder = NSAttributedString(string:"Password", attributes:[NSAttributedString.Key.foregroundColor: UIColor.white])
        tfEmail.attributedPlaceholder = NSAttributedString(string:"Email", attributes:[NSAttributedString.Key.foregroundColor: UIColor.white])
        if #available(iOS 11.0, *) {
            #if targetEnvironment(simulator)
            // Do Not enable '.password' or '.newPassword' or 'isSecureTextEntry' text content type on simulator as it ends up with annoying behaviour:
            // 'Strong Password' yellow glitch preventing from editing field.
            tfPassword.isSecureTextEntry = false

            #else
            tfPassword.textContentType = .password
            tfPassword.isSecureTextEntry = true
            #endif
        }
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func continueAction(_ sender: Any) {
        self.view.endEditing(true)
        let devideToken = "1234656"//DataManager.shared.DeviceToken

        if validation().isValidate{
            let email:String = (tfEmail.text?.removingWhitespaces())!
            let password:String = (tfPassword.text?.removingWhitespaces())!
            let params = [Keys.kName            : tfFirstname.text!,
                          Keys.kLastname            : tfLastname.text!,
                          Keys.kEmail               : email,
                          Keys.kPassword            : password,
                          Keys.kDeviceToken         : devideToken,
                          Keys.kDeviceType          : "2"

                ] as [String : Any]
        
            self.requestRegisterAPI(params: params)
                       
        }else {
            AlertViewManager.showAlert(message: validation().errorMessage!, alertButtonTypes: [.Okay])
        }
        
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func termsAction(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            btnAgree.setImage(UIImage.init(named: "checkbox"), for: .normal)
        }else {
            sender.isSelected = true
            btnAgree.setImage(UIImage.init(named: "tickbox"), for: .normal)

        }
    }
    
    @IBAction func promotionAction(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            btnPromotions.setImage(UIImage.init(named: "checkbox"), for: .normal)
        }else {
            sender.isSelected = true
            btnPromotions.setImage(UIImage.init(named: "tickbox"), for: .normal)

        }
    }
    
    // MARK: - Class functions
    
    private func validation()->(isValidate:Bool, errorMessage: String?){
        
        let email = self.tfEmail.text?.removingWhitespaces()
        let password = self.tfPassword.text?.removingWhitespaces()
        let fstname = self.tfFirstname.text
        let lname = self.tfLastname.text

        
        if (fstname!.isEmpty){
            return (false, AlertMessages.kEnterName)
        }
        if (lname!.isEmpty){
            return (false, AlertMessages.kEnterLastName)
        }
        if (email?.isEmpty)!{
            return (false, AlertMessages.kEnterEmail)
        }
        if !email!.isValidEmail(){
            return (false, AlertMessages.kEnterValidEmailAddress)
        }
        if (password?.isEmpty)!{
            return (false, AlertMessages.kEnterPassword)
        }
        if !btnAgree.isSelected {
            return (false, AlertMessages.kCheckTermsConditions)
        }
        

       
        return (true, nil)
    }
    
    private func requestRegisterAPI(params: [String : Any]) {
        
        ProgressHUD.show()
        
        self.viewModel.signUpUserApi(params: params) { (reult) in
            DispatchQueue.main.async {
                ProgressHUD.dismiss()
                if reult {
                    Keys.objAppDelegate.goToHomeMenu()
                }else{
                    
                }
            }
        }
    }
}
extension SignupVC : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
