//
//  NewImageViewController.swift
//  photoJournal
//
//  Created by Sam Roman on 9/30/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class NewImageViewController: UIViewController {

    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var saveOutlet: UIButton!
    
    
    

    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
                  
    }
    @IBAction func folderButton(_ sender: UIButton) {
        imagePickerViewcontroller.sourceType = .photoLibrary
        present(imagePickerViewcontroller, animated: true, completion: nil)
    }
  
    @IBAction func saveAction(_ sender: UIButton) {
        if let imageData = newImage.image?.jpegData(compressionQuality: 0.5) {
            let picture = Picture(createdAt: nil, image: imageData, name: name)
                PhotoJournalModel.addPhotos(photo: photoJournal)
            }
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    var name: String?{
        didSet{
            saveOutlet.isEnabled = true
        }
    }
    
    private var imagePickerViewcontroller: UIImagePickerController!
    
    
    private func setupImagePickerViewController() {
            imagePickerViewcontroller = UIImagePickerController()
            imagePickerViewcontroller.delegate = self
//            if !UIImagePickerController.isSourceTypeAvailable(.camera) {
//
//            }
    }
    
    override func viewDidLoad() {
        setupImagePickerViewController()
        nameField.delegate = self
        super.viewDidLoad()
    }

}

extension NewImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Info dictionary of key and value(Image)
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage.image = image
        } else {
            print("original image is nil")
        }
        dismiss(animated: true, completion: nil)
    }
}

extension NewImageViewController: UITextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        guard textField.text == nil else { return false }
        saveOutlet.isEnabled = false
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            guard textField.text != nil else { return false }
            name = textField.text
            return true
        
    }
   

}
