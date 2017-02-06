//
//  PlaceCell.swift
//  TravelApp
//
//  Created by rawat on 04/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class PlaceCell: BaseCell {
    
    var place: Place! {
        didSet{
            placeViewBadgeTitleLabel.text = place.name
            placeViewBadgeDateLabel.text = "5 Feb 17' 12:00 pm"
            placeDescText.text = place.placeDescription
            
            placeDescTextHeightConstraint.constant = placeDescText.contentSize.height + 30
            placeDescTextHeightConstraint.isActive = true
        }
    }
    
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
    
    let placeViewVerticalSeparator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        return view
    }()
    
    let navMarkerButton: UIButton = {
        let ub = UIButton(type: .system)
        ub.setImage(UIImage(named: "nav-marker"), for: .normal)
        ub.tintColor = UIColor.appSecondaryColor()
        ub.translatesAutoresizingMaskIntoConstraints = false
        return ub
    }()
    
    let placeViewBadge: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.rgb(red: 41, green: 128, blue: 185)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.5
        return view
    }()
    
    let placeViewBadgeDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Day 1"
        label.numberOfLines = 1
        label.font = label.font.withSize(8)
        label.textColor = UIColor.white
        label.textAlignment = .right
        return label
    }()
    
    let placeViewBadgeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 1
        label.font = label.font.withSize(15)
        label.textAlignment = .right
        label.textColor = UIColor.white
        return label
    }()
    
    let placeDescText: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Amazing View of eiffel tower."
        textView.textColor = UIColor.gray
        textView.isEditable = false
        textView.textAlignment = .justified
        return textView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addPlaceView()
        addPlaceViewBadge()
        addSubViewToPlaceView()
        addNavMarker()
    }
    
    func addNavMarker() {
        addSubview(navMarkerButton)
        addSubview(placeViewVerticalSeparator)
        
        navMarkerButton.bottomAnchor.constraint(equalTo: placeViewBadge.bottomAnchor).isActive = true
        navMarkerButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 3).isActive = true
        navMarkerButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        navMarkerButton.heightAnchor.constraint(equalTo: placeViewBadge.heightAnchor, multiplier: 1.3).isActive = true
        
        placeViewVerticalSeparator.topAnchor.constraint(equalTo: navMarkerButton.bottomAnchor, constant: 5).isActive = true
        placeViewVerticalSeparator.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        placeViewVerticalSeparator.widthAnchor.constraint(equalToConstant: 2).isActive = true
        placeViewVerticalSeparator.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func addPlaceViewBadge() {
        addSubview(placeViewBadge)
        placeViewBadge.addSubview(placeViewBadgeTitleLabel)
        placeViewBadge.addSubview(placeViewBadgeDateLabel)
        
        placeViewBadge.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        placeViewBadge.widthAnchor.constraint(equalTo: widthAnchor, constant: -50).isActive = true
        placeViewBadge.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        placeViewBadge.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        placeViewBadgeTitleLabel.topAnchor.constraint(equalTo: placeViewBadge.topAnchor, constant: 3).isActive = true
        placeViewBadgeTitleLabel.widthAnchor.constraint(equalTo: placeViewBadge.widthAnchor).isActive = true
        placeViewBadgeTitleLabel.rightAnchor.constraint(equalTo: placeViewBadge.rightAnchor, constant: -20).isActive = true
        placeViewBadgeTitleLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
        
        placeViewBadgeDateLabel.topAnchor.constraint(equalTo: placeViewBadgeTitleLabel.bottomAnchor).isActive = true
        placeViewBadgeDateLabel.rightAnchor.constraint(equalTo: placeViewBadge.rightAnchor, constant: -20).isActive = true
        placeViewBadgeDateLabel.widthAnchor.constraint(equalTo: placeViewBadge.widthAnchor).isActive = true
        placeViewBadgeDateLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
    }
    
    func addPlaceView() {
        addSubview(placeView)
        
        placeView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        placeView.widthAnchor.constraint(equalTo: widthAnchor, constant: -20).isActive = true
        placeView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        placeView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    var placeDescTextHeightConstraint: NSLayoutConstraint!
    
    func addSubViewToPlaceView() {
        placeView.addSubview(placeDescText)
//        placeView.addSubview(placeViewSeparator)
        
        placeDescText.topAnchor.constraint(equalTo: placeViewBadge.bottomAnchor, constant: 10).isActive = true
        placeDescText.widthAnchor.constraint(equalTo: placeViewBadge.widthAnchor, constant: -20).isActive = true
        placeDescText.rightAnchor.constraint(equalTo: placeViewBadge.rightAnchor, constant: -20).isActive = true
        placeDescTextHeightConstraint = placeDescText.heightAnchor.constraint(equalToConstant: 10)
        
//        placeViewSeparator.topAnchor.constraint(equalTo: placeDescText.bottomAnchor, constant: 10).isActive = true
//        placeViewSeparator.widthAnchor.constraint(equalTo: placeDescText.widthAnchor).isActive = true
//        placeViewSeparator.leftAnchor.constraint(equalTo: placeDescText.leftAnchor).isActive = true
//        placeViewSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    
    
}
