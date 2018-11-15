//
//  BrandCell.swift
//  Caido
//
//  Created by Daniel on 8/19/18.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit

class BrandCell : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    var products = [Product]()
    var brands = [String]()
    var numberOfCells = 0
    var storeViewController = BrandsAndProductsCollectionViewController()
    
    let brandLabel : UILabel =
    {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 25)
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
        return label
    }()
    
    lazy var collectionView : UICollectionView =
        {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 15
            let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "product-cell")
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.backgroundColor = UIColor(red: 245, green: 245, blue: 245)
            return collectionView
    }()
    
    override init (frame: CGRect)
    {
        super.init(frame: CGRect.zero)
        setupCollectionView()
        setupBrandLabel()
    }
    
    func setupCollectionView ()
    {
        addSubview(collectionView)
        
        collectionView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func setupBrandLabel ()
    {
        addSubview(brandLabel)
        
        brandLabel.anchor(top: collectionView.topAnchor, bottom: nil, left: collectionView.leftAnchor, right: nil, paddingTop: 10, paddingBottom: 0, paddingLeft: 24, paddingRight: 0, width: 0, height: 0)
        brandLabel.widthAndHeightByPercentOfParent(widthPercent: 1.0, heightPercent: 0.05, parentWidthAnchor: widthAnchor, parentHeightAnchor: heightAnchor)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product-cell", for: indexPath) as! ProductCell
        
        cell.storeViewController = storeViewController
        
        if let product_name = products[indexPath.row].product_name
        {
            cell.productNameLabel.text = product_name
        }
        
        if let size = products[indexPath.row].size
        {
            cell.descriptionLabel.text = "Size: \(size)"
        }
        
        if let price = products[indexPath.row].price
        {
            cell.priceLabel.text = "$\(price)"
        }
        
        if let photo_url = products[indexPath.row].photo_url
        {
            if let url = URL(string: photo_url)
            {
                URLSession.shared.dataTask(with: url)
                { (data, response, error) in
                
                    if let error = error
                    {
                        print("Error:\(error)")
                        return
                    }
                    if let photoData = data
                    {
                        DispatchQueue.main.async
                        {
                            cell.productImageView.image = UIImage(data: photoData)
                        }
                    }
                }.resume()
            }
        }
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width * 0.8, height: collectionView.frame.height * 0.75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
