//
//  PhotoSettingsViewController.swift
//  photoJournal
//
//  Created by Sam Roman on 10/6/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class PhotoSettingsViewController: UIViewController {
    @IBOutlet weak var settingsLabel: UILabel!
    
    @IBOutlet weak var darkModeLabel: UILabel!
    
    @IBOutlet weak var darkModeOutlet: UISwitch!
    
    @IBOutlet weak var scrollOutlet: UISwitch!
    
    @IBAction func darkModeAction(_ sender: UISwitch) {
        setViews()
        UserDefaultsWrapper.wrapper.storeMode(darkMode: sender.isOn)
    }
    
    @IBAction func scrollAction(_ sender: UISwitch) {
        UserDefaultsWrapper.wrapper.storeScroll(scrollDirection: sender.isOn)
    }
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil )
    }
    
    
    
    override func viewDidLoad() {
        setViews()

        super.viewDidLoad()

    }
    
    
    func setViews(){
        switch darkModeOutlet.isOn {
        case true:
            settingsLabel.textColor = UIColor(red: 218/255, green: 222/255, blue: 218/255, alpha: 1)
            self.view.backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
        case false:
            settingsLabel.textColor = UIColor.black
             self.view.backgroundColor = UIColor(red: 218/255, green: 222/255, blue: 218/255, alpha: 1)
        }
    }
    

    

}

