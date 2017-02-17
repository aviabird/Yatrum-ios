//
//  UserTripCell.swift
//  TravelApp
//
//  Created by Nitesh on 14/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class UserTripCell: UICollectionViewCell {
    
    let thumbnailImageView: UIImageView = {
        let ti = UIImageView()
        ti.contentMode = .scaleAspectFill
        ti.clipsToBounds = true
        ti.image = UIImage(named: "")
        ti.translatesAutoresizingMaskIntoConstraints = false
        ti.alpha = 0.5
        ti.backgroundColor = UIColor.blue
        return ti
    }()
    
    let userProfileImageView: UIImageView = {
        let ui = UIImageView()
        ui.image = UIImage(named: "")
        ui.contentMode = .scaleAspectFill
        ui.clipsToBounds = true
        ui.layer.cornerRadius = 22
        ui.layer.masksToBounds = true
        ui.layer.borderWidth = 2
        ui.layer.borderColor = UIColor.white.cgColor
        ui.translatesAutoresizingMaskIntoConstraints = false
        ui.backgroundColor = UIColor.red
        return ui
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 1
        label.font = label.font.withSize(15)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.green
        return label
    }()
    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 1
        label.font = label.font.withSize(12)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.yellow
        return label
    }()
    
    let likeButton: UIButton = {
        let ub = UIButton(type: .system)
        ub.setImage(UIImage(named: "like"), for: .normal)
        ub.tintColor = UIColor.white
        ub.translatesAutoresizingMaskIntoConstraints = false
        ub.backgroundColor = UIColor.red
        return ub
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    func setupViews() {
        
        addSubview(thumbnailImageView)
        addSubview(userProfileImageView)
        addSubview(likeButton)
        addSubview(userNameLabel)
        addSubview(durationLabel)
        
        setupThumbnailImage()
        setupUserProfileImageView()
        setupLikeButton()
        setupUserNameLabel()
        setupDurationLabel()
        
        
    }
    
    func setupThumbnailImage() {
        thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
    }
    
    func setupUserProfileImageView() {
        userProfileImageView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8).isActive = true
        userProfileImageView.leftAnchor.constraint(equalTo: thumbnailImageView.leftAnchor, constant: 8).isActive = true
        userProfileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        userProfileImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    func setupUserNameLabel() {
        userNameLabel.topAnchor.constraint(equalTo: userProfileImageView.topAnchor).isActive = true
        userNameLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8).isActive = true
        userNameLabel.rightAnchor.constraint(equalTo: likeButton.leftAnchor, constant: -8).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupDurationLabel() {
        durationLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 2).isActive = true
        durationLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8).isActive = true
        durationLabel.rightAnchor.constraint(equalTo: likeButton.leftAnchor, constant: -8).isActive = true
        durationLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupLikeButton() {
        likeButton.topAnchor.constraint(equalTo: userProfileImageView.topAnchor).isActive = true
        likeButton.rightAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: -8).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
