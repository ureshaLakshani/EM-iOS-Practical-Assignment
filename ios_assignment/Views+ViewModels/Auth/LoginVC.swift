//
//  LoginVC.swift
//  ios_assignment
//
//  Created by uresha lakshani on 2021-05-21.
//

import UIKit
import FBSDKLoginKit

class LoginVC: UIViewController {

    //label outlet
    @IBOutlet weak var loginLbl: UILabel!
    
    //button outlet
    @IBOutlet weak var searchBtn: CustomUIButton!
    
    var fbLoginSuccess = false

    override func viewDidLoad() {
        super.viewDidLoad()
           
        //set facebook button
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        view.addSubview(loginButton)
           
        NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in
               
        // Print out access token
        print("FB Access Token: \(String(describing: AccessToken.current?.tokenString))")
               
            self.loginStatus()
        }
       
    }
       
    @IBAction func goToHotelBtn(_ sender: Any) {
           
        loginStatus()
           
    }
       
    func loginStatus()  {
           
        if let token = AccessToken.current,
                            !token.isExpired {
                            ConfigureService.shared.goToHome()
                            return
                    }
                    
            let message = "login not sucuss..."
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                    self.present(alert, animated: true)
                             
            // duration in seconds
            let duration: Double = 2
                             
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
                        alert.dismiss(animated: true)
                }
           
       }

}
