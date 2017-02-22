//
//  UserTripCell.swift
//  TravelApp
//
//  Created by Nitesh on 14/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class UserTripCell: UICollectionViewCell {
    
    var user: User!
    
    var trip: Trip! {
        didSet {
            
            user = trip.user
            userNameLabel.text = user.name
            durationLabel.text = trip.created_at?.relativeDate()
            
            setupThumbnailImage()
            
            setupUserProfileImageView()

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

    let thumbnailImageView: CustomImageView = {
        let ti = CustomImageView()
        ti.contentMode = .scaleAspectFill
        ti.clipsToBounds = true
        ti.image = UIImage(named: "")
        ti.translatesAutoresizingMaskIntoConstraints = false
//        ti.backgroundColor = UIColor.blue
        return ti
    }()
    
    let userProfileImageView: CustomImageView = {
        let ui = CustomImageView()
        ui.image = UIImage(named: "")
        ui.contentMode = .scaleAspectFill
        ui.clipsToBounds = true
        ui.layer.cornerRadius = 22
        ui.layer.masksToBounds = true
        ui.layer.borderWidth = 2
        ui.layer.borderColor = UIColor.white.cgColor
        ui.translatesAutoresizingMaskIntoConstraints = false
//        ui.backgroundColor = UIColor.red
        return ui
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 1
        label.font = label.font.withSize(15)
        label.textColor = UIColor.black
//        label.backgroundColor = UIColor.green
        return label
    }()
    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 1
        label.font = label.font.withSize(12)
        label.textColor = UIColor.black
//        label.backgroundColor = UIColor.yellow
        return label
    }()
    
    let likeButton: UIButton = {
        let ub = UIButton(type: .system)
        ub.setImage(UIImage(named: "like"), for: .normal)
        ub.tintColor = UIColor.white
        ub.translatesAutoresizingMaskIntoConstraints = false
//        ub.backgroundColor = UIColor.red
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
        
//        setupThumbnailImage()
//        setupUserProfileImageView()
        setupLikeButton()
        setupUserNameLabel()
        setupDurationLabel()
        
        
    }
    
    func showTripDetail() {
        let tripDetailViewCtrl = TripDetailViewController()
        store.dispatch(SelectTrip(tripId: trip.id!))
        SharedData.sharedInstance.homeController?.present(tripDetailViewCtrl, animated: true, completion: nil)
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
    
    func setupThumbnailImage() {
        thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        if let thumbnailImageUrl = trip.thumbnail_image_url {
            thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl, width: Float(frame.width))
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(showTripDetail))
        thumbnailImageView.isUserInteractionEnabled = true
        thumbnailImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setupUserProfileImageView() {
        userProfileImageView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8).isActive = true
        userProfileImageView.leftAnchor.constraint(equalTo: thumbnailImageView.leftAnchor, constant: 8).isActive = true
        userProfileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        userProfileImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        if let profileImageURL = user.profile_pic?.url {
            userProfileImageView.loadImageUsingUrlString(urlString: profileImageURL, width: 44)
        }
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
