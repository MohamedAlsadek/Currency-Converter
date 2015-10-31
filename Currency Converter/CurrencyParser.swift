//
//  CurrencyParser.swift
//  Currency Converter
//
//  Created by Mohamed Alsadek on 10/31/15.
//  Copyright © 2015 Mohamed Alsadek. All rights reserved.
//

import UIKit

class CurrencyParser: NSObject {
    
    static var USD : Float = 0.0
    static var GBP : Float = 0.0
    static var EUR : Float = 0.0
    static var CAD : Float = 0.0
    static var JPY : Float = 0.0
    
    class func performGetRequest(targetURL: NSURL!, completion: (data: NSData?, HTTPStatusCode: Int, error: NSError?) -> Void) {
        
        let request = NSMutableURLRequest(URL: targetURL)
        request.HTTPMethod = "GET"
        
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let session = NSURLSession(configuration: sessionConfiguration)
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(data: data, HTTPStatusCode: (response as! NSHTTPURLResponse).statusCode, error: error)
            })
        })
        
        task.resume()
    }
    
    
    class func parseCurrency(completion: (isFinished: Bool) -> Void) {
        let url = NSURL(string: CONSTANTS.URLS.BASE_URL)
        CurrencyParser.performGetRequest(url) { (data, HTTPStatusCode, error) -> Void in
            print(HTTPStatusCode)
            if HTTPStatusCode == 200 {
                let json = JSON(data: data!)
                
                USD = json["rates"]["USD"].float!
                GBP = json["rates"]["GBP"].float!
                EUR = json["rates"]["EUR"].float!
                CAD = json["rates"]["CAD"].float!
                JPY = json["rates"]["JPY"].float!
                
                print("USD \(USD)\nGBP \(GBP)\nEUR \(EUR)\nCAD \(CAD)\nJPY \(JPY)\n")
                
                completion(isFinished: true)
                
            }else  {
                
                completion(isFinished: false)
            }
        }

    }
}
