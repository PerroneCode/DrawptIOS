//
//  User.swift
//  Caido
//
//  Created by Daniel on 9/11/18.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit

struct User
{
    var email: String?
    var uid:   String?
    
    init (email: String, uid: String)
    {
        self.email = email
        self.uid = uid
    }
}
