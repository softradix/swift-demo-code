//
//  LoginVC.swift
//  DemoCode
//
//  Created by apple on 02/04/21.
//

import UIKit
import ProgressHUD

class LoginVC: BaseViewController {

    
    // MARK: - IBOutlets
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPass: UITextField!
    
    // MARK: - Variables
    lazy var viewModel: LoginVM = {
        let obj = LoginVM(userService: UserService())
        self.baseVwModel = obj
        return obj
    }()
    
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tfPass.attributedPlaceholder = NSAttributedString(string:"Enter your password", attributes:[NSAttributedString.Key.foregroundColor: UIColor.white])
        tfEmail.attributedPlaceholder = NSAttributedString(string:"Enter your email", attributes:[NSAttributedString.Key.foregroundColor: UIColor.white])

        #if DEBUG
        self.tfEmail.text = "geet@gmail.com"
        self.tfPass.text = "12345678"
    
        #else
        #endif
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: -  Class functions
    private func validation()->(isValidate:Bool, errorMessage: String?){
        
        let email = tfEmail.text?.removingWhitespaces()
        let password = tfPass.text?.removingWhitespaces()
        
        if (email?.isEmpty)!{
            return (false, AlertMessages.kEnterEmail)
        }
        if !email!.isValidEmail(){
            return (false, AlertMessages.kEnterValidEmailAddress)
        }
        if (password?.isEmpty)!{
            return (false, AlertMessages.kEnterPassword)
        }
        return (true, nil)
    }
    
    fileprivate func callAPILogin(params: [String : Any]){
    
        ProgressHUD.show()
        
        self.viewModel.loggeduserApi(params: params) { result in
            DispatchQueue.main.async {
                ProgressHUD.dismiss()
                if result {
                    Keys.objAppDelegate.goToHomeMenu()
                }else {
                    
                }
            }
        }
    }

    @IBAction func loginAction(_ sender: Any) {

        if validation().isValidate {
            
            let devideToken = "1234656"//DataManager.shared.DeviceToken
            
            let email:String = (tfEmail.text?.removingWhitespaces())!
            let password:String = (tfPass.text?.removingWhitespaces())!
            let params = [Keys.kEmail               : email,
                          Keys.kPassword            : password,
                          Keys.kDeviceToken         : devideToken,
                          Keys.kDeviceType          : "2"
                ] as [String : Any]
            
          self.callAPILogin(params: params)
            
        } else {
            AlertViewManager.showAlert(message: validation().errorMessage!, alertButtonTypes: [.Okay])
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    


}
