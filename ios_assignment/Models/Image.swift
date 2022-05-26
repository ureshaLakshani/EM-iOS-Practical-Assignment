//
//  Image.swift
//  ios_assignment
//
//  Created by uresha lakshani on 2021-05-21.
//

import UIKit
import ObjectMapper


class Image: NSObject, Codable, Mappable {
    
    var small:String?
    var medium:String?
    var large:String?
    
    
    required convenience init?(map: Map) {
        self.init()
    }

     //MARK: 1. Mapping local variable with api body
    func mapping(map: Map) {
        
        small     <- map["small"]
        medium    <- map["medium"]
        large     <- map["large"]
        
    }
    
}
