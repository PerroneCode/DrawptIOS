//
//  HomeViewController.swift
//  Caido
//
//  Created by Daniel on 8/4/18.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    var user : User?
    var newsStorys = [NewsStory]()
    
    lazy var collectionView : UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(FirstCell.self, forCellWithReuseIdentifier: "first")
        collectionView.register(SecondCell.self, forCellWithReuseIdentifier: "second")
        collectionView.register(ThirdCell.self, forCellWithReuseIdentifier: "third")
        collectionView.register(FourthCell.self, forCellWithReuseIdentifier: "fourth")
        
        return collectionView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
                
        checkIfUserIsLoggedIn()
        setupNavigationItemButtons()
        setupCollectionView()
        downloadNews()
    }
    
    func downloadNews ()
    {
        Database.database().reference().child("news").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let initialDictionary = snapshot.value as? [String : Any]
            {
                for (key, _) in initialDictionary
                {
                    if let finalDictionary = initialDictionary[key] as? [String : Any]
                    {
                        self.newsStorys.append(NewsStory(dictionary: finalDictionary))
                    }
                    
                }
            }
            
          self.refreshCollectionViewData()
            
        }) { (error) in
            print("Error:\(error)")
        }
    }
    
    func refreshCollectionViewData ()
    {
        self.collectionView.reloadData()
    }
    
    func checkIfUserIsLoggedIn ()
    {
        if Auth.auth().currentUser == nil
        {
            dismiss(animated: true, completion: nil)
        } else
        {
            // Setup user
            if let user = Auth.auth().currentUser
            {
                if let email = Auth.auth().currentUser?.email
                {
                    self.user = User(email: email, uid: user.uid)
                }
            }
        }
    }
    
    func setupNavigationItemButtons()
    {
        navigationItem.title = "Home"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(signUserOut))
    }
    
    @objc func signUserOut ()
    {
        do {
            try Auth.auth().signOut()
            print("Successfully signed user out")
            removeSessionTracker(uid: user?.uid)
            dismiss(animated: true, completion: nil)
        } catch let error as NSError
        {
            print("Error:\(error)")
        }

    }

    func setupCollectionView ()
    {
        view.addSubview(collectionView)
        
        collectionView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if (indexPath.row == 0)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "first", for: indexPath) as! FirstCell
            
            return cell
        } else if (indexPath.row == 1)
        {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "second", for: indexPath) as! SecondCell
            
            cell.backgroundColor = UIColor(red: 245, green: 245, blue: 245)
            
            
            cell.newsLabel.text = "CAIDO NEWS"
            
            if self.newsStorys.count != 0
            {
                cell.newsStorys = self.newsStorys
                cell.numberOfCells = self.newsStorys.count
                cell.collectionView.reloadData()
            }
            
            return cell
        } else if (indexPath.row == 2)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "third", for: indexPath) as! ThirdCell
            
            cell.backgroundColor = UIColor(red: 74, green: 74, blue: 74)
            
            return cell
        } else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fourth", for: indexPath) as! FourthCell
            
            cell.backgroundColor = UIColor(red: 245, green: 245, blue: 245)
            
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: view.frame.width, height: indexPath.row == 2 ? view.frame.height * 1.5 : view.frame.height / 1.65)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
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
        return imageView
    }()
    
    let blurView : UIVisualEffectView =
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        return blurView
    }()
    
    let headerLabel : UILabel =
    {
        let label = UILabel()
        label.text = "Enter Raffles & Play \n For a Chance \n To Win!"
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 35)
        label.font = UIFont.systemFont(ofSize: 35, weight: UIFont.Weight.regular)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    // Raffles every thursday text
    let raffleDayLabel : UILabel =
    {
        let label = UILabel()
        
        let attributedText1 = NSMutableAttributedString(string: "RAFFLES\n", attributes: [NSAttributedStringKey.foregroundColor : UIColor(red: 148, green: 156, blue: 174), NSAttributedStringKey.font : UIFont(name: "Helvetica", size: 15)!])
        
        let attributedText2 = NSMutableAttributedString(string: "Every\nThursday", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white, kCTFontAttributeName as NSAttributedStringKey : UIFont(name: "Helvetica", size: 26)!])
        
        let spacing = NSMutableParagraphStyle()
        spacing.lineSpacing = 5
        
        attributedText2.addAttribute(NSAttributedStringKey.paragraphStyle, value: spacing, range: NSMakeRange(0, attributedText2.length))
        
        attributedText1.append(attributedText2)
        
        label.attributedText = attributedText1
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var raffleDayGradientView : UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor.black
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
        
        let attributedText1 = NSMutableAttributedString(string: "RAFFLE GAME DAYS\n", attributes: [NSAttributedStringKey.foregroundColor : UIColor(red: 148, green: 156, blue: 174), NSAttributedStringKey.font : UIFont(name: "Helvetica", size: 15)!])
        
        let attributedText2 = NSMutableAttributedString(string: "Every\nWednesday", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white, kCTFontAttributeName as NSAttributedStringKey : UIFont(name: "Helvetica", size: 26)!])
        
        let spacing = NSMutableParagraphStyle()
        spacing.lineSpacing = 5
        
        attributedText2.addAttribute(NSAttributedStringKey.paragraphStyle, value: spacing, range: NSMakeRange(0, attributedText2.length))
        
        attributedText1.append(attributedText2)
        
        label.attributedText = attributedText1
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var gameDayGradientView : UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor.black
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
    }
    
    func setupBackgroundImageView()
    {
        addSubview(backgroundImageView)
        
        backgroundImageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func setupBlurView ()
    {
        backgroundImageView.addSubview(blurView)
        
        blurView.anchor(top: nil, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        blurView.heightAnchor.constraint(equalTo: backgroundImageView.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    func setupHeaderLabel ()
    {
        backgroundImageView.addSubview(headerLabel)
        
        headerLabel.anchor(top: nil, bottom: nil, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 15, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        headerLabel.heightAnchor.constraint(equalTo: backgroundImageView.heightAnchor).isActive = true
    }
    
    func setupRaffleDayLabel ()
    {
        blurView.contentView.addSubview(raffleDayLabel)
        
        raffleDayLabel.anchor(top: blurView.topAnchor, bottom: blurView.bottomAnchor, left: blurView.leftAnchor, right: blurView.centerXAnchor, paddingTop: -15, paddingBottom: 0, paddingLeft: 20, paddingRight: 0, width: 0, height: 0)
    }
    
    func setupGameDayLabel ()
    {
        blurView.contentView.addSubview(gameDayLabel)
        
        gameDayLabel.anchor(top: blurView.topAnchor, bottom: blurView.bottomAnchor, left: blurView.centerXAnchor, right: blurView.rightAnchor, paddingTop: -15, paddingBottom: 0, paddingLeft: 0, paddingRight: 20, width: 0, height: 0)
    }
    
    func setupRaffleDayGradientView ()
    {
        blurView.contentView.addSubview(raffleDayGradientView)
        
        raffleDayGradientView.anchor(top: nil, bottom: blurView.bottomAnchor, left: raffleDayLabel.leftAnchor, right: raffleDayLabel.rightAnchor, paddingTop: 0, paddingBottom: 20, paddingLeft: 0, paddingRight: 20, width: 0, height: 2.5)
    }
    
    func setupGameDayGradientView ()
    {
        blurView.contentView.addSubview(gameDayGradientView)
        
        gameDayGradientView.anchor(top: nil, bottom: blurView.bottomAnchor, left: gameDayLabel.leftAnchor, right: gameDayLabel.rightAnchor, paddingTop: 0, paddingBottom: 20, paddingLeft: 0, paddingRight: 20, width: 0, height: 2.5)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SecondCell : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    var numberOfCells = 0
    var newsStorys = [NewsStory]()
    
    lazy var collectionView : UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 30
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = UIColor(red: 245, green: 245, blue: 245)
        
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: "news-cell")
        
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    let newsLabel : UILabel =
    {
        let label = UILabel()
        label.text = "CAIDO NEWS"
        label.font = UIFont(name: "Helvetica", size: 28)
        label.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.light)
        return label
    }()
    
    override init (frame: CGRect)
    {
        super.init(frame: CGRect.zero)
        
        numberOfCells = newsStorys.count
        setupCollectionView()
        setupNewsLabel()
    }
    
    func setupCollectionView ()
    {
        addSubview(collectionView)
        
        collectionView.anchor(top: nil, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        collectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75).isActive = true
    }
    
    func setupNewsLabel ()
    {
        addSubview(newsLabel)
        
        newsLabel.anchor(top: nil, bottom: collectionView.topAnchor, left: leftAnchor, right: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 15, paddingRight: 0, width: 0, height: 0)
        newsLabel.widthAndHeightByPercentOfParent(widthPercent: 1.0, heightPercent: 0.15, parentWidthAnchor: widthAnchor, parentHeightAnchor: heightAnchor)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "news-cell", for: indexPath) as! NewsCell
        
        cell.backgroundColor = UIColor.white
        
        if newsStorys.count != 0
        {
            if let title = newsStorys[indexPath.row].title
            {
                cell.newsTitleLabel.text = title
            }
            
            
            if let preview_text = newsStorys[indexPath.row].preview_text
            {
                cell.newsDescriptionLabel.text = preview_text
            }
            
            if let photoUrl = newsStorys[indexPath.row].photo_url
            {
                if let url = URL(string:photoUrl)
                {
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                        
                        if let error = error
                        {
                            print("Error:\(error)")
                        }
                        
                        DispatchQueue.main.async
                        {
                            cell.productImageView.image = UIImage(data: data!)
                        }
                        
                    }.resume()
                }
            }
        }
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

class NewsCell : UICollectionViewCell
{
    
    let newsTitleLabel : UILabel =
    {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let newsDescriptionLabel : UILabel =
    {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 17)
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.light)
        label.textColor = UIColor(white: 1, alpha: 1)
        return label
    }()
    
    let productImageView : UIImageView =
    {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        
        setupShadow()
        setupProductImageView()
        setupNewsTitleLabel()
        setupNewsDescriptionLabel()
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
        
        productImageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func setupNewsTitleLabel ()
    {
        productImageView.addSubview(newsTitleLabel)
        
        newsTitleLabel.anchor(top: productImageView.topAnchor, bottom: centerYAnchor, left: leftAnchor, right: centerXAnchor, paddingTop: -10, paddingBottom: 0, paddingLeft: 15, paddingRight: 0, width: 0, height: 0)
    }
    
    func setupNewsDescriptionLabel ()
    {
        productImageView.addSubview(newsDescriptionLabel)
        
        newsDescriptionLabel.anchor(top: productImageView.centerYAnchor, bottom: productImageView.bottomAnchor, left: productImageView.leftAnchor, right: productImageView.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 15, paddingRight: 15, width: 0, height: 0)
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

class FourthCell : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    var numberOfCells = 0
    var newsStorys = [NewsStory]()
    
    lazy var collectionView : UICollectionView =
        {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 15
            let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
            
            collectionView.delegate = self
            collectionView.dataSource = self
            
            collectionView.backgroundColor = UIColor(red: 245, green: 245, blue: 245)
            
            collectionView.register(NewsCell.self, forCellWithReuseIdentifier: "news-cell")
            
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
        
        numberOfCells = newsStorys.count
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "news-cell", for: indexPath) as! NewsCell
        
        cell.backgroundColor = UIColor.white
        
        if newsStorys.count != 0
        {
            if let title = newsStorys[indexPath.row].title
            {
                cell.newsTitleLabel.text = title
            }
            
            
            if let preview_text = newsStorys[indexPath.row].preview_text
            {
                cell.newsDescriptionLabel.text = preview_text
            }
            
            if let photoUrl = newsStorys[indexPath.row].photo_url
            {
                if let url = URL(string:photoUrl)
                {
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                        
                        if let error = error
                        {
                            print("Error:\(error)")
                        }
                        
                        DispatchQueue.main.async
                            {
                                cell.productImageView.image = UIImage(data: data!)
                        }
                        
                        }.resume()
                }
            }
        }
        
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
