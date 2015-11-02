//
//  ContentView.swift
//  Currency Converter
//
//  Created by Mohamed Alsadek on 11/2/15.
//  Copyright © 2015 Mohamed Alsadek. All rights reserved.
//

import UIKit

class ContentView: NSObject {
    
    var titleString : Float = 0.0
    var labelTitle: UILabel!
    var isSelected = false
    var viewParent : UIView!
    
    func initWithTitle(title:String , frame : CGRect) {
        viewParent = UIView(frame:frame)
        initLabelWithText(title)
        viewParent.addSubview(self.labelTitle)
    }
    
    func initLabelWithText(title:String) {
        self.labelTitle = UILabel(frame: CGRectMake(0, 0, self.viewParent.frame.size.width, self.viewParent.frame.size.height))
        self.labelTitle.text = title;
        self.labelTitle.font = CONSTANTS.FONTS.APP_FONT
        self.labelTitle.adjustsFontSizeToFitWidth = true
        self.labelTitle.textAlignment = NSTextAlignment.Center
        self.labelTitle.textColor = UIColor(white: 1.0, alpha: 0.3)
    }
    
    func setThemeOnSelection(isSelected:Bool) {
        if isSelected {
            self.labelTitle.textColor = UIColor(white: 1.0, alpha: 1.0)
        }else {
            self.labelTitle.textColor = UIColor(white: 1.0, alpha: 0.3)
        }
    }
    
}
