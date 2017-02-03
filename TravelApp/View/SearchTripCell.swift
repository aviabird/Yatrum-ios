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
//            durationLabel.text = "Today"
//            print(trip?.created_at)
            if let date = trip?.created_at {
                print(date)
//                print("1")
//                let dateFormatter = DateFormatter()
//                print("11")
//                dateFormatter.dateFormat = "yyyy-MM-dd"
//                print("111")
//                let dateString = dateFormatter.string(from: date as Date)
//                print("1111")
//                durationLabel.text = dateString
//                print("11111")
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateStyle = .long
//                dateFormatter.timeStyle = .long
//                let newString = dateFormatter.string(from: date as Date)
//                print(newString)
            }
            setupThumbnailImage()
            setupProfileImage()
            
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
        
        
        thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalToConstant: 186).isActive = true
        
        
        userProfileImageView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 10).isActive = true
        userProfileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        userProfileImageView.leftAnchor.constraint(equalTo: thumbnailImageView.leftAnchor, constant: 10).isActive = true
        userProfileImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        
        userNameLabel.topAnchor.constraint(equalTo: userProfileImageView.topAnchor).isActive = true
        userNameLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 10).isActive = true
        userNameLabel.rightAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: -10).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        

        durationLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 4).isActive = true
        durationLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 10).isActive = true
        durationLabel.rightAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: -10).isActive = true
        durationLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        
        
        
    }
    
    
}
