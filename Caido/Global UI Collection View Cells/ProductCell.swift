//
//  ProductCell.swift
//  Caido
//
//  Created by Daniel on 8/19/18.
//  Copyright © 2018 Daniel. All rights reserved.
//


import UIKit

class ProductCell : UICollectionViewCell
{
    var storeViewController = StoreCollectionViewController()
    
    let productNameLabel : UILabel =
    {
        let label = UILabel()
        label.text = ""
        label.font = label.font.withSize(20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel : UILabel =
    {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 15)
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
        label.textColor = UIColor(red: 155, green: 155, blue: 155)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var productImageView : UIImageView =
    {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(presentProductViewController)))
        
        return imageView
    }()
    
    @objc func presentProductViewController ()
    {
      //  storeViewController.presentProductViewController(name: productNameLabel.text!, size: descriptionLabel.text!, photo: productImageView.image!)
    }
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        backgroundColor = UIColor.white
        
        setupShadow()
        setupProductImageView()
        setupProductNameLabel()
        setupDescriptionLabel()
    }
    
    func setupShadow()
    {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 10, height: 10)
    }
    
    func setupProductImageView ()
    {
        addSubview(productImageView)
        
        productImageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 40, paddingBottom: 40, paddingLeft: 20, paddingRight: 20, width: 0, height: 0)
    }
    
    func setupProductNameLabel ()
    {
        addSubview(productNameLabel)
        
        productNameLabel.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 5, paddingRight: 5, width: 0, height: 60)
    }
    
    func setupDescriptionLabel ()
    {
        addSubview(descriptionLabel)
        
        descriptionLabel.anchor(top: nil, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 5, paddingRight: 5, width: 0, height: 35)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
