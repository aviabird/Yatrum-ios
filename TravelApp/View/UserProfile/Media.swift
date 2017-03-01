//
//  Media.swift
//  TravelApp
//
//  Created by Nitesh on 23/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class Media: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
    
    var pictures = [Picture]()
    
    func fetchUserMedia() {
        
        UserService.sharedInstance.fetchUserMediaImages(userId: sharedData.currentUser.id!) { (pictures: [Picture]) in
            DispatchQueue.main.async {
                self.pictures = pictures
                self.collectionView.reloadData()
            }
        }
    }

    
    
    
    
    override func setupViews() {
        fetchUserMedia()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.register(MediaCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
        collectionView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(pictures.count)
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MediaCell
//        cell.backgroundColor = UIColor.white
        cell.picture = pictures[indexPath.item]
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 2
        cell.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell.layer.shadowColor = UIColor.black.cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 175)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }        
}

class MediaCell: BaseCell {
    
    var picture: Picture! {
        didSet {
            if let profileImageURL = picture.url {
                thumbnailImageView.loadImageUsingUrlString(urlString: profileImageURL, width: Float(frame.width))
            }
        }
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "")
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.backgroundColor = UIColor.red
        return imageView
    }()
    
    override func setupViews() {
        setupThumbnailImageView()
    }
    
    func setupThumbnailImageView() {
        addSubview(thumbnailImageView)
        thumbnailImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        thumbnailImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        thumbnailImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        thumbnailImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
}

