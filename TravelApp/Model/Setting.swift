//
//  Setting.swift
//  TravelApp
//
//  Created by rawat on 23/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: SettingName
    let imageName: String
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

enum SettingName: String {
    case Cancel = "Cancel"
    case Settings = "Settings"
    case Privacy = "Terms & privacy policy"
    case Feedback = "Send Feedback"
    case Logout = "Logout"
}
