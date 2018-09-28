//
//  GalleryCell.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 9/28/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import UIKit

import UIKit

class GalleryCell: UITableViewCell {
    
    var horizontalCollectionView : UICollectionView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.green
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        self.horizontalCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.horizontalCollectionView.backgroundColor = UIColor.red
        self.horizontalCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.contentView.addSubview(self.horizontalCollectionView)
        self.horizontalCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.horizontalCollectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.horizontalCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.horizontalCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        self.horizontalCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
