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
    @IBOutlet weak var labelResult: UILabel!
    let scrollViewValues = ["USD" , "GBP" , "EUR" , "CAD" , "JPY"]

    
    let currencyFormatter = NSNumberFormatter()
    var selectedCurrancy = 0
    
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
        initScrollViewCurrencies ()
        handleTextFieldFormatting()
    }
    
    // MARK: UITextField
    func handleTextFieldFormatting () {
        textFieldNumber.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormatter.currencyCode = NSLocale.currentLocale().displayNameForKey(NSLocaleCurrencySymbol, value: NSLocaleCurrencyCode)
        
        textFieldDidChange(textFieldNumber)
    }
    
    func textFieldDidChange(textField: UITextField) {
        textField.text = currencyFormatter.stringFromNumber(Utilities.getDoubleValueFromCurrancyString(textField.text!))
        
        labelResult.text = Utilities.convertAUDto(scrollViewCurrencies.values[selectedCurrancy] as! String, amount: Utilities.getDoubleValueFromCurrancyString(textFieldNumber.text!))

    }
    
    // MARK: UIScrollView
    func initScrollViewCurrencies () {
        
        scrollViewCurrencies.values = scrollViewValues
        scrollViewCurrencies.delegate = self
        scrollViewCurrencies.updateIndexWhileScrolling = false;
    }
    
    func scrollView(scrollView: MVSelectorScrollView!, pageSelected: Int) {
        print(scrollView.values[pageSelected])
        selectedCurrancy = pageSelected
        labelResult.text = Utilities.convertAUDto(scrollView.values[pageSelected] as! String, amount: Utilities.getDoubleValueFromCurrancyString(textFieldNumber.text!))
    }
    
    
    // MARK: MemoryWarning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

