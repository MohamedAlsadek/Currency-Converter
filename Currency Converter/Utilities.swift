//
//  Utilities.swift
//  Currency Converter
//
//  Created by Mohamed Alsadek on 10/31/15.
//  Copyright © 2015 Mohamed Alsadek. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    
    class func displayErrorFromView(vc:UIViewController , message : String ) {
        
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        vc.presentViewController(alertController, animated: true, completion: nil)
    }
}
