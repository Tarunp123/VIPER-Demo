//
//  GalleryView.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 9/28/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import UIKit

class GalleryView: UIViewController {

    private var galleryCollectionView : UICollectionView!
    private var galleryCellId = "GalleryCell"
    private var cellPadding : CGFloat = 10
    
    
    var presenter: GalleryPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Gallery"
        self.navigationItem.title = "Recent Photos"
        
        self.presenter?.viewDidLoad()
    }

    

}


extension GalleryView : GalleryViewProtocol{
    
    func setupView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        self.galleryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.galleryCollectionView.backgroundColor = UIColor.groupTableViewBackground
        self.galleryCollectionView.dataSource = self
        self.galleryCollectionView.delegate = self
        self.galleryCollectionView.register(GalleryCell.self, forCellWithReuseIdentifier: self.galleryCellId)
        self.view.addSubview(self.galleryCollectionView)
        self.galleryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.galleryCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.galleryCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.galleryCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.galleryCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
    }
    
    
    func updateView() {
        DispatchQueue.main.async {
            self.galleryCollectionView.reloadData()
        }
    }
    
}


extension GalleryView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter?.numberOfPhotosToShow() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: galleryCellId, for: indexPath) as! GalleryCell
        _ =  self.presenter?.photoAtIndex(index: indexPath.row)
        return cell
    }
    
}


extension GalleryView : UICollectionViewDelegate{

}

extension GalleryView : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: cellPadding, left: cellPadding, bottom: cellPadding, right: cellPadding)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.galleryCollectionView.frame.width-cellPadding*3)/2
        return CGSize(width: width, height: width)
    }
    
}



