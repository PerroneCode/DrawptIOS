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
    let backgroundView : UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor(red: 240, green: 243, blue: 245)
        view.layer.cornerRadius = 10
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
    
    override func viewDidLoad ()
    {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 88, green: 86, blue: 214)
        
        setupBackgroundView()
        setupTextFieldsBackgroundView()
        setupEmailTextField()
        setupEmailIconImageView()
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
    }
    
    func setupEmailIconImageView ()
    {
        textFieldsBackgroundView.addSubview(emailIconImageView)
        
        emailIconImageView.leftAnchor.constraint(equalTo: textFieldsBackgroundView.leftAnchor).isActive = true
        emailIconImageView.rightAnchor.constraint(equalTo: emailTextField.leftAnchor).isActive = true
        emailIconImageView.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor).isActive = true
        emailIconImageView.heightAnchor.constraint(equalTo: emailTextField.heightAnchor, multiplier: 0.30).isActive = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        view.endEditing(true)
    }
    
}
