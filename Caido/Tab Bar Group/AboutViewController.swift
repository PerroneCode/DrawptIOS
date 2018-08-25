//
//  AboutViewController.swift
//  Caido
//
//  Created by Daniel on 8/18/18.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit

class AboutViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    lazy var collectionView : UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(OfferedBrandsCell.self, forCellWithReuseIdentifier: "offered-brands-cell")
        collectionView.register(AboutCaidoCell.self, forCellWithReuseIdentifier: "about-cell")
        collectionView.register(PracticeCell.self, forCellWithReuseIdentifier: "practice-cell")
        
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
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
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if (indexPath.row == 0)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offered-brands-cell", for: indexPath) as! OfferedBrandsCell
            
            return cell
        } else if (indexPath.row == 1)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "about-cell", for: indexPath) as! AboutCaidoCell
            
            return cell
        } else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "practice-cell", for: indexPath) as! PracticeCell
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: view.frame.width, height: indexPath.row == 1 ? view.frame.height * 1.15 : view.frame.height / 1.5)

    }
}

class OfferedBrandsCell : UICollectionViewCell
{
    let firstLogoImageView : UIImageView =
    {
        let imageView = UIImageView(image: UIImage(named:"adidas.png"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let secondLogoImageView : UIImageView =
    {
        let imageView = UIImageView(image: UIImage(named:"supreme.png"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let thirdLogoImageView : UIImageView =
    {
        let imageView = UIImageView(image: UIImage(named:"gucci.png"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let fourthLogoImageView : UIImageView =
    {
        let imageView = UIImageView(image: UIImage(named:"yeezy-logo.png"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let fifthLogoImageView : UIImageView =
    {
        let imageView = UIImageView(image: UIImage(named:"lv.png"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let sixthLogoImageView : UIImageView =
    {
        let imageView = UIImageView(image: UIImage(named:"adidas.png"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init (frame: CGRect)
    {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor(red: 58, green: 65, blue: 80)
        
        setupFirstImageView()
        setupSecondImageView()
        setupThirdImageView()
        setupFourthImageView()
        setupFifthImageView()
        setupSixthImageView()
    }
    
    func setupFirstImageView ()
    {
        addSubview(firstLogoImageView)
        
        firstLogoImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        firstLogoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        firstLogoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.18).isActive = true
        firstLogoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.18).isActive = true
    }
    
    func setupSecondImageView ()
    {
        addSubview(secondLogoImageView)
        
        secondLogoImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        secondLogoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        secondLogoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.18).isActive = true
        secondLogoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.18).isActive = true
    }
    
    func setupThirdImageView ()
    {
        addSubview(thirdLogoImageView)
        
        thirdLogoImageView.rightAnchor.constraint(equalTo: centerXAnchor, constant: -20).isActive = true
        thirdLogoImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        thirdLogoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.18).isActive = true
        thirdLogoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.18).isActive = true
    }
    
    func setupFourthImageView ()
    {
        addSubview(fourthLogoImageView)
        
        fourthLogoImageView.leftAnchor.constraint(equalTo: centerXAnchor, constant: 20).isActive = true
        fourthLogoImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        fourthLogoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.18).isActive = true
        fourthLogoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.18).isActive = true
    }
    
    func setupFifthImageView ()
    {
        addSubview(fifthLogoImageView)
        
        fifthLogoImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        fifthLogoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
        fifthLogoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.18).isActive = true
        fifthLogoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.18).isActive = true
    }
    
    func setupSixthImageView ()
    {
        addSubview(sixthLogoImageView)
        
        sixthLogoImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        sixthLogoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
        sixthLogoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.18).isActive = true
        sixthLogoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.18).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AboutCaidoCell : UICollectionViewCell
{
    let caidoGameLabel : UILabel =
    {
        let label = UILabel()
        label.text = "Caido Speed Runner"
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 20)
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.ultraLight)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let gameDescriptionTextView : UITextView =
    {
        let textView = UITextView(frame: CGRect.zero)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        let attributes = [NSAttributedStringKey.paragraphStyle : paragraphStyle]
        textView.attributedText = NSAttributedString(string: "Caido Speed Runner consists of dodging obstacles and answering 3 questions during the game. If a level is completed, you are granted one raffle ticket for a raffle of your choosing. Be sure to practice before game day arrives!", attributes: attributes)
        
        
        textView.font = UIFont(name: "Helvetica", size: 15)
        textView.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
        textView.textAlignment = .center
        textView.textColor = UIColor(red: 125, green: 125, blue: 125)
        textView.backgroundColor = UIColor.clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let raffleGameDayRulesLabel : UILabel =
    {
        let label = UILabel()
        label.text = "Raffle Game Day Rules:"
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 20)
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.ultraLight)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let raffleGameDayRulesTextView : UITextView =
    {
        let textView = UITextView(frame: CGRect.zero)
    
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        let attributes = [NSAttributedStringKey.paragraphStyle : paragraphStyle]
        textView.attributedText = NSAttributedString(string: "1) Raffle game days open every Wednesday at 11 AM ET and user must be checked in by 10:45 AM ET.\n\n2) You only have 1 life.\n\n3) Must be a Registered Caido Beast.", attributes: attributes)
        
        
        textView.font = UIFont(name: "Helvetica", size: 15)
        textView.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
        textView.textAlignment = .center
        textView.textColor = UIColor(red: 125, green: 125, blue: 125)
        textView.backgroundColor = UIColor.clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let signInButton : UIButton =
    {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Sign In", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor(red: 11, green: 154, blue: 211)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init (frame: CGRect)
    {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.white
        
        setupCaidoGameLabel()
        setupGameDescriptionLabel()
        setupRaffleGameDayRulesLabel()
        setupRaffleGameDayRulesTextView()
        setupSignInButton()
    }
    
    func setupCaidoGameLabel ()
    {
        addSubview(caidoGameLabel)
        
        caidoGameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        caidoGameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        caidoGameLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        caidoGameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05).isActive = true
    }
    
    func setupGameDescriptionLabel ()
    {
        addSubview(gameDescriptionTextView)
        
        gameDescriptionTextView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        gameDescriptionTextView.topAnchor.constraint(equalTo: caidoGameLabel.bottomAnchor, constant: 10).isActive = true
        gameDescriptionTextView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
        gameDescriptionTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35).isActive = true
    }
    
    func setupRaffleGameDayRulesLabel ()
    {
        addSubview(raffleGameDayRulesLabel)
        
        raffleGameDayRulesLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        raffleGameDayRulesLabel.topAnchor.constraint(equalTo: gameDescriptionTextView.bottomAnchor, constant: 10).isActive = true
        raffleGameDayRulesLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        raffleGameDayRulesLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05).isActive = true
    }
    
    func setupRaffleGameDayRulesTextView ()
    {
        addSubview(raffleGameDayRulesTextView)
        
        raffleGameDayRulesTextView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        raffleGameDayRulesTextView.topAnchor.constraint(equalTo: raffleGameDayRulesLabel.bottomAnchor, constant: 10).isActive = true
        raffleGameDayRulesTextView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
        raffleGameDayRulesTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35).isActive = true
    }
    
    func setupSignInButton ()
    {
        addSubview(signInButton)
        
        signInButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        signInButton.topAnchor.constraint(equalTo: raffleGameDayRulesTextView.bottomAnchor, constant: 10).isActive = true
        signInButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PracticeCell : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    lazy var collectionView : UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(PracticeCollectionViewCell.self, forCellWithReuseIdentifier: "practce-collection-view-cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(red: 225, green: 225, blue: 225)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init (frame: CGRect)
    {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor(red: 225, green: 225, blue: 225)
        setupCollectionView()
    }
    
    func setupCollectionView ()
    {
        addSubview(collectionView)
        
        collectionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
        collectionView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "practce-collection-view-cell", for: indexPath) as! PracticeCollectionViewCell
        
        switch (indexPath.row)
        {
        case 0:
            cell.backgroundColor = UIColor(red: 165, green: 225, blue: 75)
            cell.difficultyLabel.text = "EASY"
            cell.descriptionLabel.text = "Get started with the mechanics and learn how to maneuver your HYPEBEAST."
            break
        case 1:
            cell.backgroundColor = UIColor(red: 249, green: 188, blue: 79)
            cell.difficultyLabel.text = "HARD"
            cell.descriptionLabel.text = "Really work your HYPEBEAST."
            break
        default:
            print("Error")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width * 0.8, height: collectionView.frame.height * 0.90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PracticeCollectionViewCell : UICollectionViewCell
{
    let difficultyLabel : UILabel =
    {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont(name: "Helvetica", size: 25)
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel : UILabel =
    {
        let label = UILabel()
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 15)
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init (frame: CGRect)
    {
        super.init(frame: CGRect.zero)
        
        layer.cornerRadius = 10
        backgroundColor = UIColor.black
        setupShadow()
        setupDifficultyLabel()
        setupDescriptionLabel()
    }
    
    func setupShadow ()
    {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.125
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 10, height: 10)
    }
    
    func setupDifficultyLabel ()
    {
        addSubview(difficultyLabel)
        
        difficultyLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        difficultyLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        difficultyLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        difficultyLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
    }
    
    func setupDescriptionLabel ()
    {
        addSubview(descriptionLabel)
        
        descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: difficultyLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
