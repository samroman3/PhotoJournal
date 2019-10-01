//
//  ViewController.swift
//  photoJournal
//
//  Created by Sam Roman on 9/29/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {
    
    //MARK: Outlets & Variables
    
    var photoLibraryAccess = false

    @IBOutlet weak var photoCollection: UICollectionView!
    
    @IBOutlet weak var addPhotoButton: UIButton!
    
    @IBAction func addPhotoAction(_ sender: UIButton) {
        
    }
    
    @IBAction func menuButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "options", message: "make a selection", preferredStyle: .actionSheet)
        let delete = UIAlertAction(title: "delete", style: .destructive) { (action) in
            self.deleteObject(arr: self.pictures, index: sender.tag)
            self.photoCollection.reloadData()
            
        }
       
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(delete)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    var pictures = [Picture]() {
        didSet {
            photoCollection.reloadData()
    }
    }
    
    
    
    
    //MARK: Private Methods & Lifecycle
    
    private func checkPhotoLibraryAccess() {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized:
            print(status)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({status in
                switch status {
                case .authorized:
                    self.photoLibraryAccess = true
                    print(status)
                case .denied:
                    self.photoLibraryAccess = false
                    print("denied")
                case .notDetermined:
                    print("not determined")
                case .restricted:
                    print("restricted")
                }
            })
            
        case .denied:
            let alertVC = UIAlertController(title: "Denied", message: "Camera access is required to use this app. Please change your preference in the Settings app", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction (title: "Ok", style: .default, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        case .restricted:
            print("restricted")
        }
    }
    
    private func loadData(){
            do {
               pictures = try PhotoPersistenceHelper.manager.getPhoto()
            } catch {
                print(error)
            }
        }
    
    private func deleteObject(arr: [Picture], index: Int){
        do {
            try PhotoPersistenceHelper.manager.delete(picArray: arr, index: index)
            loadData()
        } catch {
            print("unable to delete")
        }
    }

    override func viewDidLoad() {
        photoCollection.delegate = self
        photoCollection.dataSource = self
        loadData()
        checkPhotoLibraryAccess()
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()

    }

}



    //MARK: CollectionView Extension

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = pictures[indexPath.row]
        guard let cell = photoCollection.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        cell.name.text = index.name
        cell.photoImag.image = UIImage(data: index.image!)
        
        return cell
    }
    
  
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 370, height: 507)
    }
    
}



    

