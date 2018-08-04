//
//  ViewController.swift
//  Caido
//
//  Created by Daniel on 8/2/18.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let gradient = CAGradientLayer()
    
    let backgroundView : UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor(red: 221, green: 221, blue: 246)
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
    
    let passwordTextField : UITextField =
    {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordIconImageView : UIImageView =
    {
        let imageView = UIImageView(image: UIImage(named: "key.png"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let middleSeperatorView : UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor(red: 239, green: 239, blue: 239)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    
    let logoImageView : UIImageView =
    {
        let imageView = UIImageView(image: UIImage(named: "logo.png"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var loginButton : UIButton =
    {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Login", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        button.layer.cornerRadius = 10
        
        let leftColor = UIColor(red: 70, green: 149, blue: 247)
        let rightColor = UIColor(red: 39, green: 90, blue: 245)
        self.gradient.colors = [leftColor.cgColor, rightColor.cgColor]
        gradient.frame = button.frame
        gradient.locations = [0,0.5,1]
        gradient.cornerRadius = button.layer.cornerRadius
        button.layer.addSublayer(gradient)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let forgotPasswordLabel : UILabel =
    {
        let label = UILabel()
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: "Forgot password?", attributes: [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        label.textColor = UIColor(red: 124, green: 124, blue: 137)
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change background color using custom extension
        view.backgroundColor = UIColor(red: 88, green: 86, blue: 214)
        
        setupBackgroundView()
        setupTextFieldsBackgroundView()
        setupEmailTextField()
        setupEmailIconImageView()
        setupPasswordTextField()
        setupPasswordIconImageView()
        setupSeperatorView()
        setupLogoImageView()
        setupLoginButton()
        setupForgotPasswordLabel()
    }

    func setupBackgroundView ()
    {
        view.addSubview(backgroundView)
        backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        backgroundView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45).isActive = true
        backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85).isActive = true
    }
    
    func setupTextFieldsBackgroundView ()
    {
        backgroundView.addSubview(textFieldsBackgroundView)
        textFieldsBackgroundView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        textFieldsBackgroundView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
        textFieldsBackgroundView.heightAnchor.constraint(equalTo: backgroundView.heightAnchor, multiplier: 0.30).isActive = true
        textFieldsBackgroundView.widthAnchor.constraint(equalTo: backgroundView.widthAnchor).isActive = true
    }
    
    func setupEmailTextField ()
    {
        textFieldsBackgroundView.addSubview(emailTextField)
        emailTextField.rightAnchor.constraint(equalTo: textFieldsBackgroundView.rightAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: textFieldsBackgroundView.topAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: textFieldsBackgroundView.widthAnchor, multiplier: 0.80).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: textFieldsBackgroundView.heightAnchor, multiplier: 0.5).isActive = true
        emailTextField.delegate = self
    }
    
    func setupEmailIconImageView ()
    {
        textFieldsBackgroundView.addSubview(emailIconImageView)
        
        emailIconImageView.leftAnchor.constraint(equalTo: textFieldsBackgroundView.leftAnchor).isActive = true
        emailIconImageView.rightAnchor.constraint(equalTo: emailTextField.leftAnchor).isActive = true
        emailIconImageView.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor).isActive = true
        emailIconImageView.heightAnchor.constraint(equalTo: emailTextField.heightAnchor, multiplier: 0.30).isActive = true
    }
    
    func setupPasswordIconImageView ()
    {
        textFieldsBackgroundView.addSubview(passwordIconImageView)
        passwordIconImageView.leftAnchor.constraint(equalTo: textFieldsBackgroundView.leftAnchor).isActive = true
        passwordIconImageView.rightAnchor.constraint(equalTo: passwordTextField.leftAnchor).isActive = true
        passwordIconImageView.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor).isActive = true
        passwordIconImageView.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor, multiplier: 0.30).isActive = true
    }
    
    func setupPasswordTextField ()
    {
        textFieldsBackgroundView.addSubview(passwordTextField)
        passwordTextField.rightAnchor.constraint(equalTo: textFieldsBackgroundView.rightAnchor).isActive = true
        passwordTextField.bottomAnchor.constraint(equalTo: textFieldsBackgroundView.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: textFieldsBackgroundView.widthAnchor, multiplier: 0.80).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: textFieldsBackgroundView.heightAnchor, multiplier: 0.5).isActive = true
        passwordTextField.delegate = self
    }
    
    func setupSeperatorView ()
    {
        // Center seperator
        textFieldsBackgroundView.addSubview(middleSeperatorView)
        middleSeperatorView.centerXAnchor.constraint(equalTo: textFieldsBackgroundView.centerXAnchor).isActive = true
        middleSeperatorView.centerYAnchor.constraint(equalTo: textFieldsBackgroundView.centerYAnchor).isActive = true
        middleSeperatorView.widthAnchor.constraint(equalTo: textFieldsBackgroundView.widthAnchor).isActive = true
        middleSeperatorView.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        
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
    
    func setupLogoImageView ()
    {
        backgroundView.addSubview(logoImageView)
        logoImageView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        logoImageView.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        logoImageView.bottomAnchor.constraint(equalTo: textFieldsBackgroundView.topAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.2).isActive = true
    }
    
    func setupLoginButton ()
    {
        backgroundView.addSubview(loginButton)
        loginButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: textFieldsBackgroundView.bottomAnchor, constant: 15).isActive = true
        loginButton.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.8).isActive = true
        loginButton.heightAnchor.constraint(equalTo: backgroundView.heightAnchor, multiplier: 0.12).isActive = true
    }
    
    func setupForgotPasswordLabel ()
    {
        backgroundView.addSubview(forgotPasswordLabel)
        forgotPasswordLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        forgotPasswordLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10).isActive = true
        forgotPasswordLabel.widthAnchor.constraint(equalTo: backgroundView.widthAnchor).isActive = true
        forgotPasswordLabel.heightAnchor.constraint(equalTo: backgroundView.heightAnchor, multiplier: 0.20)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(presentForgotPasswordViewController))
        forgotPasswordLabel.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func presentForgotPasswordViewController ()
    {
        present(ForgotPasswordViewController(), animated: true, completion: nil)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Refresh the frame of the gradient
        gradient.frame = loginButton.bounds
        
    }


}

