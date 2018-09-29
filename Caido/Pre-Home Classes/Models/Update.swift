//
//  Update.swift
//  Caido
//
//  Created by Daniel on 9/24/18.
//  Copyright © 2018 Daniel. All rights reserved.
//

import Foundation

struct Update
{
    var title : String?
    var text : String?
    var date : String?
    var photoUrl : String?
    
    init (dictionary : [String : Any])
    {
        if let title = dictionary["title"] as? String
        {
                self.title = title
        }
        
        if let text = dictionary["text"] as? String
        {
            self.text = text
        }
        
        if let date = dictionary["date"] as? String
        {
            self.date = date
        }
        
        if let photoUrl = dictionary["photo_url"] as? String
        {
            self.photoUrl = photoUrl
        }
    }
}
