//
//  Hotel.swift
//  ios_assignment
//
//  Created by uresha lakshani on 2021-05-21.
//

import UIKit
import SwiftyJSON
import ObjectMapper

class Hotel: NSObject, Mappable  {

    var id:String?
    var title:String?
    var dis:String?
    var address:String?
    var postcode:String?
    var phoneNumber:String?
    var latitude:String?
    var longitude:String?
    var image:Image?
    
    
    required convenience init?(map: Map) {
        self.init()
    }

    //MARK: 1. Mapping local variable with api body
    func mapping(map: Map) {
        
        id           <- map["id"]
        title        <- map["title"]
        dis          <- map["description"]
        address      <- map["address"]
        postcode     <- map["postcode"]
        phoneNumber  <- map["phoneNumber"]
        latitude     <- map["latitude"]
        longitude    <- map["longitude"]
        image        <- map["image"]
        
    }
    
    // get mapable hotel array
    class func mapHotelData(json: JSON) -> [Hotel] {
        print("HOTEL LIST JSON:\(json)")
        var hotelArray:[Hotel] = []
        
        let hotelJsonArray = json["data"].arrayValue
        for hotelJson in hotelJsonArray {
            if let organization = Mapper<Hotel>().map(JSONObject: hotelJson.rawValue) {
                hotelArray.append(organization)
            }
        }
        return hotelArray
    }
}
 
