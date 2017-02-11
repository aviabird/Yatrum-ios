//
//  City.swift
//  TravelApp
//
//  Created by rawat on 29/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class City: NSObject {
    var id: NSNumber?
    var name: String?
    var country: String?
    var created_at: String?
    var updated_at: String?
    
    var places: [Place] = []
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        
        setValuesForKeys(dictionary)
        
        if let placesArray = dictionary["places"] {
            for placeDict in placesArray as! [[String: AnyObject]] {
                places.append(Place(dictionary: placeDict))
            }
        }
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        let _key = key
        
        if ("places" == _key) {
            return
        }
        
        super.setValue(value, forKey: _key)
    }
}
