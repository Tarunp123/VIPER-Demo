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
    
    private var activityIndicator : UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    
    func showLoadingIndicator() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            if let activityIndicator = self.activityIndicator{
                activityIndicator.startAnimating()
                return
            }
            self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            self.activityIndicator?.hidesWhenStopped = true
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.activityIndicator!)
            self.activityIndicator?.startAnimating()
        }
    }
    
    
    func removeLoadingIndicator() {
        DispatchQueue.main.async {
            if let activityIndicator = self.activityIndicator{
                activityIndicator.stopAnimating()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    
}


extension GalleryView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter?.numberOfPhotosToShow() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: galleryCellId, for: indexPath) as! GalleryCell
        cell.imageView.image = nil
        if let photo = self.presenter?.photoAtIndex(index: indexPath.row){
            cell.imageView.moa.url = photo.thumbnailURLString
        }
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



