//
//  Video.swift
//  YoutubeClone
//
//  Created by rawat on 21/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class Trip: NSObject{
    var id: NSNumber?
    var thumbnail_image_url: String?
    var name: String?
    var tripDescription: String?
    var trip_likes_count: NSNumber?
    var updated_at: NSDate?
    var created_at: NSDate?
    var is_liked_by_current_user: Bool = false
    var user_id: NSNumber?
    
    var user: User?
    var cities: [City] = []
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        
        setValuesForKeys(dictionary)
        
        user = User(dictionary: dictionary["user"] as! [String: AnyObject])
        
        if let citiesArray = dictionary["cities"] {
            for cityDict in citiesArray as! [[String: AnyObject]] {
                cities.append(City(dictionary: cityDict))
            }
        }
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        var _key = key
        
        if (key == "description") {
            _key = "tripDescription"
        }
        
        if (["user", "cities"].contains(_key)) {
            return
        }
        
        super.setValue(value, forKey: _key)
    }
}
