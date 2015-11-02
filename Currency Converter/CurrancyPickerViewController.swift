//
//  CurrancyPickerViewController.swift
//  Currency Converter
//
//  Created by Mohamed Alsadek on 11/2/15.
//  Copyright © 2015 Mohamed Alsadek. All rights reserved.
//

import UIKit

class CurrancyPickerViewController: UIViewController , UITableViewDelegate , UIScrollViewDelegate {

    //Custom control - ScrollView
    @IBOutlet weak var invisibleScrollView: UIScrollView!
    @IBOutlet weak var scrollView: UIScrollView!
    var currentPage = 0
    var scrollViewContentViews : NSMutableArray = []
    var previousPage = 0
    var scrollViewValues = []
    var delegate : ScrollViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initScrollViewCurrencies ()
    }

    // MARK: UIScrollView
    func initScrollViewCurrencies () {
        //	Paging for each scroll view
        self.scrollView.pagingEnabled = true;
        self.scrollView.delegate = self ;
        
        self.invisibleScrollView.pagingEnabled = true;
        self.invisibleScrollView.delegate = self;
        self.invisibleScrollView.hidden = false;
        
        addCurrencyViewsInScrollView()
        setScrollViewsContentWidth()
        
        self.invisibleScrollView.userInteractionEnabled = false;
        self.scrollView.addGestureRecognizer(self.invisibleScrollView.panGestureRecognizer)
    }
    
    func addCurrencyViewsInScrollView() {
        //add elelements
        for i in 0 ..< scrollViewValues.count {
            
            let contentViewTemp = ContentView()
            contentViewTemp.initWithTitle(scrollViewValues[i] as! String , frame: CGRectMake(CGFloat(i + 1) * self.view.frame.width/3, 0, self.view.frame.width/3, invisibleScrollView.frame.size.height))
            
            self.scrollView.addSubview(contentViewTemp.viewParent)
            
            if i == 0 {
                // set the first item selected by default
                contentViewTemp.setThemeOnSelection(true)
            }
            
            //save it in main array , so i can keep track off them to change and update the views
            scrollViewContentViews.addObject(contentViewTemp)
        }
    }
    
    func setScrollViewsContentWidth() {
        let contentWidth = CGFloat(scrollViewValues.count) * (self.view.frame.size.width / 3)
        self.scrollView.contentSize = CGSizeMake(contentWidth, 0);
        self.invisibleScrollView.contentSize = CGSizeMake(contentWidth, 0);
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
            
            // Page has changed: update index, change hightlight
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
    
    /*
    convert the entered value to the seleced currancy and display the result.
    */
    func convertToCurrancyAtIndex(index : Int) {
//        print(index)  // through index on the delegate .. 
        delegate?.selectedCurrancyInFilter(index)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
