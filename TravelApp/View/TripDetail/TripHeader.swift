//
//  TripHeader.swift
//  TravelApp
//
//  Created by rawat on 04/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class TripHeader: UIView {
    var tripDetail: TripDetail?
    
    var trip: Trip? {
        didSet {
            setupThumbnailImage()
            setupProfileImage()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.black
        
        setupViews()
    }
    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = trip?.thumbnail_image_url {
            thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
        }
    }
    
    func setupProfileImage() {
        if let profileImageURL = trip?.user?.profile_pic?.url {
            userProfileImageView.loadImageUsingUrlString(urlString: profileImageURL)
        }
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let closeButton: UIButton = {
        let ub = UIButton(type: .system)
        ub.setImage(UIImage(named: "minimize"), for: .normal)
        ub.tintColor = UIColor.white
        ub.layer.shadowOpacity = 0.5
        ub.layer.shadowRadius = 3
        ub.layer.shadowOffset = CGSize(width: 0, height: 2)
        ub.layer.shadowColor = UIColor.darkGray.cgColor
        ub.translatesAutoresizingMaskIntoConstraints = false
        ub.addTarget(self, action: #selector(handleCloseView), for: .touchUpInside)
        return ub
    }()
    
    let likeButton: UIButton = {
        let ub = UIButton(type: .system)
        ub.setImage(UIImage(named: "like"), for: .normal)
        ub.tintColor = UIColor.gray
        ub.translatesAutoresizingMaskIntoConstraints = false
        return ub
    }()
    
    func handleCloseView() {
        tripDetail?.closeView()
    }
    
    func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(userProfileImageView)
        addSubview(closeButton)
        
        thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        userProfileImageView.bottomAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: -10).isActive = true
        userProfileImageView.leftAnchor.constraint(equalTo: thumbnailImageView.leftAnchor, constant: 10).isActive = true
        userProfileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        userProfileImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        closeButton.topAnchor.constraint(equalTo: thumbnailImageView.topAnchor, constant: 20).isActive = true
        closeButton.leftAnchor.constraint(equalTo: thumbnailImageView.leftAnchor, constant: 5).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
