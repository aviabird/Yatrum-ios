//
//  PlaceCell.swift
//  TravelApp
//
//  Created by rawat on 04/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class PlaceCell: BaseCell {
    
    var city: City! {
        didSet{
            titleLabel.text = city.name
        }
    }
    var place: Place!
    
    let placeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let placeViewSeparator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        return view
    }()
    
    let placeViewBadge: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.appSecondaryColor()
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.5
        return view
    }()
    
    let placeViewBadgeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Day 1"
        label.numberOfLines = 1
        label.font = label.font.withSize(12)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 1
        label.font = label.font.withSize(14)
        label.textAlignment = .right
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 100
        label.font = label.font.withSize(14)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addPlaceView()
        addPlaceViewBadge()
        addSubViewToPlaceView()
    }
    
    func addPlaceViewBadge() {
        addSubview(placeViewBadge)
        
        placeViewBadge.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        placeViewBadge.widthAnchor.constraint(equalToConstant: 50).isActive = true
        placeViewBadge.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        placeViewBadge.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        placeViewBadge.addSubview(placeViewBadgeLabel)
        placeViewBadgeLabel.topAnchor.constraint(equalTo: placeViewBadge.topAnchor, constant: 2).isActive = true
        placeViewBadgeLabel.leftAnchor.constraint(equalTo: placeViewBadge.leftAnchor).isActive = true
        placeViewBadgeLabel.widthAnchor.constraint(equalTo: placeViewBadge.widthAnchor).isActive = true
        placeViewBadgeLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
    }
    
    func addPlaceView() {
        addSubview(placeView)
        
        placeView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        placeView.widthAnchor.constraint(equalTo: widthAnchor, constant: -20).isActive = true
        placeView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        placeView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    func addSubViewToPlaceView() {
        placeView.addSubview(titleLabel)
        placeView.addSubview(subTitleLabel)
        placeView.addSubview(placeViewSeparator)
        
        titleLabel.topAnchor.constraint(equalTo: placeView.topAnchor, constant: 5).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: placeView.widthAnchor, constant: -60).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: placeView.rightAnchor, constant: -5).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        subTitleLabel.widthAnchor.constraint(equalTo: placeView.widthAnchor, constant: -10).isActive = true
        subTitleLabel.leftAnchor.constraint(equalTo: placeView.leftAnchor, constant: 5).isActive = true
        
        placeViewSeparator.topAnchor.constraint(equalTo: placeView.bottomAnchor, constant: -1).isActive = true
        placeViewSeparator.widthAnchor.constraint(equalTo: placeView.widthAnchor).isActive = true
        placeViewSeparator.leftAnchor.constraint(equalTo: placeView.leftAnchor).isActive = true
        placeViewSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    
}
