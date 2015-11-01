//
//  ViewController.swift
//  Currency Converter
//
//  Created by Mohamed Alsadek on 10/31/15.
//  Copyright © 2015 Mohamed Alsadek. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UIScrollViewDelegate {

    @IBOutlet weak var textFieldNumber: UITextField!
    @IBOutlet var viewParent: UIView!
    @IBOutlet weak var labelResult: UILabel!
    let scrollViewValues = ["USD" , "GBP" , "EUR" , "CAD" , "JPY"]
    
    //Custom control - ScrollView
    @IBOutlet weak var invisibleScrollView: UIScrollView!
    @IBOutlet weak var scrollView: UIScrollView!
    var currentPage = 0
    var scrollViewContentViews : NSMutableArray = []
    var previousPage = 0
    
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

        initScrollViewCurrencies ()
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
        
        //just to limit the input to 20 characters .
        if numberOfCharacters >= 19 {
            var myNSString =  NSString(string: textEntered!)
            myNSString = myNSString.substringWithRange(NSRange(location: 0, length: 19))
            textField.text = myNSString as String
        }
        
        textField.text = currencyFormatter.stringFromNumber(Utilities.getDoubleValueFromCurrancyString(textField.text!))
        
        labelResult.text = Utilities.convertAUDto(scrollViewValues[selectedCurrancy] , amount: Utilities.getDoubleValueFromCurrancyString(textFieldNumber.text!))

    }
    
    // MARK: UIScrollView
    func initScrollViewCurrencies () {
        //	Paging for each scroll view
        self.scrollView.pagingEnabled = true;
        self.scrollView.delegate = self ;
        self.invisibleScrollView.pagingEnabled = true;
        self.invisibleScrollView.delegate = self;
        
        //add elelements
        for i in 0 ..< scrollViewValues.count {
            
            let contentViewTemp = ContentView()
            contentViewTemp.initWithTitle(scrollViewValues[i] , frame: CGRectMake(CGFloat(i + 1) * self.view.frame.width/3, 0, self.view.frame.width/3, invisibleScrollView.frame.size.height))

            self.scrollView.addSubview(contentViewTemp.viewParent)
            
            if i == 0 {
                // set the first item selected by default
                contentViewTemp.setThemeOnSelection(true)
            }
            
            //save it in main array , so i can keep track off them to change and update the views
            scrollViewContentViews.addObject(contentViewTemp)
        }
        
        let contentWidth = CGFloat(5) * (self.view.frame.size.width / 3)
        self.scrollView.contentSize = CGSizeMake(contentWidth, 0);
        self.invisibleScrollView.contentSize = CGSizeMake(contentWidth, 0);
        
        self.invisibleScrollView.userInteractionEnabled = false;
        self.scrollView.addGestureRecognizer(self.invisibleScrollView.panGestureRecognizer)
        
        self.invisibleScrollView.delegate = self;
        self.invisibleScrollView.hidden = false;

    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if(invisibleScrollView != nil)
        {
            //	Forward the content offset from the overlay to our main scroll view
            self.scrollView.contentOffset = self.invisibleScrollView.contentOffset;
        }
        
        if (scrollView.contentOffset.x < 0.0) {
            return
        }
        
        let page = calculatePage(scrollView);
        if previousPage != page {
            
            // Page has changed: update index, change hightlight, call delegate
            if (page >= 0 && page < scrollViewContentViews.count) {
                changeHighlightFrom(previousPage, newIndex: page)
                previousPage = page;
            }
        }
    }
    
    
    func calculatePage (scrollView : UIScrollView) -> Int {
        let fractionalPage = Double(scrollView.contentOffset.x / (self.view.frame.width/3));
        var page = lround(fractionalPage);

        if page >= scrollViewContentViews.count {
            page = scrollViewContentViews.count - 1;
        }
        if page < 0 {
            page = 0
        }
        return page;
    }
    
    
    func changeHighlightFrom(oldIndex : Int ,newIndex : Int){
        
        if (oldIndex != newIndex) {
            let tempContentViewNew  = scrollViewContentViews.objectAtIndex(newIndex) as! ContentView
            tempContentViewNew.setThemeOnSelection(true)

            let tempContentViewOld  = scrollViewContentViews.objectAtIndex(oldIndex) as! ContentView
            tempContentViewOld.setThemeOnSelection(false)
            
            convertToCurrancyAtIndex(newIndex)
        }
    }
    
    func convertToCurrancyAtIndex(index : Int) {
        print("convert to currrancy : \(index)")

        selectedCurrancy = index
        labelResult.text = Utilities.convertAUDto(scrollViewValues[index] , amount: Utilities.getDoubleValueFromCurrancyString(textFieldNumber.text!))

    }
    
    // MARK: MemoryWarning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

