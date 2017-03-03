//
//  NotificationCell.swift
//  TravelApp
//
//  Created by Nitesh on 03/03/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class NotificationCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "CellId"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect.init(), collectionViewLayout: layout)
        cv.backgroundColor = UIColor.appMainBGColor()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var users = [User]()
    
    func fetchUserFollowers() {
        
        UserService.sharedInstance.fetchUserFollowers(userId: sharedData.currentUser.id!) { (users: [User]) in
            
            DispatchQueue.main.async {
                self.users = users
                self.collectionView.reloadData()
            }
        }
    }
    
    override func setupViews() {
        fetchUserFollowers()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.register(NotifyCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NotifyCell
        cell.backgroundColor = UIColor.white
        cell.user = users[indexPath.item]
//        cell.layer.shadowOpacity = 0.5
//        cell.layer.shadowRadius = 2
//        cell.layer.shadowOffset = CGSize(width: 0, height: 1)
//        cell.layer.shadowColor = UIColor.black.cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }    
}

class NotifyCell: BaseCell {
    
    var user: User! {
        didSet {
            if let username = user.name {
                notificationLabel.text = "\(username) is now following you"
            }
            
            if let profileImageURL = user.profile_pic?.url {
                userImage.loadImageUsingUrlString(urlString: profileImageURL, width: 44)
            }
            
            followButton.addTarget(self, action: #selector(handleFollow), for: .touchUpInside)
        }
    }
    
    func handleFollow() {
        user.is_followed_by_current_user = !user.is_followed_by_current_user
        
        toggleFollow()
        
        UserService.sharedInstance.followUser(followedId: (user.id)!) { (user: User) in
            
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

    
    let userImage: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let notificationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 2
        label.font = label.font.withSize(12)
        label.textColor = UIColor.black
        return label
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
    
    override func setupViews() {
        setupUserImage()
        setupFollowButton()
        setupNotificationLabel()
    }
    
    func setupUserImage() {
        addSubview(userImage)
        userImage.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        userImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    func setupNotificationLabel() {
        addSubview(notificationLabel)
        notificationLabel.topAnchor.constraint(equalTo: userImage.topAnchor).isActive = true
        notificationLabel.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 10).isActive = true
        notificationLabel.rightAnchor.constraint(equalTo: followButton.leftAnchor , constant: -10).isActive = true
        notificationLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    
    func setupFollowButton() {
        addSubview(followButton)
        followButton.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        followButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        followButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        followButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
}

