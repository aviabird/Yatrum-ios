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
    
    var user: User!
    
    var trip: Trip! {
        didSet {
            
            user = trip.user
            
            titleLabel.text = trip.name
            scrollTitleLabel.text = trip.name
            userNameLabel.text = user.name
            postedAtTitleLabel.text = "posted 10 hours ago"
            
            setupThumbnailImage()
            setupProfileImage()
            
            if let totalFollowing = user.total_following, let totalFollowers = user.total_followers {
                userNameSubTitle.text = "\(totalFollowers) Followers, \(totalFollowing) Following"
            }
            
            likeButton.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
            
            if (trip?.is_liked_by_current_user)! {
                likeButton.setImage(UIImage(named: "like-filled"), for: .normal)
                likeButton.tintColor = UIColor.callToActionColor()
            }
        }
    }
    
    func hideAll() {
        thumbnailImageView.frame = CGRect(x: 0, y: 0, width: thumbnailImageView.frame.width, height: 50)
        likeButton.frame = CGRect(x: likeButton.frame.minX, y: 16, width: likeButton.frame.width, height: likeButton.frame.height)
        titleLabel.isHidden = true
        scrollTitleLabel.alpha = 1
        userNameLabel.isHidden = true
        userProfileImageView.isHidden = true
        userNameSubTitle.isHidden = true
        thumbnailImageView.alpha = 0.3
        postedAtTitleLabel.isHidden = true
    }
    
    func showAll() {
        thumbnailImageView.frame = CGRect(x: 0, y: 0, width: thumbnailImageView.frame.width, height: frame.height)
        likeButton.frame = CGRect(x: likeButton.frame.minX, y: frame.height - 50, width: likeButton.frame.width, height: likeButton.frame.height)
        titleLabel.isHidden = false
        scrollTitleLabel.alpha = 0
        userNameLabel.isHidden = false
        thumbnailImageView.isHidden = false
        userProfileImageView.isHidden = false
        userNameSubTitle.isHidden = false
        thumbnailImageView.alpha = 0.5
        postedAtTitleLabel.isHidden = false
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
        if let thumbnailImageUrl = trip.thumbnail_image_url {
            thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl, width: Float(frame.width))
        }
    }
    
    func setupProfileImage() {
        if let profileImageURL = trip.user?.profile_pic?.url {
            userProfileImageView.loadImageUsingUrlString(urlString: profileImageURL, width: 44)
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
    
    let scrollTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 2
        label.font = label.font.withSize(12)
        label.textColor = UIColor.white
        label.alpha = 0
        label.textAlignment = .center
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 2
        label.font = label.font.withSize(20)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    let postedAtTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 2
        label.font = label.font.withSize(10)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 1
        label.font = label.font.withSize(15)
        label.textColor = UIColor.white
        return label
    }()
    
    let userNameSubTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 1
        label.font = label.font.withSize(12)
        label.textColor = UIColor.white
        return label
    }()
    
    let likeButton: UIButton = {
        let ub = UIButton(type: .system)
        ub.setImage(UIImage(named: "like"), for: .normal)
        ub.tintColor = UIColor.white
        ub.translatesAutoresizingMaskIntoConstraints = false
        return ub
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
    
    func handleCloseView() {
        tripDetail?.closeView()
    }
    
    func handleLike(firstChange: Bool) {
        trip?.is_liked_by_current_user = !(trip?.is_liked_by_current_user)!
        self.likeButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        toggleLike()
        
        TripService.sharedInstance.likeTrip(tripId: (trip?.id)!) { (trip: Trip) in
            guard trip.is_liked_by_current_user != self.trip?.is_liked_by_current_user else {
                return
            }
            
            self.trip = trip
            self.toggleLike()
        }
    }
    
    func toggleLike() {
        UIView.animate(withDuration: 0.5, animations: {
            self.likeButton.transform = CGAffineTransform.identity
            if (self.trip?.is_liked_by_current_user)! {
                self.likeButton.setImage(UIImage(named: "like-filled"), for: .normal)
                self.likeButton.tintColor = UIColor.callToActionColor()
            } else {
                self.likeButton.setImage(UIImage(named: "like"), for: .normal)
                self.likeButton.tintColor = UIColor.white
            }
        })
    }
    
    func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(userProfileImageView)
        addSubview(closeButton)
        addSubview(titleLabel)
        addSubview(postedAtTitleLabel)
        addSubview(userNameLabel)
        addSubview(userNameSubTitle)
        addSubview(scrollTitleLabel)
        addSubview(likeButton)
        
        thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        scrollTitleLabel.centerYAnchor.constraint(equalTo: thumbnailImageView.centerYAnchor, constant: 10).isActive = true
        scrollTitleLabel.leftAnchor.constraint(equalTo: thumbnailImageView.leftAnchor, constant: 50).isActive = true
        scrollTitleLabel.widthAnchor.constraint(equalTo: thumbnailImageView.widthAnchor, constant: -100).isActive = true
        
        userProfileImageView.bottomAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: -10).isActive = true
        userProfileImageView.leftAnchor.constraint(equalTo: thumbnailImageView.leftAnchor, constant: 10).isActive = true
        userProfileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        userProfileImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        closeButton.topAnchor.constraint(equalTo: thumbnailImageView.topAnchor, constant: 10).isActive = true
        closeButton.leftAnchor.constraint(equalTo: thumbnailImageView.leftAnchor, constant: 20).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        titleLabel.widthAnchor.constraint(equalTo: thumbnailImageView.widthAnchor, constant: -20).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: thumbnailImageView.centerYAnchor, constant: -20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: thumbnailImageView.centerXAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        postedAtTitleLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
        postedAtTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        postedAtTitleLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        userNameLabel.topAnchor.constraint(equalTo: userProfileImageView.topAnchor).isActive = true
        userNameLabel.leftAnchor.constraint(equalTo: thumbnailImageView.leftAnchor, constant: 60).isActive = true
        userNameLabel.rightAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: -10).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        userNameSubTitle.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 2).isActive = true
        userNameSubTitle.leftAnchor.constraint(equalTo: thumbnailImageView.leftAnchor, constant: 60).isActive = true
        userNameSubTitle.rightAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: -10).isActive = true
        userNameSubTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        likeButton.centerYAnchor.constraint(equalTo: userProfileImageView.centerYAnchor).isActive = true
        likeButton.rightAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: -10).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
