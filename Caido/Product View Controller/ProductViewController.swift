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
    
    lazy var productImagesCollectionView : UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(ProductImagesCollectionCell.self, forCellWithReuseIdentifier: "product-images-collection-view")
        
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNavigationItem()
        setupProductImagesCollectionView()
     //   setupProductTabs()
    }
    
    func setupNavigationItem ()
    {
        navigationItem.title = name
    }
    
    func setupProductImagesCollectionView ()
    {
        view.addSubview(productImagesCollectionView)
        
        productImagesCollectionView.anchor(top: view.topAnchor, bottom: view.centerYAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: self.navigationItem.accessibilityFrame.height, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product-images-collection-view", for: indexPath) as! ProductImagesCollectionCell
        
        cell.productImageView.image = photo
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: UIScreen.main.bounds.width * 0.7, height: collectionView.bounds.height)
    }
}
