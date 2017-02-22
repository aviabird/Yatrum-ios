//
//  UserFeed.swift
//  TravelApp
//
//  Created by Nitesh on 22/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class UserFeed: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let userTripCell = "userTripCellId"
    
    var trips: [Trip]?
    
    func fetchUserTripsFeed() {
        TripService.sharedInstance.fetchTripsFeed { (trips: [Trip]) in
            DispatchQueue.main.async {
                self.trips = trips
                self.collectionView.reloadData()
            }
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect.init(), collectionViewLayout: layout)
        cv.backgroundColor = UIColor.appMainBGColor()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override func setupViews() {
        setupCollectionView()
        fetchUserTripsFeed()
    }
    
    private func setupCollectionView() {
        
        addSubview(collectionView)
        
        collectionView.register(UserTripCell.self,forCellWithReuseIdentifier: userTripCell)
        collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
        collectionView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trips?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: userTripCell, for: indexPath) as! UserTripCell
        cell.trip = trips?[indexPath.item]
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}
