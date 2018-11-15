//
//  Product.swift
//  Caido
//
//  Created by Daniel on 9/12/18.
//  Copyright © 2018 Daniel. All rights reserved.
//

import Foundation

struct Product
{
    var brand : String?
    var product_name : String?
    var photo_url : String?
    var size : String?
    var price : String?
    
    init (dictionary : [String : Any])
    {
        if let brand = dictionary["brand"] as? String
        {
            self.brand = brand
        }
        
        if let product_name = dictionary["product_name"] as? String
        {
            self.product_name = product_name
        }
        
        if let photo_url = dictionary["photo_url"] as? String
        {
            self.photo_url = photo_url
        }
        
        if let size = dictionary["size"] as? String
        {
            self.size = size
        }
        
        if let price = dictionary["price"] as? String
        {
            self.price = price
        }
        
    }
}
