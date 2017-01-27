//
//  Video.swift
//  YoutubeClone
//
//  Created by rawat on 21/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class Trip: NSObject {
    var thumbnailImageURL: String?
    var title: String?
    var numberOfLikes: NSNumber?
    var updatedAt: NSDate?
    var isLikedByCurrentUser: Bool = false
    
    var user: User?
}

class User: NSObject {
    var name: String?
    var profileImageURL: String?
}
