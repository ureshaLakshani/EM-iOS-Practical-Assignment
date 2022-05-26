//
//  ApiControler.swift
//  ios_assignment
//
//  Created by uresha lakshani on 2021-05-21.
//

import UIKit
import Alamofire
import SwiftyJSON


class ApiControler{
    private let BASEURL:String = "https://dl.dropboxusercontent.com/s/6nt7fkdt7ck0lue"
    private var url:String?
    private var parameters:[String:Any]?
    private var httpMethod: HTTPMethod
    private var httpHeader:HTTPHeaders?
    
    init(urlEndPoint:String, method:HTTPMethod, parameters:[String:Any], header:HeadersType) {
        self.url = BASEURL + urlEndPoint
        self.httpMethod = method
        self.parameters = parameters
        self.httpHeader = getHeaders(header)
    }
    
    init(urlEndPoint:String, method:HTTPMethod, header:HeadersType) {
        self.url = BASEURL + urlEndPoint
        self.httpMethod = method
        self.httpHeader = getHeaders(header)
    }
    
    private func getHeaders(_ type: HeadersType) -> HTTPHeaders {
        return [
            "Accept": "application/json"
        ]
    }
    
    
    func apiRequest(completion: @escaping (Resultt<Data>) -> Void) {
        
        print("URL: ============> \(String(describing: url))")
        print("HTTP METHOD: ====> \(httpMethod)")
        print("HEADERS: ========> \(String(describing: httpHeader))")
        print("PARAMETERS: =====> \(parameters ?? [:])")

        //var shopp = "http://api.lankawe.com/v1/goodsSearch/searchGoods"
    
        Alamofire.request(url!, method: httpMethod, parameters: parameters, encoding: JSONEncoding.default, headers: httpHeader)
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        //print(data)
                        let json = JSON(data)
                        print("""
                            
                            API RESPONSE |===========================================>
                            \(json)
                            END RESPONSE <===========================================|
                            
                            """)
//                        print(json["responseInfo"]["sort"])
                        let status = json["status"].int
                        switch status {
                        case 200:
                            completion(.Success(data))
                        default:
                            let message = "error"
                            completion(.Invalid(message))
                        }
                    }
                case .failure(let error):
                    completion(.Failure(error))
                }
            }
        }
}

enum HeadersType {
    case Main
}

enum WebService:String {
    case hotel = "/hotels.json"
}

enum Resultt<T> {
    case Success(Data)
    case Invalid(String)
    case Failure(Error)
}


