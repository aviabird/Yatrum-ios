//
//  UserProfileHeader.swift
//  TravelApp
//
//  Created by Nitesh on 16/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class UserProfileHeader: UIView {
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0.5
        return imageView
    }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.backgroundColor = UIColor.red
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 1
        label.font = label.font.withSize(15)
        label.textAlignment = .center
        label.textColor = UIColor.white
//        label.backgroundColor = UIColor.green
        return label
    }()
    
    let userNameSubTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Developer Pune"
        label.numberOfLines = 1
        label.font = label.font.withSize(12)
        label.textColor = UIColor.white
        label.textAlignment = .center
//        label.backgroundColor = UIColor.gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.appBaseColor()
        
        setupViews()
        
        
    }
    
    func setupViews() {

        setupThumbnailImage()
    }
    
    func setupThumbnailImage() {
        addSubview(thumbnailImageView)
        thumbnailImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        setupUserProfileImageView()
        setupUsernameLabel()
        setupUserNameSubTitle()
    }
    
    func setupUserProfileImageView() {
        addSubview(userProfileImageView)
        userProfileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        userProfileImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        userProfileImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        userProfileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    
    }
    
    func setupUsernameLabel() {
        addSubview(userNameLabel)
        userNameLabel.topAnchor.constraint(equalTo: userProfileImageView.bottomAnchor, constant: 8).isActive = true
        userNameLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -30).isActive = true
        userNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    func setupUserNameSubTitle() {
        addSubview(userNameSubTitle)
        userNameSubTitle.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8).isActive = true
        userNameSubTitle.widthAnchor.constraint(equalTo: widthAnchor, constant: -20).isActive = true
        userNameSubTitle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        userNameSubTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
