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
    }
    
    
    override func viewDidLoad() {
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
