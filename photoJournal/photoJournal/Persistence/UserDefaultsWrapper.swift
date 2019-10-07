//
//  UserDefaultsWrapper.swift
//  photoJournal
//
//  Created by Sam Roman on 10/4/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import Foundation
import UIKit

class UserDefaultsWrapper {

    // MARK: - singleton
    
    static let wrapper = UserDefaultsWrapper()

    // MARK: - getters
    
    func getDarkModeSetting() -> Bool? {
        return UserDefaults.standard.value(forKey: "DarkMode") as? Bool
    }
    
    func getLightText() -> UIColor? {
        return UIColor.darkGray
    }
    
    func getDarkText() -> UIColor? {
        return UIColor.white
    }
    
//    func getVerticalScroll() -> ScrollDirection

    
    // MARK: - setters
    
    func storeMode(darkMode: Bool) {
        UserDefaults.standard.set(darkMode, forKey: "DarkMode")
    }
    
    func storeLightTextColor(){
        UserDefaults.standard.set(UIColor.black, forKey: "LightText")
    }


    // MARK: - private keyNames
    
   
}

enum ScrollDirection {
    case vertical
    case horizontal
}
