//
//  RafflesViewController.swift
//  Caido
//
//  Created by Daniel on 8/12/18.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit
import Firebase

class RafflesCollectionViewController : UICollectionViewController, UICollectionViewDelegateFlowLayout
{
    
    let numberOfCells = 5
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(BrandCell.self, forCellWithReuseIdentifier: "brand-cell")
        collectionView?.register(SearchSupplementaryHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "search-header")
        collectionView?.backgroundColor = UIColor(red: 245, green: 245, blue: 245)
        
        view.backgroundColor = .white
        
        setupNavigationItemButtons()
    }
    
    func setupNavigationItemButtons()
    {
        navigationItem.title = "Raffles"
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return numberOfCells
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brand-cell", for: indexPath) as! BrandCell
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: view.frame.width, height: view.frame.height * 0.6)
    }
    
}
