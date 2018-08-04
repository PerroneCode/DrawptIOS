//
//  File.swift
//  Caido
//
//  Created by Daniel on 8/2/18.
//  Copyright © 2018 Daniel. All rights reserved.
//
import UIKit
extension UIColor
{
    convenience init (red: CGFloat, green: CGFloat, blue: CGFloat)
    {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
