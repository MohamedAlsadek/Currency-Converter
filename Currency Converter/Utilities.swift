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
    
    class func currencyStringFromNumber(number: Double , currencyCode:String) -> String {
        let locale = NSLocale(localeIdentifier: currencyCode)
        let symopol = locale.displayNameForKey(NSLocaleCurrencySymbol, value: currencyCode)
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.currencyCode = locale.displayNameForKey(NSLocaleCurrencySymbol, value: NSLocaleCurrencyCode)
        
        let formattedCurrency : String = formatter.stringFromNumber(number)!
        return formattedCurrency.stringByReplacingOccurrencesOfString(formatter.currencySymbol, withString: symopol!)
        
    }
    
    class func getDoubleValueFromCurrancyString(currancyString : String) -> Double{
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormatter.currencyCode = NSLocale.currentLocale().displayNameForKey(NSLocaleCurrencySymbol, value: NSLocaleCurrencyCode)
        
        let cleanCurrancyString = currancyString.stringByReplacingOccurrencesOfString(currencyFormatter.currencySymbol, withString: "").stringByReplacingOccurrencesOfString(currencyFormatter.groupingSeparator, withString: "").stringByReplacingOccurrencesOfString(currencyFormatter.decimalSeparator, withString: "")
        
        let result = (cleanCurrancyString as NSString).doubleValue / 100.0 ;
        
        return result
    }
    
    class func convertAUDto(currancy : String , amount : Double) -> String{
        var convertedAmount = amount
        if currancy == "USD" {
            convertedAmount = convertedAmount * Double(CurrencyParser.USD)
            return currencyStringFromNumber(convertedAmount , currencyCode: "USD") ;
        }else if currancy == "GBP" {
            convertedAmount = convertedAmount * Double(CurrencyParser.GBP)
            return currencyStringFromNumber(convertedAmount , currencyCode: "GBP") ;

        }else if currancy == "EUR" {
            convertedAmount = convertedAmount * Double(CurrencyParser.EUR)
            return currencyStringFromNumber(convertedAmount , currencyCode: "EUR") ;

        }else if currancy == "CAD" {
            convertedAmount = convertedAmount * Double(CurrencyParser.CAD)
            return currencyStringFromNumber(convertedAmount , currencyCode: "CAD") ;
            
        }else if currancy == "JPY" {
            convertedAmount = convertedAmount * Double(CurrencyParser.JPY)
            return currencyStringFromNumber(convertedAmount , currencyCode: "JPY") ;
        }
        
        return ""
    }
    
}
