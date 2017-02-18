//
//  PlaceEditCell.swift
//  TravelApp
//
//  Created by rawat on 18/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class PlaceEditCell: BaseCell {
    
    var place: Place!

    let placeViewBadge: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.rgb(red: 41, green: 128, blue: 185)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = UIColor.appMainBGColor()
        
        addPlaceViewBadge()
    }
    
    func addPlaceViewBadge() {
        addSubview(placeViewBadge)
        
        placeViewBadge.topAnchor.constraint(equalTo: topAnchor).isActive = true
        placeViewBadge.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        placeViewBadge.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        placeViewBadge.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

}
