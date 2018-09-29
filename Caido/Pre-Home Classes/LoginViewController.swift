//
//  ViewController.swift
//  Caido
//
//  Created by Daniel on 8/2/18.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var user : User?
    
    let gradient = CAGradientLayer()
    let emailHighlighterGradient = CAGradientLayer()
    let passwordHighlighterGradient = CAGradientLayer()
    
    let backgroundView : UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor(red: 221, green: 221, blue: 246)
        view.layer.cornerRadius = 10
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.30
        view.layer.shadowOffset = CGSize(width: -5, height: 10)
        
        return view
    }()
    
    let textFieldsBackgroundView : UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let emailTextField : UITextField =
    {
        let textField = UITextField()
        textField.placeholder = "Email"
        return textField
    }()
    
    let emailIconImageView : UIImageView =
    {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "email"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let passwordTextField : UITextField =
    {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let passwordIconImageView : UIImageView =
    {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "key"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let logoImageView : UIImageView =
    {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let registerOrLoginSegmentedControl : UISegmentedControl =
    {
        
        let segmentedControl = UISegmentedControl(items: ["Login", "Register"])
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.addTarget(self, action: #selector(loginActionChanged), for: .valueChanged)
        segmentedControl.tintColor = UIColor(red: 88, green: 86, blue: 214)
        return segmentedControl
    }()
    
    @objc fileprivate func loginActionChanged ()
    {
        switch (registerOrLoginSegmentedControl.selectedSegmentIndex)
        {
        case 0: registerOrLoginButton.setTitle("Login", for: .normal)
            break
        case 1: registerOrLoginButton.setTitle("Register", for: .normal)
            break
        default:
            print("Error")
        }
    }
    
    lazy var registerOrLoginButton : UIButton =
    {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Register", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        button.layer.cornerRadius = 10
        
        let rightColor = UIColor(red: 70, green: 149, blue: 247)
        let leftColor = UIColor(red: 39, green: 90, blue: 245)
        self.gradient.colors = [rightColor.cgColor, leftColor.cgColor]
        gradient.frame = button.frame
        gradient.locations = [0,1]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        gradient.cornerRadius = button.layer.cornerRadius
        button.layer.addSublayer(gradient)
        
        // Create shadow
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: -3, height: 5)
        
        button.addTarget(self, action: #selector(registerOrLogin), for: .touchUpInside)
        
        return button
    }()
    
    @objc fileprivate func registerOrLogin ()
    {
        switch (registerOrLoginSegmentedControl.selectedSegmentIndex)
        {
        case 0: logUserIn()
            break
        case 1: registerUser()
            break
        default:
            print("Error")
        }
    }
    
    fileprivate func logUserIn ()
    {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if let error = error
            {
                self.showRegistrationOrLoginError(error: error.localizedDescription)
                return
            }
            
            if let user = result?.user
            {
                // Clear the text fields
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                
                print("Successfully signed user in")
                self.user = User(email: email, uid: user.uid)
                self.setupTabBarViewControllers()
                setupSessionTracker(email: email, uid: user.uid)
            }
        }
    }

    
    fileprivate func registerUser ()
    {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        // Create user in Firebase Authentication
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if let error = error
            {
                self.showRegistrationOrLoginError(error: error.localizedDescription)
                return
            }
            
            if let user = result?.user
            {
                // Clear the text fields
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                
                print("Successfully created user in authentication")
                self.user = User(email: email, uid: user.uid)
                self.registerUserInDatabase(email: email, uid: user.uid)
                setupSessionTracker(email: email, uid: user.uid)
                self.setupTabBarViewControllers()
            }
            
        }
    }
    
    fileprivate func registerUserInDatabase (email: String, uid: String)
    {
        let userInformation = ["email" : email]
        
        Database.database().reference().child("users").child(uid).setValue(userInformation) { (error, reference) in
            
            if let error = error
            {
                print("Error:\(error)")
                return
            }
            
            print("Successfully created user in database")
            
        }
    }
    
    func showRegistrationOrLoginError(error: String)
    {
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(cancelButton)
        
        present(alertController, animated: true, completion: nil)
    }
    
    let forgotPasswordButton : UIButton =
    {
        let button = UIButton(type: .system)
        
        button.titleLabel?.textAlignment = .center
        let attributedTitle = NSAttributedString(string: "Forgot Password?", attributes: [NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue, NSAttributedStringKey.foregroundColor : UIColor(red: 124, green: 124, blue: 137)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }()
    
    let updatesButton : UIButton =
    {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSAttributedString(string: "Updates", attributes: [ NSAttributedStringKey.foregroundColor : UIColor(red: 124, green: 124, blue: 137)]), for: .normal)
        return button
    }()
    
    lazy var emailTextFieldHighlighterView : UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.alpha = 0
        // Create gradient
        let firstColor = UIColor(red: 92, green: 1, blue: 255)
        let secondColor = UIColor(red: 180, green: 248, blue: 209)
        emailHighlighterGradient.colors = [firstColor.cgColor, secondColor.cgColor]
        emailHighlighterGradient.locations = [0,1]
        emailHighlighterGradient.startPoint = CGPoint(x: 0, y: 0)
        emailHighlighterGradient.endPoint = CGPoint(x: 1, y: 0)
        view.layer.addSublayer(emailHighlighterGradient)
        return view
    }()
    
    lazy var passwordTextFieldHighlighterView : UIView =
    {
        let view = UIView()
        view.alpha = 0
        // Create gradient
        let firstColor = UIColor(red: 92, green: 1, blue: 255)
        let secondColor = UIColor(red: 180, green: 248, blue: 209)
        passwordHighlighterGradient.colors = [firstColor.cgColor, secondColor.cgColor]
        passwordHighlighterGradient.locations = [0,1]
        passwordHighlighterGradient.startPoint = CGPoint(x: 0, y: 0)
        passwordHighlighterGradient.endPoint = CGPoint(x: 1, y: 0)
        view.layer.addSublayer(passwordHighlighterGradient)
        return view
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change background color using custom extension
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(red: 88, green: 86, blue: 214)
        
        setupBackgroundView()
        setupTextFieldsBackgroundView()
        setupEmailTextField()
        setupEmailIconImageView()
        setupPasswordTextField()
        setupPasswordIconImageView()
        setupSeperatorView()
        setupLogoImageViewAndRegisterOrLoginSegmentedControl()
        setupRegisterOrLoginButton()
        setupForgotPasswordAndUpdateButton()
        setupEmailTextFieldHighlighterView()
        setupPasswordTextFieldHighlighterView()
    }
    
    func checkIfUserIsLoggedIn () -> Bool
    {
        if Auth.auth().currentUser != nil
        {
            return true
        }
        return false
    }
    
    func setupTabBarViewControllers ()
    {
        let tabBarViewController = UITabBarController()
        
        
        let homeController = HomeViewController()
        let homeViewController = UINavigationController(rootViewController: homeController)
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: nil, selectedImage: nil)
                
        
        
        let rafflesController = RafflesViewController()
        let rafflesViewController = UINavigationController(rootViewController: rafflesController)
        rafflesViewController.tabBarItem = UITabBarItem(title: "Raffles", image: nil, selectedImage: nil)
        
        
        let storeController = StoreViewController()
        let storeViewController = UINavigationController(rootViewController: storeController)
        storeViewController.tabBarItem = UITabBarItem(title: "Store", image: nil, selectedImage: nil)
        
        let aboutController = AboutViewController()
        let aboutViewController = UINavigationController(rootViewController: aboutController)
        aboutViewController.tabBarItem = UITabBarItem(title: "About", image: nil, selectedImage: nil)
        
        
        
        tabBarViewController.viewControllers = [homeViewController, rafflesViewController, storeViewController, aboutViewController]
        
        
        present(tabBarViewController, animated: true, completion: nil)
    }

    func setupBackgroundView ()
    {
        view.addSubview(backgroundView)
        
        backgroundView.centerInParent(centerX: view.centerXAnchor, centerY: view.centerYAnchor)
        backgroundView.widthAndHeightByPercentOfParent(widthPercent: 0.85, heightPercent: 0.65, parentWidthAnchor: view.widthAnchor, parentHeightAnchor: view.heightAnchor)
    }
    
    func setupTextFieldsBackgroundView ()
    {
        backgroundView.addSubview(textFieldsBackgroundView)
        
        textFieldsBackgroundView.centerInParent(centerX: backgroundView.centerXAnchor, centerY: backgroundView.centerYAnchor)
        textFieldsBackgroundView.widthAndHeightByPercentOfParent(widthPercent: 1, heightPercent: 0.3, parentWidthAnchor: backgroundView.widthAnchor, parentHeightAnchor: backgroundView.widthAnchor)
    }
    
    func setupEmailTextField ()
    {
        textFieldsBackgroundView.addSubview(emailTextField)
        
        emailTextField.anchor(top: textFieldsBackgroundView.topAnchor, bottom: nil, left: nil, right: textFieldsBackgroundView.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        emailTextField.widthAndHeightByPercentOfParent(widthPercent: 0.8, heightPercent: 0.5, parentWidthAnchor: textFieldsBackgroundView.widthAnchor, parentHeightAnchor: textFieldsBackgroundView.heightAnchor)
        
        emailTextField.delegate = self
        
        // Create target
        emailTextField.addTarget(self, action: #selector(showEmailHighlighterView), for: .editingDidBegin)
        emailTextField.addTarget(self, action: #selector(hideEmailHighligherView), for: .editingDidEnd)
    }
    
    @objc func showEmailHighlighterView ()
    {
        UIView.animate(withDuration: 0.35) {
            self.emailTextFieldHighlighterView.alpha = 1
        }
    }
    
    @objc func hideEmailHighligherView ()
    {
        UIView.animate(withDuration: 0.35) {
            self.emailTextFieldHighlighterView.alpha = 0
        }
    }
    
    func setupEmailIconImageView ()
    {
        textFieldsBackgroundView.addSubview(emailIconImageView)
        
        emailIconImageView.anchor(top: nil, bottom: nil, left: textFieldsBackgroundView.leftAnchor, right: emailTextField.leftAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        emailIconImageView.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor).isActive = true
        emailIconImageView.heightAnchor.constraint(equalTo: emailTextField.heightAnchor, multiplier: 0.30).isActive = true
    }
    
    func setupPasswordIconImageView ()
    {
        textFieldsBackgroundView.addSubview(passwordIconImageView)
        
        passwordIconImageView.anchor(top: nil, bottom: nil, left: textFieldsBackgroundView.leftAnchor, right: passwordTextField.leftAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        passwordIconImageView.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor).isActive = true
        passwordIconImageView.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor, multiplier: 0.30).isActive = true
    }
    
    func setupPasswordTextField ()
    {
        textFieldsBackgroundView.addSubview(passwordTextField)
        
        passwordTextField.anchor(top: nil, bottom: textFieldsBackgroundView.bottomAnchor, left: nil, right: textFieldsBackgroundView.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0 )
        passwordTextField.widthAndHeightByPercentOfParent(widthPercent: 0.8, heightPercent: 0.5, parentWidthAnchor: textFieldsBackgroundView.widthAnchor, parentHeightAnchor: textFieldsBackgroundView.heightAnchor)
        
        passwordTextField.delegate = self
        
        // Create target
        passwordTextField.addTarget(self, action: #selector(showPasswordHighlighterView), for: .editingDidBegin)
        passwordTextField.addTarget(self, action: #selector(hidePasswordHighligherView), for: .editingDidEnd)
    }
    
    @objc func showPasswordHighlighterView ()
    {
        UIView.animate(withDuration: 0.35) {
            self.passwordTextFieldHighlighterView.alpha = 1
        }
    }
    
    @objc func hidePasswordHighligherView ()
    {
        UIView.animate(withDuration: 0.35) {
            self.passwordTextFieldHighlighterView.alpha = 0
        }
    }
    
    func setupSeperatorView ()
    {
        let middleSeperatorView = UIView()
        middleSeperatorView.backgroundColor = UIColor(red: 239, green: 239, blue: 239)
    
        textFieldsBackgroundView.addSubview(middleSeperatorView)
        
        middleSeperatorView.anchor(top: nil, bottom: nil, left: nil, right: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 1.5)
        middleSeperatorView.centerInParent(centerX: textFieldsBackgroundView.centerXAnchor, centerY: textFieldsBackgroundView.centerYAnchor)
        middleSeperatorView.widthAnchor.constraint(equalTo: textFieldsBackgroundView.widthAnchor).isActive = true
    }
    
    func setupLogoImageViewAndRegisterOrLoginSegmentedControl ()
    {
        let stackView = UIStackView(arrangedSubviews: [logoImageView, registerOrLoginSegmentedControl])
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 25
        
        backgroundView.addSubview(stackView)
        
        
        stackView.anchor(top: backgroundView.topAnchor, bottom: nil, left: backgroundView.leftAnchor, right: backgroundView.rightAnchor, paddingTop: 30, paddingBottom: 30, paddingLeft: 50, paddingRight: 50, width: 0, height: 0)
        stackView.heightAnchor.constraint(equalTo: backgroundView.heightAnchor, multiplier: 0.25).isActive = true
    }
  
    
    func setupRegisterOrLoginButton ()
    {
        backgroundView.addSubview(registerOrLoginButton)
        
        registerOrLoginButton.anchor(top: textFieldsBackgroundView.bottomAnchor, bottom: nil, left: nil, right: nil, paddingTop: 15, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        registerOrLoginButton.widthAndHeightByPercentOfParent(widthPercent: 0.8, heightPercent: 0.12, parentWidthAnchor: backgroundView.widthAnchor, parentHeightAnchor: backgroundView.heightAnchor)
        registerOrLoginButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
    }
    
    func setupForgotPasswordAndUpdateButton ()
    {
        let stackView = UIStackView(arrangedSubviews: [forgotPasswordButton, updatesButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        backgroundView.addSubview(stackView)
        
        stackView.anchor(top: registerOrLoginButton.bottomAnchor, bottom: backgroundView.bottomAnchor, left: nil, right: nil, paddingTop: 10, paddingBottom: 10, paddingLeft: 30, paddingRight: 30, width: 0, height: 0)
        stackView.widthAnchor.constraint(equalTo: backgroundView.widthAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        
        forgotPasswordButton.addTarget(self, action: #selector(presentForgotPasswordViewController), for: .touchUpInside)
        updatesButton.addTarget(self, action: #selector(presentUpdatesViewController), for: .touchUpInside)

    }
    
    @objc func presentForgotPasswordViewController ()
    {
        navigationController?.pushViewController(ForgotPasswordViewController(), animated: true)
    }
    
    @objc func presentUpdatesViewController ()
    {
        navigationController?.pushViewController(UpdatesViewController(), animated: true)
    }
    
    func setupEmailTextFieldHighlighterView ()
    {
        emailTextField.addSubview(emailTextFieldHighlighterView)
        
        emailTextFieldHighlighterView.anchor(top: nil, bottom: emailTextField.bottomAnchor, left: nil, right: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 3)
        emailTextFieldHighlighterView.centerXAnchor.constraint(equalTo: textFieldsBackgroundView.centerXAnchor).isActive = true
        emailTextFieldHighlighterView.widthAnchor.constraint(equalTo: textFieldsBackgroundView.widthAnchor).isActive = true
    }
    
    func setupPasswordTextFieldHighlighterView ()
    {
        passwordTextField.addSubview(passwordTextFieldHighlighterView)
        
        passwordTextFieldHighlighterView.anchor(top: nil, bottom: passwordTextField.bottomAnchor, left: nil, right: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 3)
        passwordTextFieldHighlighterView.centerXAnchor.constraint(equalTo: textFieldsBackgroundView.centerXAnchor).isActive = true
        passwordTextFieldHighlighterView.widthAnchor.constraint(equalTo: textFieldsBackgroundView.widthAnchor).isActive = true
    }
    
    
    // Resigns first responder with the return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        view.endEditing(true)
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Refresh the frame of the gradient
        gradient.frame = registerOrLoginButton.bounds
        emailHighlighterGradient.frame = emailTextFieldHighlighterView.bounds
        passwordHighlighterGradient.frame = passwordTextFieldHighlighterView.bounds
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        if checkIfUserIsLoggedIn()
        {
            setupTabBarViewControllers()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
}

