//
//  HomeViewController.swift
//  Caido
//
//  Created by Daniel on 8/4/18.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit

class HomeViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    let sections = 4
    
    lazy var collectionView : UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(FirstCell.self, forCellWithReuseIdentifier: "first")
        collectionView.register(SecondCellAndFourthCell.self, forCellWithReuseIdentifier: "second")
        collectionView.register(ThirdCell.self, forCellWithReuseIdentifier: "third")
        
        return collectionView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    func setupCollectionView ()
    {
        view.addSubview(collectionView)
        
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return sections
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if (indexPath.row == 0)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "first", for: indexPath) as! FirstCell
            return cell
        } else if (indexPath.row == 1 || indexPath.row == 3)
        {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "second", for: indexPath) as! SecondCellAndFourthCell
            cell.backgroundColor = UIColor(red: 245, green: 245, blue: 245)
            
            switch (indexPath.row)
            {
            case 1:
                cell.newsLabel.text = "CAIDO NEWS"
                break
            case 3:
                cell.newsLabel.text = "UPCOMING RAFFLES"
                break
            default:
                print("Error")
            }
            return cell
        } else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "third", for: indexPath)
            cell.backgroundColor = UIColor(red: 74, green: 74, blue: 74)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: view.frame.width, height: indexPath.row == 2 ? view.frame.height * 1.5 : view.frame.height / 1.5)
    }
    
}

class FirstCell : UICollectionViewCell
{
    let raffleDayGradient = CAGradientLayer()
    let gameDayGradient = CAGradientLayer()

    
    let backgroundImageView : UIImageView =
    {
        let imageView = UIImageView(image: UIImage(named:"planes.png"))
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let blurView : UIVisualEffectView =
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()
    
    let headerLabel : UILabel =
    {
        let label = UILabel()
        label.text = "Enter raffles & play \n for a chance \n to win!"
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 30)
        label.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.light)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let raffleDayLabel : UILabel =
    {
        let label = UILabel()
        label.text = "Every\nThursday"
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 20)
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.light)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var raffleDayGradientView : UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 2
        // Create Gradient
        let leftColor = UIColor(red: 201, green: 109, blue: 213)
        let rightColor = UIColor(red: 232, green: 81, blue: 89)
        raffleDayGradient.colors = [leftColor, rightColor]
        raffleDayGradient.startPoint = CGPoint(x: 0, y: 0)
        raffleDayGradient.endPoint = CGPoint(x: 1, y: 0)
        raffleDayGradient.locations = [0,1]
        raffleDayGradient.cornerRadius = view.layer.cornerRadius
        view.layer.addSublayer(raffleDayGradient)
        
        
        return view
    }()
    
    
    let gameDayLabel : UILabel =
    {
        let label = UILabel()
        label.text = "Every\nWednesday"
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 20)
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.light)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var gameDayGradientView : UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 2
        // Create Gradient
        let leftColor = UIColor(red: 201, green: 109, blue: 213)
        let rightColor = UIColor(red: 232, green: 81, blue: 89)
        gameDayGradient.colors = [leftColor, rightColor]
        gameDayGradient.startPoint = CGPoint(x: 0, y: 0)
        gameDayGradient.endPoint = CGPoint(x: 1, y: 0)
        gameDayGradient.locations = [0,1]
        gameDayGradient.cornerRadius = view.layer.cornerRadius
        view.layer.addSublayer(gameDayGradient)
        
        return view
    }()
    
    let rafflesLabel : UILabel =
    {
        let label = UILabel()
        label.text = "RAFFLES"
        label.textColor = UIColor(red: 148, green: 156, blue: 174)
        label.font = UIFont(name: "Helvetica", size: 10)
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.ultraLight)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let gameDayRafflesLabel : UILabel =
    {
        let label = UILabel()
        label.text = "RAFFLE GAME DAYS"
        label.textColor = UIColor(red: 148, green: 156, blue: 174)
        label.font = UIFont(name: "Helvetica", size: 10)
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.ultraLight)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init (frame: CGRect)
    {
        super.init(frame: CGRect.zero)
        
        setupBackgroundImageView()
        setupBlurView()
        setupHeaderLabel()
        setupRaffleDayLabel()
        setupGameDayLabel()
        setupRaffleDayGradientView()
        setupGameDayGradientView()
        setupRaffleLabel()
        setupRaffleGameDayLabel()
    }
    
    func setupBackgroundImageView()
    {
        addSubview(backgroundImageView)
        
        backgroundImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        backgroundImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        backgroundImageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    func setupBlurView ()
    {
        backgroundImageView.addSubview(blurView)
        
        
        blurView.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor).isActive = true
        blurView.widthAnchor.constraint(equalTo: backgroundImageView.widthAnchor).isActive = true
        blurView.heightAnchor.constraint(equalTo: backgroundImageView.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    func setupHeaderLabel ()
    {
        backgroundImageView.addSubview(headerLabel)
        
        headerLabel.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor).isActive = true
        
        headerLabel.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor, constant: -15).isActive = true
        
        headerLabel.widthAnchor.constraint(equalTo: backgroundImageView.widthAnchor).isActive = true
        
        headerLabel.heightAnchor.constraint(equalTo: backgroundImageView.heightAnchor).isActive = true
    }
    
    func setupRaffleDayLabel ()
    {
        blurView.contentView.addSubview(raffleDayLabel)
        
        raffleDayLabel.leftAnchor.constraint(equalTo: blurView.leftAnchor, constant: 20).isActive = true
        raffleDayLabel.centerYAnchor.constraint(equalTo: blurView.centerYAnchor).isActive = true
        raffleDayLabel.widthAnchor.constraint(equalTo: blurView.widthAnchor, multiplier: 0.35).isActive = true
        raffleDayLabel.heightAnchor.constraint(equalTo: blurView.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    func setupGameDayLabel ()
    {
        blurView.contentView.addSubview(gameDayLabel)
        
        gameDayLabel.rightAnchor.constraint(equalTo: blurView.rightAnchor, constant: -20).isActive = true
        gameDayLabel.centerYAnchor.constraint(equalTo: blurView.centerYAnchor).isActive = true
        gameDayLabel.widthAnchor.constraint(equalTo: blurView.widthAnchor, multiplier: 0.35).isActive = true
        gameDayLabel.heightAnchor.constraint(equalTo: blurView.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    func setupRaffleDayGradientView ()
    {
        blurView.contentView.addSubview(raffleDayGradientView)
        
        raffleDayGradientView.centerXAnchor.constraint(equalTo: raffleDayLabel.centerXAnchor).isActive = true
        raffleDayGradientView.bottomAnchor.constraint(equalTo: blurView.bottomAnchor, constant: -10).isActive = true
        raffleDayGradientView.widthAnchor.constraint(equalTo: raffleDayLabel.widthAnchor).isActive = true
        raffleDayGradientView.heightAnchor.constraint(equalToConstant: 2.5).isActive = true
    }
    
    func setupGameDayGradientView ()
    {
        blurView.contentView.addSubview(gameDayGradientView)
        
        gameDayGradientView.centerXAnchor.constraint(equalTo: gameDayLabel.centerXAnchor).isActive = true
        gameDayGradientView.bottomAnchor.constraint(equalTo: blurView.bottomAnchor, constant: -10).isActive = true
        gameDayGradientView.widthAnchor.constraint(equalTo: gameDayLabel.widthAnchor).isActive = true
        gameDayGradientView.heightAnchor.constraint(equalToConstant: 2.5).isActive = true
    }
    
    func setupRaffleLabel ()
    {
        blurView.contentView.addSubview(rafflesLabel)
        
        rafflesLabel.leftAnchor.constraint(equalTo: raffleDayLabel.leftAnchor).isActive = true
        rafflesLabel.bottomAnchor.constraint(equalTo: raffleDayLabel.topAnchor).isActive = true
        rafflesLabel.widthAnchor.constraint(equalTo: blurView.widthAnchor, multiplier: 0.5).isActive = true
        rafflesLabel.heightAnchor.constraint(equalTo: blurView.heightAnchor, multiplier: 0.10).isActive = true
    }
    
    func setupRaffleGameDayLabel ()
    {
        blurView.contentView.addSubview(gameDayRafflesLabel)
        
        gameDayRafflesLabel.leftAnchor.constraint(equalTo: gameDayLabel.leftAnchor).isActive = true
        gameDayRafflesLabel.bottomAnchor.constraint(equalTo: gameDayLabel.topAnchor).isActive = true
        gameDayRafflesLabel.widthAnchor.constraint(equalTo: blurView.widthAnchor, multiplier: 0.5).isActive = true
        gameDayRafflesLabel.heightAnchor.constraint(equalTo: blurView.heightAnchor, multiplier: 0.10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class SecondCellAndFourthCell : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    let numberOfCells = 4
    
    lazy var collectionView : UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = UIColor(red: 245, green: 245, blue: 245)
        
        collectionView.register(SecondAndFourthCellProductCell.self, forCellWithReuseIdentifier: "shoe-cell")
        
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let newsLabel : UILabel =
    {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 25)
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.ultraLight)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init (frame: CGRect)
    {
        super.init(frame: CGRect.zero)
        
        
        setupCollectionView()
        setupNewsLabel()
    }
    
    func setupCollectionView ()
    {
        addSubview(collectionView)
        
        collectionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        collectionView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75).isActive = true
    }
    
    func setupNewsLabel ()
    {
        addSubview(newsLabel)
        
        newsLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        newsLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        newsLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        newsLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shoe-cell", for: indexPath) as! SecondAndFourthCellProductCell
        
        cell.backgroundColor = UIColor.white
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width * 0.8, height: collectionView.frame.height * 0.85)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SecondAndFourthCellProductCell : UICollectionViewCell
{
    
    let productNameLabel : UILabel =
    {
        let label = UILabel()
        label.text = "Yeezy Beluga 1.0"
        label.font = label.font.withSize(25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel : UILabel =
    {
        let label = UILabel()
        label.text = "A complete guide to colors,\ntypography and layout for iOS"
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 15)
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let productImageView : UIImageView =
    {
        let imageView = UIImageView(image: UIImage(named: "yeezy.png"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        
        setupShadow()
        setupProductNameLabel()
        setupDescriptionLabel()
        setupProductImageView()
    }
    
    func setupShadow()
    {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.125
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 10, height: 10)
    }
    
    func setupProductNameLabel ()
    {
        addSubview(productNameLabel)
        
        productNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        productNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        productNameLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        productNameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
    }
    
    func setupDescriptionLabel ()
    {
        addSubview(descriptionLabel)
        
        descriptionLabel.leftAnchor.constraint(equalTo: productNameLabel.leftAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
    }
    
    func setupProductImageView ()
    {
        addSubview(productImageView)
        
        productImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        productImageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        productImageView.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor).isActive = true
        productImageView.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ThirdCell : UICollectionViewCell
{
    let ticketImageView : UIImageView =
    {
        let imageView = UIImageView(image: UIImage(named: "ticket.png"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let rafflesRulesLabel : UILabel =
    {
        let label = UILabel()
        label.text = "Raffle Rules:"
        label.font = UIFont(name: "Helvetica", size: 30)
        label.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.light)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rulesTextView : UITextView =
    {
        let textView = UITextView()
        textView.font = UIFont(name: "Helvetica", size: 20)
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor.white
        textView.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.light)
        textView.text =
        "1) Raffle winners are announced each Thursday at 12 PM on Thursday ET.\n\n 2) All raffles are open until Wednesday night at 11:59 PM ET.\n\n 3) If you don’t win a raffle, your changes of winning the upcoming raffle will be increased.\n\n 4) Raffles can be stacked up to 3x for a better chance of winning the raffle."
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let buyTicketButton : UIButton =
    {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Buy Raffle Ticket", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor(red: 11, green: 154, blue: 211)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init (frame: CGRect)
    {
        super.init(frame: frame)
        
        setupTicketImageView()
        setupRafflesRulesLabel()
        setupRulesTextView()
        setupBuyTicketButton()

    }
    

    
    func setupTicketImageView ()
    {
        addSubview(ticketImageView)
        
        ticketImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        ticketImageView.topAnchor.constraint(equalTo: topAnchor, constant: frame.height/10).isActive = true
        ticketImageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        ticketImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
    }
    
    func setupRafflesRulesLabel ()
    {
        addSubview(rafflesRulesLabel)
        
        rafflesRulesLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        rafflesRulesLabel.topAnchor.constraint(equalTo: ticketImageView.bottomAnchor, constant: 20).isActive = true
        rafflesRulesLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        rafflesRulesLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05).isActive = true
    }
    
    func setupRulesTextView ()
    {
        addSubview(rulesTextView)
        
        rulesTextView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        rulesTextView.topAnchor.constraint(equalTo: rafflesRulesLabel.bottomAnchor, constant: 20).isActive = true
        rulesTextView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        rulesTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
    }
    
    func setupBuyTicketButton ()
    {
        addSubview(buyTicketButton)
        
        buyTicketButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        buyTicketButton.topAnchor.constraint(equalTo: rulesTextView.bottomAnchor, constant: -20).isActive = true
        buyTicketButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        buyTicketButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
