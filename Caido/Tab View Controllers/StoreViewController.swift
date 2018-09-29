//
//  RafflesViewController.swift
//  Caido
//
//  Created by Daniel on 8/12/18.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit
import Firebase

class StoreViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{

    var products = [String:[Product]]()
    var brands = [String]()
    var numberOfCells = 0

    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        setupNavigationItemButtons()
        getProductsFromDatabase()
        setupCollectionView()
        setupSearchTextFieldBackgroundView()
        setupMagnifyingGlassView()
        setupSearchTextField()
    }
    
    func setupNavigationItemButtons()
    {
        navigationItem.title = "Store"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(signUserOut))
    }
    
    @objc func signUserOut ()
    {
        do {
            try Auth.auth().signOut()
            print("Successfully signed user out")
            
            if let user = Auth.auth().currentUser
            {
                removeSessionTracker(uid: user.uid)
            }
            
            dismiss(animated: true, completion: nil)
        } catch let error as NSError
        {
            print("Error:\(error)")
        }
    }
    
    func getProductsFromDatabase()
    {
        Database.database().reference().child("available_products").child("shoes").observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            // Eech iteration is a product dictionary
            for (key, _) in dictionary
            {
                // We must cast it as another dictionary once again
                guard let anotherDictionary = dictionary[key] as? [String : Any] else { return }
                
                if let brand = anotherDictionary["brand"] as? String
                {
                    if let productArray = self.products[brand]
                    {
                        var array = productArray
                        array.append(Product(dictionary: anotherDictionary))
                        self.products[brand] = array
                    } else // If nil, we create the new array
                    {
                        var array = [Product]()
                        array.append(Product(dictionary: anotherDictionary))
                        self.products[brand] = array
                    }
                }
                
                
                // Make sure there are no repeats in brand cells
                if (!self.brands.contains(anotherDictionary["brand"] as! String))
                {
                    self.brands.append(anotherDictionary["brand"] as! String)
                }
                
            }
            self.refreshCollectionView()
        }) { (error) in
            
            print("Error:\(error)")
            
        }
    }
    
    func refreshCollectionView ()
    {
        numberOfCells = brands.count
        
        var indexPaths = [IndexPath]()
        
        var i = 0
        
        while (i < brands.count)
        {
            let indexPath = IndexPath(row: i, section: 0)
            indexPaths.append(indexPath)
            i += 1
        }
        
        collectionView.insertItems(at: indexPaths)
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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brand-cell", for: indexPath) as! BrandCell
        
        cell.storeViewController = self
        
        if brands.count != 0
        {
            cell.brandLabel.text = brands[indexPath.row]
            
            if products[brands[indexPath.row]]?.count != 0
            {
                cell.products = self.products[brands[indexPath.row]]!
                cell.numberOfCells = cell.products.count
            }
        }
        return cell
    }
    
    func presentProductViewController (name: String, size: String, photo: UIImage)
    {
        let productViewController = ProductViewController()
        
        productViewController.name = name
        productViewController.size = size
        productViewController.photo = photo
        
        navigationController?.pushViewController(productViewController, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: view.frame.width, height: view.frame.height / 1.5)
    }
    
}
