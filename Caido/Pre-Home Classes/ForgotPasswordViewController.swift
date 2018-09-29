//
//  ForgotPasswordViewController.swift
//  Caido
//
//  Created by Daniel on 8/3/18.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit
import Firebase

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
        let imageView = UIImageView(image: UIImage(named: "email.png"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let closeButton : UIButton =
    {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let promptLabel : UILabel =
    {
        let label = UILabel()
        label.text = "Enter Your Email"
        label.textColor = UIColor(red: 165, green: 182, blue: 194)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let logoImageView : UIImageView =
    {
        let imageView = UIImageView(image: UIImage(named: "logo.png"))
        imageView.contentMode = .scaleAspectFit
        return imageView
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
    
    override func viewDidLoad ()
    {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 88, green: 86, blue: 214)
        
        setupBackgroundView()
        setupTextFieldsBackgroundView()
        setupEmailTextField()
        setupEmailIconImageView()
        setupLogoImageViewAndPromptLabel()
        setupCloseButton()
        setupSendPasswordButton()
        setupEmailHighligherView()
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
        textFieldsBackgroundView.widthAndHeightByPercentOfParent(widthPercent: 1, heightPercent: 0.15, parentWidthAnchor: backgroundView.widthAnchor, parentHeightAnchor: backgroundView.widthAnchor)
    }
    
    func setupEmailTextField ()
    {
        textFieldsBackgroundView.addSubview(emailTextField)
        
        emailTextField.anchor(top: textFieldsBackgroundView.topAnchor, bottom: textFieldsBackgroundView.bottomAnchor, left: nil, right: textFieldsBackgroundView.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        emailTextField.widthAnchor.constraint(equalTo: textFieldsBackgroundView.widthAnchor, multiplier: 0.8).isActive = true
        
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
        
        emailIconImageView.anchor(top: nil, bottom: nil, left: textFieldsBackgroundView.leftAnchor, right: emailTextField.leftAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 17.5)
        emailIconImageView.centerYAnchor.constraint(equalTo: textFieldsBackgroundView.centerYAnchor).isActive = true
    }
    
    func setupCloseButton ()
    {
        backgroundView.addSubview(closeButton)
        
        closeButton.anchor(top: backgroundView.topAnchor, bottom: nil, left: nil, right: backgroundView.rightAnchor, paddingTop: 10, paddingBottom: 0, paddingLeft: 0, paddingRight: 10, width: 30, height: 30)
        
        closeButton.addTarget(self, action: #selector(dismissThisViewController), for: .touchUpInside)
    }
    
    @objc func dismissThisViewController ()
    {
        navigationController?.popViewController(animated: true)
    }
    
    func setupLogoImageViewAndPromptLabel ()
    {
        let stackView = UIStackView(arrangedSubviews: [logoImageView, promptLabel])
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 25
        
        backgroundView.addSubview(stackView)
        
        
        stackView.anchor(top: backgroundView.topAnchor, bottom: nil, left: backgroundView.leftAnchor, right: backgroundView.rightAnchor, paddingTop: 30, paddingBottom: 30, paddingLeft: 50, paddingRight: 50, width: 0, height: 0)
        stackView.heightAnchor.constraint(equalTo: backgroundView.heightAnchor, multiplier: 0.25).isActive = true
    }
    
    
    func setupSendPasswordButton ()
    {
        backgroundView.addSubview(sendPasswordButton)
        
        sendPasswordButton.anchor(top: textFieldsBackgroundView.bottomAnchor, bottom: nil, left: backgroundView.leftAnchor, right: backgroundView.rightAnchor, paddingTop: 20, paddingBottom: 0, paddingLeft: 30, paddingRight: 30, width: 0, height: 50)
        
        sendPasswordButton.addTarget(self, action: #selector(sendPasswordResetEmail), for: .touchUpInside)
    }
    
    @objc func sendPasswordResetEmail ()
    {
        guard let email = emailTextField.text else { return }
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            
            if let error = error
            {
                self.showPasswordResetEmailSuccessOrError(message: error.localizedDescription, isError: true)
                
                return
            }
            
            self.showPasswordResetEmailSuccessOrError(message: "A password reset link has been sent to \(email)", isError: false)
            
        }
    }
    
    func showPasswordResetEmailSuccessOrError (message: String, isError: Bool)
    {
        let alertController = UIAlertController(title: isError ? "Error" : "" , message: message, preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okayButton)
        
        present(alertController, animated: false, completion: nil)
    }
    
    func setupEmailHighligherView ()
    {
        emailTextField.addSubview(emailTextFieldHighlighterView)
        
        emailTextFieldHighlighterView.anchor(top: nil, bottom: emailTextField.bottomAnchor, left: nil, right: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 3)
        emailTextFieldHighlighterView.centerXAnchor.constraint(equalTo: textFieldsBackgroundView.centerXAnchor).isActive = true
        emailTextFieldHighlighterView.widthAnchor.constraint(equalTo: textFieldsBackgroundView.widthAnchor).isActive = true
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
}
