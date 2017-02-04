//
//  VideoCell.swift
//  YoutubeClone
//
//  Created by Pankaj Rawat on 20/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//
import UIKit

class TripCell:  BaseCell  {
    
    var trip: Trip? {
        didSet {
            titleLabel.text = trip?.name
            
            setupThumbnailImage()
            
            setupProfileImage()
            
            if let userName = trip?.user?.name, let numberOfLikes = trip?.trip_likes_count {
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                let subtitleText = "\(userName) • \(numberFormatter.string(from: numberOfLikes)!) • 2 hour ago"
                subTitleLabel.text = subtitleText
            }
            
            // measure Title text
            if let title = trip?.name {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16 , height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }
            }
            
            followButton.addTarget(self, action: #selector(handleFollow), for: .touchUpInside)
            if (trip?.user?.is_followed_by_current_user)! {
                self.followButton.backgroundColor = UIColor.appSecondaryColor()
                self.followButton.setTitle("Following", for: .normal)
                self.followButton.setTitleColor(UIColor.white, for: .normal)
            }
            
            if SharedData.sharedInstance.getCurrentUser()?.id == trip?.user_id {
                self.followButton.isHidden = true
            }
            
            likeButton.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
            
            if (trip?.is_liked_by_current_user)! {
                likeButton.setImage(UIImage(named: "like-filled"), for: .normal)
                likeButton.tintColor = UIColor.appSecondaryColor()
            }
            
        }
        
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 1
        label.font = label.font.withSize(14)
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 1
        label.font = label.font.withSize(12)
        return label
    }()
    
    let likeButton: UIButton = {
        let ub = UIButton(type: .system)
        ub.setImage(UIImage(named: "like"), for: .normal)
        ub.tintColor = UIColor.gray
        ub.translatesAutoresizingMaskIntoConstraints = false
        return ub
    }()
    
    let followButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        button.layer.borderColor = UIColor.appSecondaryColor().cgColor
        button.layer.borderWidth = 1
        button.setTitle("Follow", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.setTitleColor(UIColor.appSecondaryColor(), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        return button
    }()
    
    func handleFollow() {
        trip?.user?.is_followed_by_current_user = !(self.trip?.user?.is_followed_by_current_user)!
        
        toggleFollow()
        
        UserService.sharedInstance.followUser(followedId: (trip?.user_id)!) { (user: User) in
            
            guard user.is_followed_by_current_user != self.trip?.user?.is_followed_by_current_user else {
                return
            }
            
            self.trip?.user = user
            self.toggleFollow()
            store.dispatch(UpdateTrips(trips: [self.trip!]))
        }
    }
    
    func toggleFollow() {
        UIView.animate(withDuration: 0.5) {
            if (self.trip?.user?.is_followed_by_current_user)! {
                self.followButton.backgroundColor = UIColor.appSecondaryColor()
                self.followButton.setTitle("Following", for: .normal)
                self.followButton.setTitleColor(UIColor.white, for: .normal)
            } else {
                self.followButton.backgroundColor = UIColor.white
                self.followButton.setTitle("Follow", for: .normal)
                self.followButton.setTitleColor(UIColor.appSecondaryColor(), for: .normal)
            }
        }
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
                self.likeButton.tintColor = UIColor.appSecondaryColor()
            } else {
                self.likeButton.setImage(UIImage(named: "like"), for: .normal)
                self.likeButton.tintColor = UIColor.gray
            }
        })
    }
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    override func setupViews() {
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(likeButton)
        addSubview(followButton)
        
        setupThumbnailImageViews()
        
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        
        //vertical constrain
        addConstraintsWithFormat(format: "V:|-16-[v0(44)]-19-[v1]-40-[v2(1)]-16-|", views: userProfileImageView, thumbnailImageView, separatorView)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute:  .top, relatedBy: .equal, toItem: userProfileImageView , attribute: .top, multiplier: 1, constant: 0 ))
        // left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right , relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: -80))
        // hight Constraint
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 22)
        addConstraint(titleLabelHeightConstraint!)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: subTitleLabel, attribute:  .top, relatedBy: .equal, toItem: titleLabel , attribute: .bottom, multiplier: 1, constant: 0 ))
        // left constraint
        addConstraint(NSLayoutConstraint(item: subTitleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: subTitleLabel, attribute: .right , relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: -80))
        // hight Constraint
        addConstraint(NSLayoutConstraint(item: subTitleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
        likeButton.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 5).isActive = true
        likeButton.leftAnchor.constraint(equalTo: thumbnailImageView.leftAnchor, constant: 16).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        followButton.leftAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        followButton.rightAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: -16).isActive = true
        followButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        followButton.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        
    }
    
    func setupThumbnailImageViews() {
    }
}
