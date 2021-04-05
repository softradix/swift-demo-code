//
//  AppDelegate.swift
//  DemoCode
//
//  Created by Softradix Mac Mini on 31/03/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func goToHomeMenu(){
                
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vw = storyboard.instantiateViewController(withIdentifier: VCIdentifier.recipesVC.rawValue)

        let navi = UINavigationController.init(rootViewController: vw)
        navi.navigationBar.isTranslucent = true
        navi.navigationBar.barStyle = .default
        navi.navigationBar.barTintColor = .white

        
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if #available(iOS 13.0, *) {
           if let scene = UIApplication.shared.connectedScenes.first{
                guard let windowScene = (scene as? UIWindowScene) else { return }
                print(">>> windowScene: \(windowScene)")
                self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
                self.window!.windowScene = windowScene //Make sure to do this
                self.window!.rootViewController = navi
                self.window!.makeKeyAndVisible()
                appDelegate.window = self.window!
            }else {
                let windowScene = UIApplication.shared
                                .connectedScenes
                                .filter { $0.activationState == .foregroundActive }
                                .first
                if let windowScene = windowScene as? UIWindowScene {
                     self.window = UIWindow(windowScene: windowScene)
                    self.window?.rootViewController = navi
                    self.window?.makeKeyAndVisible()
                }
            }
        }else {
               window?.rootViewController = navi
               window?.makeKeyAndVisible()
        }
    }

}


extension UIApplication {
    internal class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController
            if let top = moreNavigationController.topViewController, top.view.window != nil {
                return topViewController(top)
            } else if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }

    
}
