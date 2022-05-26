//
//  AppDelegate.swift
//  ios_assignment
//
//  Created by uresha lakshani on 2021-05-21.
//

 import UIKit
 import FBSDKLoginKit
 import FBSDKCoreKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //facebook configaration
        ApplicationDelegate.shared.application( application, didFinishLaunchingWithOptions: launchOptions)
        
        // set basic apperance of the app
        ConfigureService.shared.configure()
        
        // set root nevigetion
        ConfigureService.shared.manageUserDirection()
        
        return true
    }
    

    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = ApplicationDelegate.shared.application(application, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        
        // navigate to home when user login via fb
        ConfigureService.shared.goToHome()
        return handled
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        AppEvents.activateApp()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        AppEvents.activateApp()
    }
    
    //set root view
    func setAsRoot(_controller: UIViewController) {
        if window != nil {
            window?.rootViewController = _controller
        }
    }
    
}

