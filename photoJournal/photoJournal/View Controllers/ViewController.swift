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

@IBOutlet weak var photoCollection: UICollectionView!

@IBOutlet weak var addPhotoButton: UIButton!

@IBAction func addPhotoAction(_ sender: UIButton) {
    
}
    
var BGColor = UIColor(red: 218, green: 222, blue: 218, alpha: 1)
var textColor: UIColor?
var photoLibraryAccess = false
var scrollDirection = UserDefaultsWrapper.wrapper.getScrollDirection() ?? false
    
var pictures = [Picture]() {
    didSet {
        photoCollection.reloadData()
}
}

override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
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
    setMode()
    setNeedsStatusBarAppearanceUpdate()
    setScroll()
    super.viewDidLoad()

}

override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    loadData()
    setMode()
    setScroll()
    setNeedsStatusBarAppearanceUpdate()

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
    cell.name.textColor = textColor
    cell.photoImag.image = UIImage(data: index.image!)
    cell.photoMenu.tag = indexPath.row
    cell.delegate = self as? PhotoDelegate
    cell.backgroundColor = BGColor
   
    
    return cell
}

func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 413, height: 326)
}

}



//MARK: ActionSheet Delegate Extension

extension ViewController: PhotoDelegate {
func showActionSheet(tag: Int) {
let optionsMenu = UIAlertController.init(title: "Options", message: "Make Selection", preferredStyle: .actionSheet)

let shareAction = UIAlertAction.init(title: "Share", style: .default) { (action) in
    let image = UIImage(data: self.pictures[tag].image!)

    let share = UIActivityViewController(activityItems: [image!], applicationActivities: [])
    self.present(share, animated: true, completion: nil)
}

let deleteAction = UIAlertAction.init(title: "Delete", style: .destructive) { (action) in
let pic = self.pictures[tag]
print("deleting \(pic.name)")
do {
    try PhotoPersistenceHelper.manager.delete(picArray: self.pictures, index: tag)
    self.loadData()
} catch {
    return
}
}
let editAction = UIAlertAction.init(title: "Edit", style: .default) { (action) in
    let pic = self.pictures[tag]
    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    let newImageVC = (storyboard.instantiateViewController(identifier: "NewImageVC")) as! NewImageViewController
    newImageVC.picture = pic
    newImageVC.index = tag
    newImageVC.modalPresentationStyle = .currentContext
    self.present(newImageVC, animated: true)
    
}

let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
optionsMenu.addAction(editAction)
optionsMenu.addAction(shareAction)
optionsMenu.addAction(deleteAction)
optionsMenu.addAction(cancelAction)
present(optionsMenu,animated: true,completion: nil)


}

}



//MARK: UI Design Extension

extension ViewController {
    
    private func setMode(){
        let mode = UserDefaultsWrapper.wrapper.getDarkModeSetting()
        switch mode{
        case true:
            self.photoCollection.backgroundColor =  UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
        self.BGColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
        self.textColor = UIColor.black
        case false:
        self.photoCollection.backgroundColor = UIColor(red: 218/255, green: 222/255, blue: 218/255, alpha: 1)
        self.BGColor = UIColor.white
        self.textColor = UIColor.black
        default:
        self.photoCollection.backgroundColor = UIColor(red: 218/255, green: 222/255, blue: 218/255, alpha: 1)
        self.BGColor = UIColor.white
        self.textColor = UIColor.black
        }
    }
    
    private func setScroll(){
        let layout = photoCollection.collectionViewLayout as? UICollectionViewFlowLayout
        switch scrollDirection{
        case true:
            layout!.scrollDirection = .horizontal
            photoCollection.reloadData()
        case false:
            layout!.scrollDirection = .vertical
            photoCollection.reloadData()
    }
}
}



