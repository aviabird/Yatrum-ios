//
//  Place.swift
//  TravelApp
//
//  Created by rawat on 29/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//


import UIKit

class Place: NSObject {
    var id: NSNumber?
    var name: String?
    var placeDescription: String?
    var review: String?
    var created_at: NSDate?
    var updated_at: NSDate?
    
    var pictures: [Picture] = []
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        
        setValuesForKeys(dictionary)
        
        if let picturesArray = dictionary["pictures"] {
            for pictureDict in picturesArray as! [[String: AnyObject]] {
                pictures.append(Picture(dictionary: pictureDict))
            }
        }
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        var _key = key
        
        if (key == "description") {
            _key = "placeDescription"
        }
        
        if ("pictures" == _key) {
            return
        }
        
        super.setValue(value, forKey: _key)
    }
}
