//
//  MainVC.swift
//  ios_assignment
//
//  Created by uresha lakshani on 2021-05-21.
//


import UIKit
import SwiftyJSON
import FBSDKLoginKit

class MainVC: UIViewController, LoadingIndicatorDelegate  {

    var hotel:[Hotel] = []
    var sigleHotel:Hotel?

    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // call to get hotel detail api
        hotelRequest()
        
        //set user details
        setUserDetails()
    }
    
    //MARK: fucntion to set user detels getting loged fb details
    func setUserDetails()  {
        // get fb login user details
         let graphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "name,email"], tokenString: AccessToken.current?.tokenString, version: nil, httpMethod: HTTPMethod(rawValue: "GET"))
           graphRequest.start(completionHandler: { (test, result, error) in
            let Info = result as? [String: Any]
           
            //set user name and password
            let userName = Info?["name"] as? String
            self.userNameLbl.text = userName
            
            let email = Info?["email"] as? String
            self.emailLbl.text = email
            
        })
    }
    
    // logut button action
    @IBAction func taoOnLogout(_ sender: Any) {
        let loginManager = LoginManager()
        AlertProvider(vc: self).showConfirmationAlert(title: confirmationTitle, message: logoutConfirmation, cancelTitle: noAction, okTitle: yesAction, completion: { (action) in
            if action.title == yesAction {
                //fb user logout
                loginManager.logOut()
                ConfigureService.shared.manageUserDirection()
            }
            else {
                // Dismiss alert
            }
        })
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MainVCToHotelInfoVC" {
           let destination = segue.destination as! HotelnfoVC
           destination.hotel = sender as? Hotel
       }
    }

}

//MARK: Table view functions
extension MainVC : UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return hotel.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if let cell:MainTVC = tableView.dequeueReusableCell(withIdentifier: "MainTVC", for: indexPath) as? MainTVC {
            
            // set each hotel deteils to cell
             cell.configureCell(hotel: hotel[indexPath.row])
             return cell
         }
         return UITableViewCell()
     }
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //navigate to hotel info view when click on cell
         self.performSegue(withIdentifier: "MainVCToHotelInfoVC", sender: hotel[indexPath.row])
     }
    
}

//MARK: Api related functions
extension MainVC {
    // fuction to get hotel detalils
     func hotelRequest() {
         self.startLoading()
         hotelNetworkRequest(completion: { success, statusCode, message in
             self.stopLoading()
             if success {
                 self.tableView.reloadData()
                 self.setUserDetails()
                 print("user logn sucess")
             } else {
                 switch statusCode {
                 case 503:
                     AlertProvider(vc: self).showAlert(title: errorTitle , message: message, action: AlertAction(title: dismissAction))
                 default:
                     AlertProvider(vc: self).showAlert(title: errorTitle , message: message, action: AlertAction(title: dismissAction))
                 }
             }
         })
     }
     
     // api request
     func hotelNetworkRequest(completion: @escaping completionHandler) {
         // Check internet connection
         guard Reachability.isInternetAvailable() else {
             completion(false, 503, "InternetConnectionOffline")
             return
         }
            ApiControler(urlEndPoint: WebService.hotel .rawValue, method: .get, header: .Main).apiRequest { (result) in
                switch result {
                case .Success(let data):
                    print(data)
                    let json = JSON(data)
                    self.hotel = Hotel.mapHotelData(json: json)
                    completion(true, 200, "You have logged in successfully.")
                 case .Invalid(let message):
                     print(message)
                    completion(false, 404, message)
                 case .Failure(let error):
                    print(error)
                 break
                    
                }
            }
     }
     
}

