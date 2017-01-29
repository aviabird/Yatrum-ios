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
            titleLabel.text = trip?.title
            
            setupThumbnailImage()
            
            setupProfileImage()
            
            if let userName = trip?.user?.name, let numberOfLikes = trip?.numberOfLikes {
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                let subtitleText = "\(userName) • \(numberFormatter.string(from: numberOfLikes)!) • 2 hour ago"
                subTitleTextView.text = subtitleText
            }
            
            // measure Title text
            if let title = trip?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16 , height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }
            }
            
            if (trip?.isLikedByCurrentUser)! {
                likeImageView.tintColor = UIColor.appSecondaryColor()
            }
            
            followButton.addTarget(self, action: #selector(handleFollow), for: .touchUpInside)
            handleFollow()
            
        }
        
    }
    
    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = trip?.thumbnailImageURL {
            thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
        }
    }
    
    func setupProfileImage() {
        if let profileImageURL = trip?.user?.profileImageURL {
            userProfileImageView.loadImageUsingUrlString(urlString: profileImageURL)
        }
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "")
        return imageView
    }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
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
        label.font = label.font.withSize(12)
        return label
    }()
    
    let subTitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = ""
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.gray
        return textView
    }()
    
    let likeImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "like")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.white
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let followButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        button.layer.borderColor = UIColor.appBaseColor().cgColor
        button.layer.borderWidth = 1
        button.setTitle("Follow", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.setTitleColor(UIColor.appBaseColor(), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        return button
    }()
    
    func handleFollow() {
        UIView.animate(withDuration: 0.5) {
            if (self.trip?.user?.isFollowedByCurrentUser)! {
                self.followButton.backgroundColor = UIColor.appSecondaryColor()
                self.followButton.layer.borderColor = UIColor.appSecondaryColor().cgColor
                self.followButton.setTitle("Following", for: .normal)
                self.followButton.setTitleColor(UIColor.white, for: .normal)
            } else {
                self.followButton.backgroundColor = UIColor.white
                self.followButton.layer.borderColor = UIColor.appBaseColor().cgColor
                self.followButton.setTitle("Follow", for: .normal)
                self.followButton.setTitleColor(UIColor.appBaseColor(), for: .normal)
            }
        }
    }
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    override func setupViews() {
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subTitleTextView)
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(likeImageView)
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
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute:  .top, relatedBy: .equal, toItem: titleLabel , attribute: .bottom, multiplier: 1, constant: 4 ))
        // left constraint
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .right , relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        // hight Constraint
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
        likeImageView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 5).isActive = true
        likeImageView.leftAnchor.constraint(equalTo: thumbnailImageView.leftAnchor, constant: 5).isActive = true
        likeImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        likeImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        followButton.leftAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        followButton.rightAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: -16).isActive = true
        followButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        followButton.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        
    }
    
    func setupThumbnailImageViews() {
    }
}
