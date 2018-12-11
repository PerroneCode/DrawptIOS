//
//  SessionTracker.swift
//  Caido
//
//  Created by Daniel on 9/12/18.
//  Copyright © 2018 Daniel. All rights reserved.
//

import Foundation
import Firebase


func checkIfUserIsLoggedIn () -> (User?, Bool)
{
    if let currentUser = Auth.auth().currentUser
    {
        // If the user is logged in, the set the properties in other classes
        let user = User(email: currentUser.email!, uid: currentUser.uid)
        return (user, true)
    } else
    {
        // If the user is not logged in, then dismiss whatever view controller is being displayed by returning a value from here
        return (nil, false)
    }
}

// This function signs the user out, true means the user was signed out, and false means otherwise
func signOut (user: User) -> Bool
{
    do {
        try Auth.auth().signOut()
        
        removeSessionTracker(uid: user.uid!)
        return true
    } catch let error as NSError
    {
        print("Error:\(error)")
        return false
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

func removeSessionTracker (uid: String?)
{
    if let uid = uid
    {
        Database.database().reference().child("online_users").child(uid).removeValue()
        
        print("Session tracker removed")
    }
}

