//
//  TripDetail.swift
//  TravelApp
//
//  Created by rawat on 04/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class TripDetail: NSObject {
    
    var trip: Trip? {
        didSet {
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
        print("here")
    }
    
    
    func showTripDetai() {
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.rgb(red: 245, green: 245, blue: 245)
            
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            keyWindow.addSubview(view)
            
            addSubViews(view: view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                view.frame = keyWindow.frame
            }, completion: { (completedAnimation) in
                UIApplication.shared.isStatusBarHidden = true
            })
        }
    }
    
    
    
    func addSubViews(view: UIView) {
        view.addSubview(thumbnailImageView)
        view.addSubview(userProfileImageView)
        view.addSubview(closeButton)
        
        closeButton.addTarget(self, action: #selector(handleCloseView), for: .touchUpInside)
        
        thumbnailImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        userProfileImageView.bottomAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: -10).isActive = true
        userProfileImageView.leftAnchor.constraint(equalTo: thumbnailImageView.leftAnchor, constant: 10).isActive = true
        userProfileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        userProfileImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        closeButton.topAnchor.constraint(equalTo: thumbnailImageView.topAnchor, constant: 20).isActive = true
        closeButton.leftAnchor.constraint(equalTo: thumbnailImageView.leftAnchor, constant: 5).isActive = true
    }
    
}
