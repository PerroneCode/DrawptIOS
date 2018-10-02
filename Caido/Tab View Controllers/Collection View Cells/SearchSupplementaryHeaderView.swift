//
//  SearchSupplementaryHeaderView.swift
//  Caido
//
//  Created by Daniel on 10/1/18.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit

class SearchSupplementaryHeaderView : UICollectionViewCell
{
    let searchTextField : UITextField =
    {
        let textField = UITextField()
        textField.placeholder = "🔍 Search"
        textField.font = UIFont(name: "Helvetica", size: 15)
        textField.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.ultraLight)
        textField.backgroundColor = UIColor(red: 234, green: 235, blue: 237)
        textField.layer.cornerRadius = 10
        
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        
        let rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0.0))
        textField.rightView = rightView
        textField.rightViewMode = .always
        
        
        return textField
    }()
    
    override init (frame: CGRect)
    {
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor.white
        
        setupSearchTextField()
    }
    
    func setupSearchTextField ()
    {
        addSubview(searchTextField)
        
        searchTextField.anchor(top: nil, bottom: nil, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 10, paddingRight: 10, width: 0, height: 35)
        searchTextField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
