//
//  Trip.swift
//  TravelApp
//
//  Created by rawat on 28/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class User: NSObject {
    var id: NSNumber?
    var name: String?
    var email: String?
    var instagram_access_token: String?
    var instagram_profile_picture: String?
    var instagram_user_name: String?
    var profile_pic: ProfilePic?
    var cover_photo: CoverPic?
    var total_followers: NSNumber?
    var total_following: NSNumber?
    var total_trips: NSNumber?
    var is_followed_by_current_user: Bool?
}

class ProfilePic: NSObject {
    var url: String?
    var public_id: String?
}

class CoverPic: ProfilePic {
}
