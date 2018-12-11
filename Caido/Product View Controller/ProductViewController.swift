//
//  ProductViewController.swift
//  Caido
//
//  Created by Daniel on 9/26/18.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit
import Firebase


class ProductViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    var name = String()
    var size = String()
    var photo = UIImage()
    var price = String()
    
    lazy var productPhotosCollectionView : UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "photo-cell")
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        setupNavigationItemButtons()
        setupProductPhotosCollectionView ()
    }
    
    func setupNavigationItemButtons ()
    {
        navigationItem.title = name
    }
    
    func setupProductPhotosCollectionView ()
    {
        view.addSubview(productPhotosCollectionView)
        
        if let navController = navigationController
        {
            productPhotosCollectionView.anchor(top: view.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: navController.navigationBar.frame.height, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 250)
        }
    }
    
    // productPhotosCollectionView delegate methods
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photo-cell", for: indexPath) as! PhotoCell
        
        cell.productPhotoImageView.image = photo
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width * 0.50, height: collectionView.frame.height * 0.75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}


class PhotoCell : UICollectionViewCell
{
    
    let productPhotoImageView : UIImageView =
    {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init (frame : CGRect)
    {
        super.init(frame : frame)
        
        setupCellCustomizations()
        setupProductPhotoImageView()
    }
    
    func setupCellCustomizations ()
    {
        backgroundColor = UIColor.white
        layer.cornerRadius = 10
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 10, height: 10)
    }
    
    func setupProductPhotoImageView ()
    {
        addSubview(productPhotoImageView)
        
        productPhotoImageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
