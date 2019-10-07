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
    
    @IBAction func darkModeAction(_ sender: UISwitch) {
        UserDefaultsWrapper.wrapper.storeMode(darkMode: sender.isOn)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil )
    }
    
    
    private func setMode(){
        darkModeOutlet.isOn = UserDefaultsWrapper.wrapper.getDarkModeSetting() ?? false
    }
    
    override func viewDidLoad() {
        setMode()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
