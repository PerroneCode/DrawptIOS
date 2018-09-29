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
    var storeViewController = StoreViewController()
    
    let brandLabel : UILabel =
    {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 25)
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.ultraLight)
        label.translatesAutoresizingMaskIntoConstraints = false
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
            collectionView.translatesAutoresizingMaskIntoConstraints = false
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
        
        collectionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    func setupBrandLabel ()
    {
        addSubview(brandLabel)
        
        brandLabel.leftAnchor.constraint(equalTo: collectionView.leftAnchor, constant: 24).isActive = true
        brandLabel.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 40).isActive = true
        brandLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        brandLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05).isActive = true
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
                    DispatchQueue.main.async
                    {
                        cell.productImageView.image = UIImage(data: data!)
                    }
                
                }.resume()
            }
        }
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width * 0.8, height: collectionView.frame.height * 0.60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
