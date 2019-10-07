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
        UserDefaultsWrapper.wrapper.storeMode(darkMode: sender.isOn)
    }
    
    @IBAction func scrollAction(_ sender: UISwitch) {
        UserDefaultsWrapper.wrapper.storeScroll(scrollDirection: sender.isOn)
    }
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil )
    }
    
    
    private func setMode(){
        darkModeOutlet.isOn = UserDefaultsWrapper.wrapper.getDarkModeSetting() ?? false
        scrollOutlet.isOn = UserDefaultsWrapper.wrapper.getScrollDirection() ?? false
    }
    
    override func viewDidLoad() {
        setMode()
        super.viewDidLoad()

    }
    


}
