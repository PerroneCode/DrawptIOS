//
//  Product.swift
//  Caido
//
//  Created by Daniel on 9/13/18.
//  Copyright © 2018 Daniel. All rights reserved.
//

import Foundation

struct NewsStory
{
    var title : String?
    var preview_text : String?
    var photo_url : String?
    var date : NSDate?
    
    init (dictionary : [String : Any])
    {
        if let title = dictionary["title"] as? String
        {
            self.title = title
        }
        
        if let preview_text = dictionary["preview_text"] as? String
        {
            self.preview_text = preview_text
        }
        
        if let photo_url = dictionary["photo_url"] as? String
        {
            self.photo_url = photo_url
        }
        
        if let date = dictionary["size"] as? NSDate
        {
            self.date = date
        }
        
    }
}
