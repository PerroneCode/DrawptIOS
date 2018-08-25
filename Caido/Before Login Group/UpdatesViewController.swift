//
//  UpdatesViewController.swift
//  Caido
//
//  Created by Daniel on 8/4/18.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit

class UpdatesViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    let numberOfCells = 5
    
    lazy var collectionView : UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.layer.cornerRadius = 10
        collectionView.bounces = false
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 88, green: 86, blue: 214)
        
        setupCollectionView()
    }
    
    func setupCollectionView ()
    {
        view.addSubview(collectionView)
        
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.75).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85).isActive = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        
        if (indexPath.row == 0)
        {
            cell.sideView.clipsToBounds = true
            cell.sideView.layer.cornerRadius = 10
            cell.sideView.layer.maskedCorners = [.layerMinXMinYCorner]
    
        } else if (indexPath.row == numberOfCells-1)
        {
            cell.sideView.clipsToBounds = true
            cell.sideView.layer.cornerRadius = 10
            cell.sideView.layer.maskedCorners = [.layerMinXMaxYCorner]
            
            cell.seperatorView.alpha = 0
        } else
        {
            cell.sideView.layer.cornerRadius = 0
        }
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width, height:collectionView.frame.height/3)
    }
    
    
}

class CollectionViewCell : UICollectionViewCell
{
    
    let sideView : UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor(red: 240, green: 243, blue: 245)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dateLabel : UILabel =
    {
        let label  = UILabel()
        label.text = "30 SEPT 2017"
        label.textColor = UIColor(red: 155, green: 155, blue: 155)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subjectLabel : UILabel =
    {
        let label = UILabel()
        label.text = "New iOS App"
        label.font = label.font.withSize(22.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let updateLabel : UILabel =
    {
        let label = UILabel()
        label.text = "4 new sections, plus chapter \n entirely updated for \n iOS 11."
        label.numberOfLines = 0
        label.textColor = UIColor(red: 74, green: 74, blue: 74)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let seperatorView : UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor(red: 240, green: 243, blue: 245)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let iconImageView : UIImageView =
    {
        let imageView = UIImageView(image: UIImage(named:"update.png"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init (frame: CGRect)
    {
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor.white
        
        setupSideView()
        setupDateLabel()
        setupSubjectLabel()
        setupUpdateLabel()
        setupSeperatorView()
        setupIconImageView()
    }
    
    func setupSideView ()
    {
        addSubview(sideView)
        
        sideView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        sideView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        sideView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        sideView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.12).isActive = true
    }
    
    func setupDateLabel ()
    {
        addSubview(dateLabel)
        
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: UIScreen.main.bounds.width/5).isActive = true
        dateLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setupSubjectLabel ()
    {
        addSubview(subjectLabel)
        
        subjectLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
        subjectLabel.leftAnchor.constraint(equalTo: dateLabel.leftAnchor).isActive = true
        subjectLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        subjectLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setupUpdateLabel ()
    {
        addSubview(updateLabel)
        
        updateLabel.topAnchor.constraint(equalTo: subjectLabel.bottomAnchor).isActive = true
        updateLabel.leftAnchor.constraint(equalTo: subjectLabel.leftAnchor).isActive = true
        updateLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        updateLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
    }
    
    func setupSeperatorView ()
    {
        addSubview(seperatorView)
        
        seperatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperatorView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        seperatorView.leftAnchor.constraint(equalTo: updateLabel.leftAnchor).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
    }
    
    func setupIconImageView ()
    {
        addSubview(iconImageView)
        
        
        iconImageView.topAnchor.constraint(equalTo: dateLabel.topAnchor).isActive = true
        iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 55).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
