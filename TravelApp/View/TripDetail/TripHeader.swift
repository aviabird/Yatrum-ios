//
//  TripHeader.swift
//  TravelApp
//
//  Created by rawat on 04/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit
import ReSwift

class TripHeader: UIView, StoreSubscriber {
    var tripDetail: TripDetail?
    
    var trip: Trip? {
        didSet {
            titleLabel.text = trip?.name
            userNameLabel.text = trip?.user?.name
            
            setupThumbnailImage()
            setupProfileImage()
            
            if let numberOfLikes = trip?.trip_likes_count {
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                let subtitleText = "\(numberFormatter.string(from: numberOfLikes)!) Likes, Posted 2 hour ago"
                userNameSubTitle.text = subtitleText
            }
        }
    }
    
    func hideAll() {
        titleLabel.isHidden = true
        userNameLabel.isHidden = true
        userProfileImageView.isHidden = true
        userNameSubTitle.isHidden = true
        thumbnailImageView.alpha = 0.3
    }
    
    func showAll() {
        titleLabel.isHidden = false
        userNameLabel.isHidden = false
        thumbnailImageView.isHidden = false
        userProfileImageView.isHidden = false
        userNameSubTitle.isHidden = false
        thumbnailImageView.alpha = 0.5
    }
    
    func newState(state: AppState) {
        trip = state.tripState.selectedTrip()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.black
        
        store.subscribe(self)
        
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
        imageView.alpha = 0.5
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
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 1
        label.font = label.font.withSize(20)
        label.textColor = UIColor.white
        return label
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 1
        label.font = label.font.withSize(16)
        label.textColor = UIColor.white
        return label
    }()
    
    let userNameSubTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 1
        label.font = label.font.withSize(14)
        label.textColor = UIColor.white
        return label
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
        addSubview(titleLabel)
        addSubview(userNameLabel)
        addSubview(userNameSubTitle)
        
        thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        userProfileImageView.bottomAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: -10).isActive = true
        userProfileImageView.leftAnchor.constraint(equalTo: thumbnailImageView.leftAnchor, constant: 10).isActive = true
        userProfileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        userProfileImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        closeButton.topAnchor.constraint(equalTo: thumbnailImageView.topAnchor, constant: 20).isActive = true
        closeButton.leftAnchor.constraint(equalTo: thumbnailImageView.leftAnchor, constant: 20).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        userNameLabel.topAnchor.constraint(equalTo: userProfileImageView.topAnchor).isActive = true
        userNameLabel.leftAnchor.constraint(equalTo: thumbnailImageView.leftAnchor, constant: 60).isActive = true
        userNameLabel.rightAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: -10).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        userNameSubTitle.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 2).isActive = true
        userNameSubTitle.leftAnchor.constraint(equalTo: thumbnailImageView.leftAnchor, constant: 60).isActive = true
        userNameSubTitle.rightAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: -10).isActive = true
        userNameSubTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
