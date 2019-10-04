//
//  PhotoCollectionViewCell.swift
//  photoJournal
//
//  Created by Sam Roman on 9/29/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: PhotoDelegate?
    
    @IBOutlet weak var photoImag: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var date: UILabel!

    
    @IBOutlet weak var photoMenu: UIButton!
    
    @IBAction func photoMenuAction(_ sender: UIButton) {
         delegate?.showActionSheet(tag: sender.tag)
    }
    
    
    
    
    
    
}
