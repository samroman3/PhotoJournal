//
//  ViewController.swift
//  photoJournal
//
//  Created by Sam Roman on 9/29/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Outlets & Variables

    @IBOutlet weak var photoCollection: UICollectionView!
    
    @IBOutlet weak var addPhotoButton: UIButton!
    
    var pictures = [Picture]() {
        didSet {
            photoCollection.reloadData()
    }
    }
    
    
    
    //MARK: Private Methods & Lifecycle
    
    private func loadData(){
            do {
               pictures = try PhotoPersistenceHelper.manager.getPhoto()
            } catch {
                print(error)
            }
        }

    override func viewDidLoad() {
        photoCollection.delegate = self
        photoCollection.dataSource = self
        loadData()
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()

    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        loadData()
//        photoCollection.reloadData()
//    }


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
        return CGSize(width: 332, height: 395)
    }
    
}


