//
//  ProductImagesCollectionView.swift
//  Caido
//
//  Created by Daniel on 9/29/18.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit

class ProductImagesCollectionCell : UICollectionViewCell
{
    
    let productImageView : UIImageView =
    {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init (frame: CGRect)
    {
        super.init(frame: frame)
        
        setupProductImageView()
    }
    
    func setupProductImageView ()
    {
        addSubview(productImageView)
        
        productImageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
