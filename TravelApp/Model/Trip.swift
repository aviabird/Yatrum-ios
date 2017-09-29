//
//  Video.swift
//  YoutubeClone
//
//  Created by rawat on 21/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

@objc class Trip: NSObject{
    var id: NSNumber?
    var thumbnail_image_url: String?
    var name: String?
    var tripDescription: String?
    var trip_likes_count: NSNumber?
    var updated_at: String?
    var created_at: String?
    var is_liked_by_current_user: Bool = false
    var user_id: NSNumber?
    var tag_list: NSArray?
    var view_count: NSNumber?
    
    var user: User?
    var places: [Place] = []
    
    func setValuesByJson(dictionary: [String: AnyObject]) {
        
        setValuesForKeys(dictionary)
        
        user = User(dictionary: dictionary["user"] as! [String: AnyObject])
        
        if let placesArray = dictionary["places"] {
            for placeDict in placesArray as! [[String: AnyObject]] {
                let place = Place()
                place.setValuesByJson(dictionary: placeDict)
                places.append(place)
            }
        }
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        var _key = key
        
        if (key == "description") {
            _key = "tripDescription"
        }
        
        if (["user", "places"].contains(_key)) {
            return
        }
        
        super.setValue(value, forKey: _key)
    }
}
