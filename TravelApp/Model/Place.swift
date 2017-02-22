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
    var review: String = ""
    var created_at: String?
    var updated_at: String?
    var visited_date: String?
    
    var pictures: [Picture] = []
    
    func setValuesByJson(dictionary: [String: AnyObject]) {
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
