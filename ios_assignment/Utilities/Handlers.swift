//
//  Handlers.swift
//  ios_assignment
//
//  Created by uresha lakshani on 2021-05-21.
//

import Foundation

typealias completionHandler = (_ status: Bool, _ code: Int, _ message: String) -> ()

func delay(_ delay: Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}
