//
//  SessionTracker.swift
//  Caido
//
//  Created by Daniel on 9/12/18.
//  Copyright © 2018 Daniel. All rights reserved.
//

import Foundation
import Firebase

func removeSessionTracker (uid: String?)
{
    if let uid = uid
    {
        Database.database().reference().child("online_users").child(uid).removeValue()
    }
}

func setupSessionTracker (email: String, uid: String)
{
    let values = ["email" : email]
    let reference = Database.database().reference().child("online_users").child(uid)
    
    reference.setValue(values) { (error, reference) in
        
        if let error = error
        {
            print("Error:\(error)")
        }
        
    }
}
