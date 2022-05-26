//
//  HotelnfoVC.swift
//  ios_assignment
//
//  Created by uresha lakshani on 2021-05-21.
//

import UIKit

class HotelnfoVC: UIViewController {
    
    @IBOutlet weak var infoIV: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var disLbl: UILabel!
    
    var hotel:Hotel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBasicDetail()
    }
    
    // set main field values
    func setBasicDetail()  {
        // Do any additional setup after loading the view.
       titleLbl.text = hotel!.title ?? "No Title"
       disLbl.text = hotel!.dis ?? "No infomation"
       infoIV.setImageWithUrl(hotel!.image!.large ?? "", placeholderImage: UIImage(named: "paseholder")!)
    }

    @IBAction func didTapOnLocation(_ sender: Any) {
        self.performSegue(withIdentifier: "HotelInfoVCToMapVC", sender: nil)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HotelInfoVCToMapVC" {
             let destination = segue.destination as! MapVC
            destination.hotel = self.hotel!
         }
    }
}
