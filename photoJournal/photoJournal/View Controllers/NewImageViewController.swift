//
//  NewImageViewController.swift
//  photoJournal
//
//  Created by Sam Roman on 9/30/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit
import Photos

class NewImageViewController: UIViewController {

    //MARK: Outlets & Variables
    
    private var name: String?
    
    var photoLibraryAccess = false
    
    weak var delegate: SaveDelegate?
    
    var picture: Picture?
    
    var index: Int?
      
    private var imagePickerViewcontroller: UIImagePickerController!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var saveOutlet: UIButton!
    @IBOutlet weak var cameraOutlet: UIButton!
    
    
    //MARK: Button Actions
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
                  
    }
    @IBAction func folderButton(_ sender: UIButton) {
        imagePickerViewcontroller.sourceType = .photoLibrary
        present(imagePickerViewcontroller, animated: true, completion: nil)
    }
    
    
    @IBAction func cameraButton(_ sender: UIButton) {
        imagePickerViewcontroller.sourceType = .camera
        present(imagePickerViewcontroller, animated: true)
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        if self.picture == nil {
            save()
        } else {
            edit()
            }
        }
    

    
    
    
    //MARK: Private Methods and Lifecycle
    
    private func setUpEdit(){
        if picture != nil {
            newImage.image = UIImage(data: (picture?.image)!)
            nameField.text = picture?.name
            saveOutlet.isEnabled = true
        }
    }
    
    private func save(){
        guard let image = newImage.image else { return }
               let data = image.pngData()
                   let picture = Picture(createdAt: nil, image: data, name: name ?? "")
                   do {
                       DispatchQueue.global(qos: .utility).async {
                       try? PhotoPersistenceHelper.manager.save(newPhoto: picture)
                         DispatchQueue.main.async {
                           self.dismiss(animated: true, completion: nil)
                         }
                   }
           }
    }
    
    private func edit(){
        guard let image = newImage.image else { return }
               let data = image.pngData()
                   let picture = Picture(createdAt: nil, image: data, name: name ?? "")
                   do {
                       DispatchQueue.global(qos: .utility).async {
                        try? PhotoPersistenceHelper.manager.editPhoto(element: picture, index: self.index!)
                         DispatchQueue.main.async {
                           self.dismiss(animated: true, completion: nil)
                         }
                   }
           }
    }
    
    
    private func setupImagePickerViewController() {
            imagePickerViewcontroller = UIImagePickerController()
            imagePickerViewcontroller.delegate = self
            if !UIImagePickerController.isSourceTypeAvailable(.camera) {
                cameraOutlet.isEnabled = false
            }
    }
    
    override func viewDidLoad() {
        setupImagePickerViewController()
        setUpEdit()
        setNeedsStatusBarAppearanceUpdate()
        nameField.delegate = self
        super.viewDidLoad()
    }

}


    //MARK: ImagePicker Extension

extension NewImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage.image = image
            self.cameraOutlet.isHidden = true
        } else {
            print("original image is nil")
        }
        saveOutlet.isEnabled = true
        dismiss(animated: true, completion: nil)
        
    }
}


//MARK: TextFieldDelegate Extension

extension NewImageViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField.text != nil else {
            saveOutlet.isEnabled = false
            return false
        }
            name = textField.text
            return true
    }
    
   

}
