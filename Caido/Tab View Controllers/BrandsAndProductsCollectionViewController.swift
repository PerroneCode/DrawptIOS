//
//  RafflesViewController.swift
//  Caido
//
//  Created by Daniel on 8/12/18.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit
import Firebase

enum typeOfCollectionViewController
{
    case Raffle
    case Store
}

class BrandsAndProductsCollectionViewController : UICollectionViewController, UICollectionViewDelegateFlowLayout
{
    
    var user : User?

    var type : typeOfCollectionViewController?
    var products = [String:[Product]]()
    var brands = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(BrandCell.self, forCellWithReuseIdentifier: "brand-cell")
        collectionView?.register(SearchSupplementaryHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "search-header")
        collectionView?.backgroundColor = UIColor(red: 245, green: 245, blue: 245)
        
        view.backgroundColor = .white
        
        setupNavigationItemButtons()
        getProductsFromDatabase()
    }
    
    
    func setupNavigationItemButtons()
    {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(signUserOut))
        
        switch (type!)
        {
            case .Raffle: navigationItem.title = "Raffle"
            case .Store: navigationItem.title = "Store"
        }
    }
    
    @objc func signUserOut ()
    {
        if (signOut(user: self.user!))
        {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func getProductsFromDatabase()
    {
        var childReference = ""
        switch (type!)
        {
            case .Raffle: childReference = "raffles"
            case .Store: childReference = "available_products"
        }
        Database.database().reference().child(childReference).observeSingleEvent(of: .value, with: { (snapshot) in
            
            // First, get the dictionary
            if let initialDictionary = snapshot.value as? [String : Any]
            {
                // Extract all the category keys
                var keys = Set<String>()
                for (key, _) in initialDictionary
                {
                    keys.insert(key)
                }
                
                self.parseToProductCategory(keys: keys, initialDictionary: initialDictionary)
                self.collectionView?.reloadData()
            }
            
        }) { (error) in
            
            print("Error:\(error)")
            
        }
    }
    
    func parseToProductCategory (keys: Set<String>, initialDictionary: [String : Any])
    {
        // Make a dictionary out of every key in the keys set
        for key in keys
        {
            if let productCategoryDictionary = initialDictionary[key] as? [String : Any]
            {
                parseToProduct(productCategoryDictionary: productCategoryDictionary)
            }
        }
    }
    
    func parseToProduct (productCategoryDictionary : [String : Any])
    {
        // The key here is the UUID of the product
        for (key, _) in productCategoryDictionary
        {
            // Get the product
            if let productDictionary = productCategoryDictionary[key] as? [String : Any]
            {
                // If a brand exists
                if let brand = productDictionary["brand"] as? String
                {
                    // Then extract the product array
                    if let productArray = self.products[brand]
                    {
                        // Get a new array and append a new product to it
                        var array = productArray
                        array.append(Product(dictionary: productDictionary))
                        // Replace the array
                        self.products[brand] = array
                    } else // If no brand is found, then we create the new brand
                    {
                        var array = [Product]()
                        array.append(Product(dictionary: productDictionary))
                        self.products[brand] = array
                    }
                }
                // Make sure there are no repeats in brand cells
                if (!self.brands.contains(productDictionary["brand"] as! String))
                {
                    self.brands.append(productDictionary["brand"] as! String)
                }
            }
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return brands.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
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
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "search-header", for: indexPath) as! SearchSupplementaryHeaderView
        
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.1)
    }
    
    func presentProductViewController (name: String, size: String, photo: UIImage, price: String)
    {
        let productViewController = ProductViewController()
        
        productViewController.name = name
        productViewController.size = size
        productViewController.photo = photo
        productViewController.price = price
        
        navigationController?.pushViewController(productViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: view.frame.width, height: view.frame.height * 0.6)
    }
}
