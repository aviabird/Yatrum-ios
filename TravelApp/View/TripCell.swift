//
//  VideoCell.swift
//  YoutubeClone
//
//  Created by Pankaj Rawat on 20/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//
import UIKit

class TripCell:  BaseCell  {
    
    var user: User!
    
    var trip: Trip! {
        didSet {
            
            user = trip.user
            titleLabel.text = "\(user.name!)"
            
            setupThumbnailImage()
            
            setupProfileImage()
            
            if let numberOfLikes = trip.trip_likes_count {
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                tripStatusLabel.text = "\(numberFormatter.string(from: numberOfLikes)!) Likes"
            }
            
            subTitleLabel.text = trip.created_at?.humanizeDate().relativeDate()
            
            // measure Title text
            if let title = trip.name {
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
            
            if user.is_followed_by_current_user {
                self.followButton.backgroundColor = UIColor.appCallToActionColor()
                self.followButton.setTitle("Following", for: .normal)
                self.followButton.setTitleColor(UIColor.white, for: .normal)
            } else {
                self.followButton.backgroundColor = UIColor.white
                self.followButton.setTitle("Follow", for: .normal)
                self.followButton.setTitleColor(UIColor.appCallToActionColor(), for: .normal)
            }
            
            likeButton.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
            
            if trip.is_liked_by_current_user {
                likeButton.setImage(UIImage(named: "like-filled"), for: .normal)
                likeButton.tintColor = UIColor.appCallToActionColor()
            } else {
                likeButton.setImage(UIImage(named: "like"), for: .normal)
                likeButton.tintColor = UIColor.gray
            }
            
        }
        
    }
    
    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = trip.thumbnail_image_url {
            thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl, width: Float(frame.width))
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(showTripDetail))
        thumbnailImageView.isUserInteractionEnabled = true
        thumbnailImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func showTripDetail() {
        let tripDetail = TripDetail()
        store.dispatch(SelectTrip(tripId: trip.id!))
        tripDetail.showTripDetai()
    }
    
    func setupProfileImage() {
        if let profileImageURL = user.profile_pic?.url {
            userProfileImageView.loadImageUsingUrlString(urlString: profileImageURL, width: 44)
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
    
    let tripStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 1
        label.font = label.font.withSize(12)
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.appMainBGColor()
        return view
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
        button.layer.borderColor = UIColor.appCallToActionColor().cgColor
        button.layer.borderWidth = 1
        button.setTitle("Follow", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.setTitleColor(UIColor.appCallToActionColor(), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        return button
    }()
    
    func handleFollow() {
        user.is_followed_by_current_user = !user.is_followed_by_current_user
        
        toggleFollow()
        
        UserService.sharedInstance.followUser(followedId: (trip.user_id)!) { (user: User) in
            
            guard user.is_followed_by_current_user != self.user.is_followed_by_current_user else {
                return
            }

            self.toggleFollow()
        }
    }
    
    func toggleFollow() {
        UIView.animate(withDuration: 0.5) {
            if self.user.is_followed_by_current_user {
                self.followButton.backgroundColor = UIColor.appCallToActionColor()
                self.followButton.setTitle("Following", for: .normal)
                self.followButton.setTitleColor(UIColor.white, for: .normal)
            } else {
                self.followButton.backgroundColor = UIColor.white
                self.followButton.setTitle("Follow", for: .normal)
                self.followButton.setTitleColor(UIColor.appCallToActionColor(), for: .normal)
            }
        }
    }
    
    func handleLike(firstChange: Bool) {
        trip.is_liked_by_current_user = !trip.is_liked_by_current_user
        self.likeButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        toggleLike()
        
        TripService.sharedInstance.likeTrip(tripId: (trip.id)!) { (trip: Trip) in
            guard trip.is_liked_by_current_user != self.trip.is_liked_by_current_user else {
                return
            }
            
            self.toggleLike()
        }
    }
    
    func toggleLike() {
        UIView.animate(withDuration: 0.5, animations: {
            self.likeButton.transform = CGAffineTransform.identity
            if self.trip.is_liked_by_current_user {
                self.likeButton.setImage(UIImage(named: "like-filled"), for: .normal)
                self.likeButton.tintColor = UIColor.appCallToActionColor()
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
        addSubview(tripStatusLabel)
        addSubview(separatorView)
        addSubview(likeButton)
        addSubview(followButton)
        
        setupThumbnailImageViews()
        
        userProfileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        userProfileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        userProfileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        userProfileImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        thumbnailImageView.topAnchor.constraint(equalTo: userProfileImageView.bottomAnchor, constant: 16).isActive = true
        thumbnailImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        thumbnailImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        thumbnailImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80).isActive = true
        
        followButton.rightAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: -16).isActive = true
        followButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        followButton.topAnchor.constraint(equalTo: userProfileImageView.topAnchor, constant: 7).isActive = true
        followButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        //top constraint
        titleLabel.topAnchor.constraint(equalTo: userProfileImageView.topAnchor).isActive = true
        // left constraint
        titleLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8).isActive = true
        //right constraint
        titleLabel.rightAnchor.constraint(equalTo: followButton.leftAnchor, constant: -5).isActive = true
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
        
        likeButton.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 2).isActive = true
        likeButton.leftAnchor.constraint(equalTo: thumbnailImageView.leftAnchor, constant: 16).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        separatorView.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 2).isActive = true
        separatorView.widthAnchor.constraint(equalTo: thumbnailImageView.widthAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        tripStatusLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 10).isActive = true
        tripStatusLabel.leftAnchor.constraint(equalTo: likeButton.leftAnchor).isActive = true
        tripStatusLabel.widthAnchor.constraint(equalTo: thumbnailImageView.widthAnchor, constant: -32).isActive = true
        tripStatusLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
    }
    
    func setupThumbnailImageViews() {
    }
}
