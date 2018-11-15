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
    
    lazy var productNameLabel : UILabel =
    {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: self.name + " ▼", attributes: [NSAttributedStringKey.foregroundColor : UIColor(red: 53, green: 65, blue: 83), kCTFontAttributeName as NSAttributedStringKey : UIFont(name: "Helvetica", size: 20)!])
        label.adjustsFontSizeToFitWidth = true
        label.attributedText = attributedText
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        
        return label
    }()
    
    lazy var priceLabel : UILabel =
    {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: self.price, attributes: [NSAttributedStringKey.foregroundColor : UIColor(red: 53, green: 65, blue: 83), kCTFontAttributeName as NSAttributedStringKey : UIFont(name: "Helvetica", size: 25)!])
        label.adjustsFontSizeToFitWidth = true
        label.attributedText = attributedText
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.bold)
        
        return label
    }()
    
    lazy var availableColorView : UIView =
    {
        let view = UIView()
        
        view.backgroundColor = UIColor.red
        view.layer.cornerRadius = 17.5
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1.0
        
        return view
    }()
    
    var sizeComboBox : UIView =
    {
        let view = UIView()
        
        view.backgroundColor = UIColor.white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2.0
        
        let sizeTextLabel : UILabel =
        {
            let label = UILabel()
            label.text = "Size"
            return label
        }()
        
        let triangleLabel : UILabel =
        {
            let label = UILabel()
            label.text = "▼"
            label.textAlignment = .right
            return label
        }()
        
        view.addSubview(sizeTextLabel)
        
        sizeTextLabel.anchor(top: view.topAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 2, paddingBottom: 2, paddingLeft: 10, paddingRight: 50, width: 0, height: 0)
        
        view.addSubview(triangleLabel)
        
        triangleLabel.anchor(top: view.topAnchor, bottom: view.bottomAnchor, left: sizeTextLabel.rightAnchor, right: view.rightAnchor, paddingTop: 2, paddingBottom: 2, paddingLeft: 10, paddingRight: 10, width: 0, height: 0)

        return view
    }()
    
    let purchaseRaffleTicketButton : UIButton =
    {
        let button = UIButton(type: .system)
        button.setTitle("Purchase Raffle Ticket", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 15)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        button.backgroundColor = UIColor.red
        button.layer.cornerRadius = 20
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNavigationItem()
        setupProductImagesCollectionView()
        setupProductNameLabel()
        setupPriceLabel()
        setupAvailableColorView()
        setupSizeComboBox()
        setupPurchaseRaffleTicketButton()
     //   setupProductTabs()
    }
    
    func setupNavigationItem ()
    {
        navigationItem.title = "Product"
    }
    
    func setupProductImagesCollectionView ()
    {
        view.addSubview(productImagesCollectionView)
        
        productImagesCollectionView.anchor(top: view.topAnchor, bottom: view.centerYAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func setupProductNameLabel ()
    {
        view.addSubview(productNameLabel)
        
        productNameLabel.anchor(top: productImagesCollectionView.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10, paddingBottom: 0, paddingLeft: 15, paddingRight: 15, width: 0, height: 30)
    }
    
    func setupPriceLabel ()
    {
        view.addSubview(priceLabel)
        
        priceLabel.anchor(top: productNameLabel.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 20)
    }
    
    func setupAvailableColorView ()
    {
        let seperatorView = UIView()
        
        view.addSubview(seperatorView)
        
        seperatorView.backgroundColor = UIColor.black
        seperatorView.anchor(top: priceLabel.bottomAnchor, bottom: nil, left: nil, right: nil, paddingTop: 15, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 35, height: 1)
        seperatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        view.addSubview(availableColorView)
        
        availableColorView.anchor(top: seperatorView.bottomAnchor, bottom: nil, left: nil, right: nil, paddingTop: 15, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 35, height: 35)
        availableColorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    func setupSizeComboBox ()
    {
        view.addSubview(sizeComboBox)
        
        sizeComboBox.anchor(top: availableColorView.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingBottom: 0, paddingLeft: 75, paddingRight: 75, width: 0, height: 35)
    }
    
    func setupPurchaseRaffleTicketButton ()
    {
        view.addSubview(purchaseRaffleTicketButton)
        
        purchaseRaffleTicketButton.anchor(top: sizeComboBox.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 25, paddingBottom: 0, paddingLeft: 55, paddingRight: 55, width: 0, height: 45)
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
