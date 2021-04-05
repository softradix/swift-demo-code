//
//  ViewController.swift
//  DemoCode
//
//  Created by Softradix Mac Mini on 31/03/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func joinSwateAction(_ sender: Any) {
        let vc = NavigationHelper.shared.viewController(VCIdentifier.signupVC, .main)
             self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func loginAction(_ sender: Any) {
        let vc = NavigationHelper.shared.viewController(VCIdentifier.logiVC, .main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

