//
//  ViewAnchors.swift
//  Caido
//
//  Created by Daniel on 9/23/18.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit

extension UIView
{
    
    func widthAndHeightByPercentOfParent (widthPercent: CGFloat, heightPercent: CGFloat, parentWidthAnchor: NSLayoutDimension, parentHeightAnchor: NSLayoutDimension)
    {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.widthAnchor.constraint(equalTo: parentWidthAnchor, multiplier: widthPercent).isActive = true
        self.heightAnchor.constraint(equalTo: parentHeightAnchor, multiplier: heightPercent).isActive = true
    }
    
    func centerInParent (centerX: NSLayoutXAxisAnchor, centerY: NSLayoutYAxisAnchor)
    {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        self.centerYAnchor.constraint(equalTo: centerY).isActive = true
    }
    
    func anchor (top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingBottom: CGFloat, paddingLeft: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat)
    {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if top != nil
        {
            self.topAnchor.constraint(equalTo: top!, constant: paddingTop).isActive = true
        }
        
        if bottom != nil
        {
            self.bottomAnchor.constraint(equalTo: bottom!, constant: -paddingBottom).isActive = true
        }
        
        if left != nil
        {
            self.leftAnchor.constraint(equalTo: left!, constant: paddingLeft).isActive = true
        }
        
        if right != nil
        {
            self.rightAnchor.constraint(equalTo: right!, constant: -paddingRight).isActive = true
        }
        
        if width != 0
        {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0
        {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
