//
//  BaseViewController.swift
//  FantomLED
//
//  Created by Surjeet Singh on 01/06/18.
//  Copyright © 2018 Surjeet Singh. All rights reserved.
//

import UIKit


protocol BaseDataSources {
    func setUpClosures()
    func setUpView()
}

class BaseViewController: UIViewController {

    var baseVwModel: BaseViewModel? {
        didSet {
            initBaseModel()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.hideNavigationBar(true, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can 0 recreated.
    }
    func hideBackButton() {
        self.navigationItem.hidesBackButton = true
    }
    func hideNavigationBar(_ hide: Bool, animated: Bool = true) {
        self.navigationController?.setNavigationBarHidden(hide, animated: animated)
    }
    // Cann't be override by subclass
    final func initBaseModel() {
        // Native binding
        baseVwModel?.showAlertClosure = { [weak self] (_ type: AlertType) in
            DispatchQueue.main.async {
                if type == .success, let message = self?.baseVwModel?.alertMessage {
                    if message.count > 0 {
                        let configAlert: AlertUI = ("", message)
                        UIAlertController.showAlert(configAlert)
                    }
                } else {
                    if let errorMessage = self?.baseVwModel?.errorMessage, errorMessage.count > 0 {
                        let configAlert: AlertUI = ("", errorMessage)
                        UIAlertController.showAlert(configAlert)
                    }
                }
            }
        }

    }
    /// This method would execute when user switches from dark mode to light or Vice-versa.
    /// You can use this method in your view controller as well if you have different checks according to your requirments.
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
   }
    
    

}

extension BaseViewController {
    
    private func _storyboard() ->  UIStoryboard? {
        return UIStoryboard(name: StoryboardName.main.rawValue, bundle:nil)
    }
    
    func webViewController() -> UIViewController {
        if let viewC = _storyboard()?.instantiateViewController(withIdentifier: "WebViewVC") {
            return viewC
        }
        return UIViewController()
    }
    
    func mainStoryboardController(withIdentifier identifier: String) -> UIViewController {
        if let viewC = _storyboard()?.instantiateViewController(withIdentifier: identifier) {
            return viewC
        }
        return UIViewController()
    }
    
    // MARK: - Class methods
    public func setBackBtn(){
        //Back buttion
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(UIImage(named: "back"), for: .normal)
        btnLeftMenu.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton


    }
    
    @objc func backAction(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension UIViewController {
    var isDarkMode: Bool {
        if #available(iOS 13.0, *) {
            return self.traitCollection.userInterfaceStyle == .dark
        } else {
            return false
        }
    }
}

enum ColorCompatibility {
    static var myOlderiOSCompatibleColorName: UIColor {
        if UIViewController().isDarkMode {
            if #available(iOS 13.0, *) {
                return UIColor.systemBackground
            } else {
                return UIColor.white
            }
        } else {
            return UIColor.white
        }
    }
}
