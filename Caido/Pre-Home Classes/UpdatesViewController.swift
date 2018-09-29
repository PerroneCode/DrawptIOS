//
//  UpdatesViewController.swift
//  Caido
//
//  Created by Daniel on 8/4/18.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit
import Firebase

class UpdatesViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    var updates = [Update]()
    
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

        return collectionView
    }()
    
    let backgroundView : UIView =
    {
        let view = UIView()
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.30
        view.layer.shadowOffset = CGSize(width: -5, height: 10)
        
        return view
    }()
    
    
    let closeButton : UIButton =
    {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 88, green: 86, blue: 214)
        
        setupBackgroundView()
        setupCollectionView()
        setupCloseButton()
        fetchUpdates()
    }
    
    func setupBackgroundView ()
    {
        view.addSubview(backgroundView)
        
        backgroundView.centerInParent(centerX: view.centerXAnchor, centerY: view.centerYAnchor)
        backgroundView.widthAndHeightByPercentOfParent(widthPercent: 0.85, heightPercent: 0.85, parentWidthAnchor: view.widthAnchor, parentHeightAnchor: view.heightAnchor)
    }
    
    func setupCollectionView ()
    {
        backgroundView.addSubview(collectionView)
        
        collectionView.centerInParent(centerX: view.centerXAnchor, centerY: view.centerYAnchor)
        collectionView.widthAndHeightByPercentOfParent(widthPercent: 0.85, heightPercent: 0.85, parentWidthAnchor: view.widthAnchor, parentHeightAnchor: view.heightAnchor)
        
    }
    
    func setupCloseButton ()
    {
        collectionView.addSubview(closeButton)
    
        closeButton.anchor(top: backgroundView.topAnchor, bottom: nil, left: nil, right: backgroundView.rightAnchor, paddingTop: 10, paddingBottom: 0, paddingLeft: 0, paddingRight: 10, width: 30, height: 30)
        closeButton.addTarget(self, action: #selector(dismissThisViewController), for: .touchUpInside)
    }
    
    func fetchUpdates ()
    {
        Database.database().reference().child("updates").child("version-1").observe(.value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String : Any]
            {
                for (key, _) in dictionary
                {
                    if let anotherDictionary = dictionary[key] as? [String : Any]
                    {
                        self.updates.append(Update(dictionary: anotherDictionary))
                    }
                }
            }
            self.insertUpdateCells()
        })
        { (error) in
            
            print("Error:\(error)")
            
        }
    }
    
    func insertUpdateCells ()
    {
        var indexPaths = [IndexPath]()
        
        var i = 0
        
        while (i < updates.count)
        {
            indexPaths.append(IndexPath(item: i, section: 0))
            i += 1
        }
        
        collectionView.insertItems(at: indexPaths)
    }
    
    @objc func dismissThisViewController ()
    {
        navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return updates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        if updates.count != 0
        {
            cell.updateTitleLabel.text = updates[indexPath.row].title
            cell.updateInformationLabel.text = updates[indexPath.row].text
            cell.dateLabel.text = updates[indexPath.row].date
            
            
            let photo_url = updates[indexPath.row].photoUrl!
            let url = URL(string: photo_url)
            
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
                if let error = error
                {
                    print("Error:\(error)")
                }
                
                DispatchQueue.main.async
                {
                        cell.iconImageView.image = UIImage(data: data!)
                }
                
            }.resume()
        }
        
        if (indexPath.row == 0)
        {
            cell.sideView.clipsToBounds = true
            cell.sideView.layer.cornerRadius = 10
            cell.sideView.layer.maskedCorners = [.layerMinXMinYCorner]
    
        } else if (indexPath.row == updates.count-1)
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
}

class CollectionViewCell : UICollectionViewCell
{
    
    let sideView : UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor(red: 240, green: 243, blue: 245)
        return view
    }()
    
    let dateLabel : UILabel =
    {
        let label  = UILabel()
        label.text = "hello world"
        label.textColor = UIColor(red: 155, green: 155, blue: 155)
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let updateTitleLabel : UILabel =
    {
        let label = UILabel()
        label.font = label.font.withSize(22.5)
        return label
    }()
    
    let updateInformationLabel : UILabel =
    {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(red: 74, green: 74, blue: 74)
        return label
    }()
    
    let seperatorView : UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor(red: 240, green: 243, blue: 245)
        return view
        
    }()
    
    let iconImageView : UIImageView =
    {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init (frame: CGRect)
    {
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor.white
        
        setupSideView()
        setupDateLabel()
        setupUpdateTitleLabel()
        setupUpdateInformationLabel()
        setupSeperatorView()
        setupIconImageView()
    }
    
    func setupSideView ()
    {
        addSubview(sideView)
        
        sideView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        sideView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1).isActive = true
    }
    
    func setupDateLabel ()
    {
        addSubview(dateLabel)
        
        dateLabel.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: nil, paddingTop: 10, paddingBottom: 0, paddingLeft: UIScreen.main.bounds.width/5, paddingRight: 0, width: 0, height: 30)
        
        dateLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    func setupUpdateTitleLabel ()
    {
        addSubview(updateTitleLabel)
        
        updateTitleLabel.anchor(top: dateLabel.bottomAnchor, bottom: nil, left: dateLabel.leftAnchor, right: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 20)
        
        updateTitleLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    func setupUpdateInformationLabel ()
    {
        addSubview(updateInformationLabel)
        
        updateInformationLabel.anchor(top: updateTitleLabel.bottomAnchor, bottom: nil, left: updateTitleLabel.leftAnchor, right: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        updateInformationLabel.widthAndHeightByPercentOfParent(widthPercent: 1, heightPercent: 0.5, parentWidthAnchor: widthAnchor, parentHeightAnchor: heightAnchor)
    }
    
    func setupSeperatorView ()
    {
        addSubview(seperatorView)
        
        seperatorView.anchor(top: nil, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 1.5)
    }
    
    func setupIconImageView ()
    {
        addSubview(iconImageView)
        
        iconImageView.anchor(top: dateLabel.topAnchor, bottom: nil, left: leftAnchor, right: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 10, paddingRight: 0, width: 55, height: 55)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
