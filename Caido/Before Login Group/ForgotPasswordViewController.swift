//
//  ForgotPasswordViewController.swift
//  Caido
//
//  Created by Daniel on 8/3/18.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit

class ForgotPasswordViewController : UIViewController, UITextFieldDelegate
{
    let sendPasswordButtonGradient = CAGradientLayer()
    let emailHighlighterGradient = CAGradientLayer()
    
    let backgroundView : UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor(red: 240, green: 243, blue: 245)
        view.layer.cornerRadius = 10
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.30
        view.layer.shadowOffset = CGSize(width: -5, height: 10)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textFieldsBackgroundView : UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailTextField : UITextField =
    {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let emailIconImageView : UIImageView =
    {
        let imageView = UIImageView(image: UIImage(named: "email.png"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let closeIconImageView : UIImageView =
    {
        let imageView = UIImageView(image: UIImage(named: "close.png"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let promptLabel : UILabel =
    {
        let label = UILabel()
        label.text = "Type the email you used \n to register"
        label.textColor = UIColor(red: 165, green: 182, blue: 194)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let logoImageView : UIImageView =
    {
        let imageView = UIImageView(image: UIImage(named: "logo.png"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let bottomSeperatorView : UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor(red: 239, green: 239, blue: 239)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topSeperatorView : UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor(red: 239, green: 239, blue: 239)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var sendPasswordButton : UIButton =
    {
        let button = UIButton(type: .system)
        button.setTitle("Send Password", for: .normal)
        button.setTitleColor(UIColor(red: 141, green: 162, blue: 177), for: .normal)
        button.layer.cornerRadius = 10
        
        // Create border
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 182, green: 196, blue: 206).cgColor
        
        // Create gradient
        let firstColor = UIColor(red: 239, green: 242, blue: 244)
        let secondColor = UIColor(red: 215, green: 233, blue: 228)
        sendPasswordButtonGradient.colors = [firstColor.cgColor, secondColor.cgColor]
        sendPasswordButtonGradient.locations = [0,1]
        sendPasswordButtonGradient.cornerRadius = button.layer.cornerRadius
        button.layer.addSublayer(sendPasswordButtonGradient)
        
        // Create shadow
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: -3, height: 5)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var emailTextFieldHighlighterView : UIView =
        {
            let view = UIView()
            view.backgroundColor = UIColor.black
            view.layer.cornerRadius = 3
            view.alpha = 0
            // Create gradient
            let firstColor = UIColor(red: 92, green: 1, blue: 255)
            let secondColor = UIColor(red: 180, green: 248, blue: 209)
            emailHighlighterGradient.colors = [firstColor.cgColor, secondColor.cgColor]
            emailHighlighterGradient.locations = [0,1]
            emailHighlighterGradient.startPoint = CGPoint(x: 0, y: 0)
            emailHighlighterGradient.endPoint = CGPoint(x: 1, y: 0)
            emailHighlighterGradient.cornerRadius = view.layer.cornerRadius
            view.layer.addSublayer(emailHighlighterGradient)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
    }()
    
    override func viewDidLoad ()
    {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 88, green: 86, blue: 214)
        
        setupBackgroundView()
        setupTextFieldsBackgroundView()
        setupEmailTextField()
        setupEmailIconImageView()
        setupCloseIconImageView()
        setupPromptLabel()
        setupLogoImageView()
        setupSeperatorViews()
        setupSendPasswordButton()
        setupEmailHighligherView()
    }
    
    func setupBackgroundView ()
    {
        view.addSubview(backgroundView)
        backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        backgroundView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.65).isActive = true
        backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85).isActive = true
    }
    
    func setupTextFieldsBackgroundView ()
    {
        backgroundView.addSubview(textFieldsBackgroundView)
        textFieldsBackgroundView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        textFieldsBackgroundView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
        textFieldsBackgroundView.heightAnchor.constraint(equalTo: backgroundView.heightAnchor, multiplier: 0.15).isActive = true
        textFieldsBackgroundView.widthAnchor.constraint(equalTo: backgroundView.widthAnchor).isActive = true
    }
    
    func setupEmailTextField ()
    {
        textFieldsBackgroundView.addSubview(emailTextField)
        emailTextField.rightAnchor.constraint(equalTo: textFieldsBackgroundView.rightAnchor).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: textFieldsBackgroundView.centerYAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: textFieldsBackgroundView.widthAnchor, multiplier: 0.80).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: textFieldsBackgroundView.heightAnchor, multiplier: 0.80).isActive = true
        emailTextField.delegate = self
        
        emailTextField.addTarget(self, action: #selector(showEmailTextFieldHighlighterView), for: .editingDidBegin)
        emailTextField.addTarget(self, action: #selector(hideEmailTextFieldHighlighterView), for: .editingDidEnd)
    }
    
    @objc func showEmailTextFieldHighlighterView ()
    {
        UIView.animate(withDuration: 0.35) {
            self.emailTextFieldHighlighterView.alpha = 1
        }
    }
    
    @objc func hideEmailTextFieldHighlighterView ()
    {
        UIView.animate(withDuration: 0.35) {
            self.emailTextFieldHighlighterView.alpha = 0
        }
    }
    
    func setupEmailIconImageView ()
    {
        textFieldsBackgroundView.addSubview(emailIconImageView)
        
        emailIconImageView.leftAnchor.constraint(equalTo: textFieldsBackgroundView.leftAnchor).isActive = true
        emailIconImageView.rightAnchor.constraint(equalTo: emailTextField.leftAnchor).isActive = true
        emailIconImageView.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor).isActive = true
        emailIconImageView.heightAnchor.constraint(equalTo: emailTextField.heightAnchor, multiplier: 0.30).isActive = true
    }
    
    func setupCloseIconImageView ()
    {
        backgroundView.addSubview(closeIconImageView)
        
        closeIconImageView.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 10).isActive = true
        closeIconImageView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10).isActive = true
        closeIconImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        closeIconImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Setup gesture recognizer
        closeIconImageView.isUserInteractionEnabled = true
        closeIconImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissThisViewController)))
    }
    
    @objc func dismissThisViewController ()
    {
        dismiss(animated: true, completion: nil)
    }
    
    func setupPromptLabel ()
    {
        backgroundView.addSubview(promptLabel)
        
        promptLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        promptLabel.bottomAnchor.constraint(equalTo: textFieldsBackgroundView.topAnchor).isActive = true
        promptLabel.widthAnchor.constraint(equalTo: backgroundView.widthAnchor).isActive = true
        promptLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setupLogoImageView ()
    {
        backgroundView.addSubview(logoImageView)
        
        logoImageView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        logoImageView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 30).isActive = true
        logoImageView.widthAnchor.constraint(equalTo: backgroundView.widthAnchor).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    func setupSeperatorViews ()
    {
        textFieldsBackgroundView.addSubview(topSeperatorView)
        
        // Top seperator
        textFieldsBackgroundView.addSubview(topSeperatorView)
        topSeperatorView.centerXAnchor.constraint(equalTo: textFieldsBackgroundView.centerXAnchor).isActive = true
        topSeperatorView.centerYAnchor.constraint(equalTo: textFieldsBackgroundView.topAnchor).isActive = true
        topSeperatorView.widthAnchor.constraint(equalTo: textFieldsBackgroundView.widthAnchor).isActive = true
        topSeperatorView.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        
        // Bottom seperator
        textFieldsBackgroundView.addSubview(bottomSeperatorView)
        bottomSeperatorView.centerXAnchor.constraint(equalTo: textFieldsBackgroundView.centerXAnchor).isActive = true
        bottomSeperatorView.centerYAnchor.constraint(equalTo: textFieldsBackgroundView.bottomAnchor).isActive = true
        bottomSeperatorView.widthAnchor.constraint(equalTo: textFieldsBackgroundView.widthAnchor).isActive = true
        bottomSeperatorView.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
    }
    
    func setupSendPasswordButton ()
    {
        backgroundView.addSubview(sendPasswordButton)
        
        sendPasswordButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        sendPasswordButton.topAnchor.constraint(equalTo: textFieldsBackgroundView.bottomAnchor, constant: 15).isActive = true
        sendPasswordButton.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.8).isActive = true
        sendPasswordButton.heightAnchor.constraint(equalTo: backgroundView.heightAnchor, multiplier: 0.12).isActive = true
    }
    
    func setupEmailHighligherView ()
    {
        emailTextField.addSubview(emailTextFieldHighlighterView)
        emailTextFieldHighlighterView.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor).isActive = true
        emailTextFieldHighlighterView.bottomAnchor.constraint(equalTo: textFieldsBackgroundView.bottomAnchor).isActive = true
        emailTextFieldHighlighterView.widthAnchor.constraint(equalTo: emailTextField.widthAnchor).isActive = true
        emailTextFieldHighlighterView.heightAnchor.constraint(equalToConstant: 6).isActive = true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLayoutSubviews() {
        sendPasswordButtonGradient.frame = sendPasswordButton.bounds
        emailHighlighterGradient.frame = emailTextFieldHighlighterView.bounds
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        view.endEditing(true)
    }
    
}
