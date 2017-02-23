//
//  Picture.swift
//  TravelApp
//
//  Created by rawat on 29/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//


import UIKit

class Picture: NSObject {
    
    var id: NSNumber?
    var url: String?
    var picDescription: String?
    var public_id: String?
    var created_at: String?
    var updated_at: String?
    var user_id: NSNumber?
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dictionary)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        var _key = key
        
        if (key == "description") {
            _key = "picDescription"
        }
        
        super.setValue(value, forKey: _key)
    }
}
