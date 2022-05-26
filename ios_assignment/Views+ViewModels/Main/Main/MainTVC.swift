//
//  MainTVC.swift
//  ios_assignment
//
//  Created by uresha lakshani on 2021-05-21.
//

import UIKit

class MainTVC: UITableViewCell {
    
    @IBOutlet weak var roundIv: CustomUIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // set main table view properties
    func configureCell(hotel:Hotel) {
        
        roundIv.setImageView(img: hotel.image!.small!)
        titleLbl.text = hotel.title
        addressLbl.text = hotel.address
    }

}
