//
//  Video.swift
//  YoutubeClone
//
//  Created by rawat on 21/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class Trip: NSObject {
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
    var cities: [City]?
}
