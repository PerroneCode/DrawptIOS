//
//  RafflesViewController.swift
//  Caido
//
//  Created by Daniel on 8/12/18.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit

class StoreViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    let numberOfCells = 5
    
    lazy var collectionView : UICollectionView =
        {
            let layout = UICollectionViewFlowLayout()
            let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
            collectionView.register(BrandCell.self, forCellWithReuseIdentifier: "brand-cell")
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.backgroundColor = UIColor(red: 245, green: 245, blue: 245)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            return collectionView
    }()
    
    let searchTextFieldBackgroundView : UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor(red: 234, green: 235, blue: 237)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let searchTextField : UITextField =
    {
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.font = UIFont(name: "Helvetica", size: 15)
        textField.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.ultraLight)
        textField.textAlignment = .left
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let magnifyingGlassImageView : UIImageView =
    {
        let imageView = UIImageView(image: UIImage(named: "magnifying-glass"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let storeLabel : UILabel =
    {
        let label = UILabel()
        label.text = "Store"
        label.font = UIFont(name: "Helvetica", size: 34)
        label.font = UIFont.systemFont(ofSize: 34, weight: UIFont.Weight.light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        setupCollectionView()
        setupSearchTextFieldBackgroundView()
        setupMagnifyingGlassView()
        setupSearchTextField()
        setupRafflesLabel()
    }
    
    
    func setupCollectionView ()
    {
        view.addSubview(collectionView)
        
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.75).isActive = true
    }
    
    func setupSearchTextFieldBackgroundView ()
    {
        view.addSubview(searchTextFieldBackgroundView)
        
        searchTextFieldBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchTextFieldBackgroundView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -15).isActive = true
        searchTextFieldBackgroundView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        searchTextFieldBackgroundView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    func setupMagnifyingGlassView ()
    {
        searchTextFieldBackgroundView.addSubview(magnifyingGlassImageView)
        
        magnifyingGlassImageView.leftAnchor.constraint(equalTo: searchTextFieldBackgroundView.leftAnchor, constant: 10).isActive = true
        magnifyingGlassImageView.centerYAnchor.constraint(equalTo: searchTextFieldBackgroundView.centerYAnchor).isActive = true
        magnifyingGlassImageView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        magnifyingGlassImageView.heightAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    func setupSearchTextField ()
    {
        searchTextFieldBackgroundView.addSubview(searchTextField)
        
        searchTextField.leftAnchor.constraint(equalTo: magnifyingGlassImageView.leftAnchor, constant: 15).isActive = true
        searchTextField.centerYAnchor.constraint(equalTo: searchTextFieldBackgroundView.centerYAnchor).isActive = true
        searchTextField.widthAnchor.constraint(equalTo: searchTextFieldBackgroundView.widthAnchor, multiplier: 0.98).isActive = true
        searchTextField.heightAnchor.constraint(equalTo: searchTextFieldBackgroundView.heightAnchor).isActive = true
    }
    
    func setupRafflesLabel ()
    {
        view.addSubview(storeLabel)
        
        storeLabel.leftAnchor.constraint(equalTo: searchTextFieldBackgroundView.leftAnchor).isActive = true
        storeLabel.bottomAnchor.constraint(equalTo: searchTextFieldBackgroundView.topAnchor, constant: -10).isActive = true
        storeLabel.widthAnchor.constraint(equalTo: searchTextFieldBackgroundView.widthAnchor).isActive = true
        storeLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brand-cell", for: indexPath) as! BrandCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: view.frame.width, height: view.frame.height / 1.5)
    }
    
}
