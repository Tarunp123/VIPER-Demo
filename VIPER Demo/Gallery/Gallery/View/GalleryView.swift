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
    private var lowResImageOfSelectedPhoto : UIImage?
    
    var presenter: GalleryPresenterProtocol?
    
    private var activityIndicator : UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }

    private var selectedImageIndex = -1;

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
    
    func expandPhotoAtIndex(index: Int) {
        DispatchQueue.main.async {
            self.galleryCollectionView.performBatchUpdates({
                if(index == self.selectedImageIndex){
                    self.selectedImageIndex = -1
                    self.galleryCollectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
                }else{
                    if let lowResImage = (self.galleryCollectionView.cellForItem(at: IndexPath(row: index, section: 0)) as? GalleryCell)?.imageView.image{
                        self.lowResImageOfSelectedPhoto = lowResImage
                    }
                    if self.selectedImageIndex == -1{
                        self.galleryCollectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
                    }else{
                        self.galleryCollectionView.reloadItems(at: [IndexPath(row: index, section: 0), IndexPath(row: self.selectedImageIndex, section: 0)])
                    }
                    self.selectedImageIndex = index
                }
                
            }) { (completedSuccessfully) in
                self.galleryCollectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .top, animated: true)
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
            //checking if image is selected
            if self.selectedImageIndex == indexPath.row{
                //change cell bg color same as collectionview bg color to make photo look more immersive
                cell.imageView.backgroundColor = collectionView.backgroundColor
                
                //use high res image for selected image
                //put low res image as placeholder
                cell.imageView.image = self.lowResImageOfSelectedPhoto

                //then load the high res image
                cell.imageView.moa.url = photo.URLString
            }else{
                //use low res image for not selected photo
                cell.imageView.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.5)
                cell.imageView.moa.url = photo.thumbnailURLString
            }
        }
        return cell
    }
    
}


extension GalleryView : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter?.didSelectPhotoAtIndex(index: indexPath.row)
    }
    
    

}



extension GalleryView : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: cellPadding, left: cellPadding, bottom: cellPadding, right: cellPadding)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //FullSreen for selected photos
        if(indexPath.row == self.selectedImageIndex){
            var height = self.galleryCollectionView.frame.height - cellPadding*2
            height -= (self.navigationController?.navigationBar.frame.height ?? 0)
            height -= (self.tabBarController?.tabBar.frame.size.height ?? 0)
            return CGSize(width: self.galleryCollectionView.frame.width - cellPadding*2, height: height)
        }
        
        //Thumbnail for other photos
        let width = (self.galleryCollectionView.frame.width-cellPadding*3)/2
        return CGSize(width: width, height: width)
    }
    
}



