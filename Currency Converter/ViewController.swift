//
//  ViewController.swift
//  Currency Converter
//
//  Created by Mohamed Alsadek on 10/31/15.
//  Copyright © 2015 Mohamed Alsadek. All rights reserved.
//

import UIKit

class ViewController: UIViewController , ScrollViewDelegate //, UITableViewDelegate , UIScrollViewDelegate ,

{

    @IBOutlet weak var textFieldNumber: UITextField!
    @IBOutlet var viewParent: UIView!
    @IBOutlet weak var labelResult: UILabel!
    let scrollViewValues = ["USD" , "GBP" , "EUR" , "CAD" , "JPY"]
    
    //Currancy Formatter
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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)

//        initScrollViewCurrencies ()
        handleTextFieldFormatting()
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    // MARK: UITextField
    func handleTextFieldFormatting () {
        textFieldNumber.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormatter.currencyCode = NSLocale.currentLocale().displayNameForKey(NSLocaleCurrencySymbol, value: NSLocaleCurrencyCode)
        
        textFieldDidChange(textFieldNumber)
    }
    
    func textFieldDidChange(textField: UITextField) {
        let textEntered = textField.text;
        let numberOfCharacters = textEntered?.characters.count
        
        // just to limit the input to 20 characters .
        if numberOfCharacters >= 19 {
            var myNSString =  NSString(string: textEntered!)
            myNSString = myNSString.substringWithRange(NSRange(location: 0, length: 19))
            textField.text = myNSString as String
        }
        
        textField.text = currencyFormatter.stringFromNumber(Utilities.getDoubleValueFromCurrancyString(textField.text!))
        
        labelResult.text = Utilities.convertAUDto(scrollViewValues[selectedCurrancy] , amount: Utilities.getDoubleValueFromCurrancyString(textFieldNumber.text!))

    }
    
    // MARK: CustomControl Delegate

    // this function get called whenever the user change the selected currancy.
    func selectedCurrancyInFilter(index: Int) {
        selectedCurrancy = index
        labelResult.text = Utilities.convertAUDto(scrollViewValues[index] , amount: Utilities.getDoubleValueFromCurrancyString(textFieldNumber.text!))
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // All you have to do to intantiate the custom currancy picker control is to create a container and embed the currancy picker on it and send the data through segue and implement the delegate.
        
        if segue.identifier == "CustomControlSegue" {
            let customControlView : CurrancyPickerViewController = segue.destinationViewController as! CurrancyPickerViewController
            customControlView.delegate = self
            customControlView.scrollViewValues = scrollViewValues
        }
    }
    
    
    // MARK: MemoryWarning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

