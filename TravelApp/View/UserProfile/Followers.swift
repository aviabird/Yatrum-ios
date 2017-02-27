//
//  Followers.swift
//  TravelApp
//
//  Created by Nitesh on 22/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class Followers: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
        collectionView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FollowerCell
        cell.backgroundColor = UIColor.white
        cell.user = users[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    
}

class FollowerCell: BaseCell {
    
    var user: User! {
        didSet {
            userNameLabel.text = user.name
            if let profileImageURL = user.profile_pic?.url {
                userProfileImageView.loadImageUsingUrlString(urlString: profileImageURL, width: 44)
            }
            if let totalFollowing = user.total_following, let totalFollowers = user.total_followers {
                userFollowersLabel.text = "\(totalFollowers) Followers, \(totalFollowing) Following"
            }
        }
    }
    
    
    
    let userProfileImageView: CustomImageView = {
        let ui = CustomImageView()
        ui.image = UIImage(named: "")
        ui.contentMode = .scaleAspectFill
        ui.clipsToBounds = true
        ui.layer.cornerRadius = 20
        ui.layer.masksToBounds = true
        ui.layer.borderWidth = 2
        ui.layer.borderColor = UIColor.white.cgColor
        ui.translatesAutoresizingMaskIntoConstraints = false
//                ui.backgroundColor = UIColor.red
        return ui
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 1
        label.font = label.font.withSize(15)
        label.textColor = UIColor.black
//                label.backgroundColor = UIColor.green
        return label
    }()
    
    let userFollowersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 1
        label.font = label.font.withSize(12)
        label.textColor = UIColor.black
//        label.backgroundColor = UIColor.green
        return label
    }()
    
    let followerBtn: UIButton = {
        let ub = UIButton(type: .system)
        ub.setImage(UIImage(named: "like"), for: .normal)
        ub.tintColor = UIColor.white
        ub.translatesAutoresizingMaskIntoConstraints = false
//                ub.backgroundColor = UIColor.red
        return ub
    }()
    
    override func setupViews() {
        setupUserProfileImageView()
        setupFollowerBtn()
        setupUserNameLabel()
        setUserFollowersLabel()
        
    }
    
    func setupUserProfileImageView() {
        addSubview(userProfileImageView)
        userProfileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        userProfileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        userProfileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
//        userProfileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        userProfileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    func setupUserNameLabel() {
        addSubview(userNameLabel)
        userNameLabel.topAnchor.constraint(equalTo: userProfileImageView.topAnchor).isActive = true
        userNameLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 10).isActive = true
        userNameLabel.rightAnchor.constraint(equalTo: followerBtn.leftAnchor , constant: -10).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    func setupFollowerBtn() {
        addSubview(followerBtn)
        followerBtn.topAnchor.constraint(equalTo: userProfileImageView.topAnchor).isActive = true
        followerBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        followerBtn.bottomAnchor.constraint(equalTo: userProfileImageView.bottomAnchor).isActive = true
//        followerBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        followerBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setUserFollowersLabel() {
        addSubview(userFollowersLabel)
        userFollowersLabel.bottomAnchor.constraint(equalTo: userProfileImageView.bottomAnchor).isActive = true
        userFollowersLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        userFollowersLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 10).isActive = true
        userFollowersLabel.rightAnchor.constraint(equalTo: followerBtn.leftAnchor , constant: -10).isActive = true
    }
    
    
}





