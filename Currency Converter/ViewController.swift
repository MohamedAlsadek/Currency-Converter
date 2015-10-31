//
//  ViewController.swift
//  Currency Converter
//
//  Created by Mohamed Alsadek on 10/31/15.
//  Copyright © 2015 Mohamed Alsadek. All rights reserved.
//

import UIKit

class ViewController: UIViewController , MVSelectorScrollViewDelegate {

    @IBOutlet weak var textFieldNumber: UITextField!
    @IBOutlet weak var scrollViewCurrencies: MVSelectorScrollView!
    @IBOutlet var viewParent: UIView!
    
    let currencyFormatter = NSNumberFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewParent.hidden = true
        getCurrencyDataFromServer ()
        
    }
    

    // MARK: Get Data
    func getCurrencyDataFromServer () {
        CurrencyParser.parseCurrency { (isFinished) -> Void in
            if isFinished {
                self.viewParent.hidden = false
                self.initUIElements()
                print("succefully get the data.")
            }else {
                Utilities.displayErrorFromView(self, message: "Error in connection")
            }
        }
    }
    
    
    // MARK: Init UI
    func initUIElements () {
        handleTextFieldFormatting()
        initScrollViewCurrencies ()
    }
    
    // MARK: UITextField
    func handleTextFieldFormatting () {
        textFieldNumber.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormatter.currencyCode = NSLocale.currentLocale().displayNameForKey(NSLocaleCurrencySymbol, value: NSLocaleCurrencyCode)
        
        textFieldDidChange(textFieldNumber)
    }
    
    func textFieldDidChange(textField: UITextField) {
        let text = textField.text!.stringByReplacingOccurrencesOfString(currencyFormatter.currencySymbol, withString: "").stringByReplacingOccurrencesOfString(currencyFormatter.groupingSeparator, withString: "").stringByReplacingOccurrencesOfString(currencyFormatter.decimalSeparator, withString: "")
        textField.text = currencyFormatter.stringFromNumber((text as NSString).doubleValue / 100.0)
    }
    
    // MARK: UIScrollView
    func initScrollViewCurrencies () {
        
        let scrollViewValues = ["USD" , "GBP" , "EUR" , "CAD" , "JPY"]
        scrollViewCurrencies.values = scrollViewValues
        scrollViewCurrencies.delegate = self
        scrollViewCurrencies.updateIndexWhileScrolling = false;
    }
    
    func scrollView(scrollView: MVSelectorScrollView!, pageSelected: Int) {
        print(scrollView.values[pageSelected])
    }
    
    
    // MARK: MemoryWarning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

