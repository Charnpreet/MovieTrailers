//
//  BackgroundColor.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 8/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class BackgroundColor {
    static let shared = BackgroundColor()
    private var darkModeOn = false
    private let usrDefualts = UserDefaults.standard
    private var backgroundClr : UIColor
    private var textClr : UIColor
    private init() {
        
        backgroundClr = UIColor.black // shall read from core data
        textClr  = UIColor.white // shall read from core data
    }
    func getBGClr()->UIColor{
        darkModeOn = getstylePreference()
        if(darkModeOn){
            backgroundClr = UIColor.black // shall read from core data
        }else{
            backgroundClr = UIColor.white
        }
        return backgroundClr
    }
    func gettxtClr()->UIColor{
        darkModeOn = getstylePreference()
        if(darkModeOn){
            textClr  = UIColor.white // shall read from core data
        }else{
            textClr  = UIColor.black
        }
        return textClr
    }
    
    //
    private func getstylePreference()-> Bool{
        let darkMode =  usrDefualts.bool(forKey: "darkMode") // userDefaults keys
        return darkMode
    }
    
    
    //    private func setStylePreference(){
    //        usrDefualts.set(darkModeOn, forKey: "darkMode")
    //    }
}
