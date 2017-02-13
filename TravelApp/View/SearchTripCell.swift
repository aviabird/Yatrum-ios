//
//  SearchTripCell.swift
//  TravelApp
//
//  Created by Nitesh on 03/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class SearchTripCell: BaseCell {

    var trip: Trip? {
        didSet {
            print(trip!)
            
            userNameLabel.text = trip?.user?.name
            durationLabel.text = trip?.created_at?.relativeDate()
            setupThumbnailImage()
            setupProfileImage()
        }
        
    }
    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = trip?.thumbnail_image_url {
            thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl, width: Float(thumbnailImageView.frame.width))
        }
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(showTripDetail))
        thumbnailImageView.isUserInteractionEnabled = true
        thumbnailImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func showTripDetail() {
        let tripDetailViewCtrl = TripDetailViewController()
        store.dispatch(SelectTrip(tripId: (trip?.id!)!))
        SharedData.sharedInstance.homeController?.present(tripDetailViewCtrl, animated: true, completion: nil)
    }

    func setupProfileImage() {
        if let profileImageURL = trip?.user?.profile_pic?.url {
            userProfileImageView.loadImageUsingUrlString(urlString: profileImageURL, width: Float(userProfileImageView.frame.width))
        }
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "")
//        imageView.backgroundColor = UIColor.red
        return imageView
    }()
    
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
//        imageView.backgroundColor = UIColor.blue
        return imageView
    }()
    
    let likeButton: UIButton = {
        let ub = UIButton(type: .system)
        ub.setImage(UIImage(named: "like"), for: .normal)
        ub.tintColor = UIColor.gray
        ub.translatesAutoresizingMaskIntoConstraints = false
//        ub.backgroundColor = UIColor.red
        return ub
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 1
        label.font = label.font.withSize(12)
//        label.backgroundColor = UIColor.green
        return label
    }()

    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 1
//        label.backgroundColor = UIColor.yellow
        label.font = label.font.withSize(10)
        return label
    }()

    
    override func setupViews() {
        
        addSubview(thumbnailImageView)
        addSubview(userProfileImageView)
        addSubview(userNameLabel)
        addSubview(durationLabel)
        addSubview(likeButton)
        
        
        thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalToConstant: 186).isActive = true
        
        
        userProfileImageView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 10).isActive = true
        userProfileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        userProfileImageView.leftAnchor.constraint(equalTo: thumbnailImageView.leftAnchor, constant: 10).isActive = true
        userProfileImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        
        userNameLabel.topAnchor.constraint(equalTo: userProfileImageView.topAnchor).isActive = true
        userNameLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 10).isActive = true
        userNameLabel.rightAnchor.constraint(equalTo: likeButton.leftAnchor, constant: -10).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        durationLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 4).isActive = true
        durationLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 10).isActive = true
        durationLabel.rightAnchor.constraint(equalTo: likeButton.leftAnchor, constant: -10).isActive = true
        durationLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        likeButton.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 10).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        likeButton.rightAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: -10).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
                        
        
    }
    
    
}
