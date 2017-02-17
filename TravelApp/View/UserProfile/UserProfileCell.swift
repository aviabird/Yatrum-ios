//
//  UserProfileCell.swift
//  TravelApp
//
//  Created by Nitesh on 16/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class UserProfileCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cell = "cellId"
    
    var user: User!
    
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
    
    let menubar: UserMenuBar = {
        let mb = UserMenuBar()
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
    }()
    
    let profileHeader: UserProfileHeader = {
        let ph = UserProfileHeader()
        ph.translatesAutoresizingMaskIntoConstraints = false
        return ph
    }()
    
    override func setupViews() {
        
//        user = SharedData.sharedInstance.getCurrentUser()
        
        fetchUserTripsFeed()
        collectionView.register(UserTripCell.self, forCellWithReuseIdentifier: cell)
        setupProfileHeader()        
        setupMenuBar()
        setupCollectionView()
        
    }
    
    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: menubar.bottomAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setupProfileHeader() {
        
        addSubview(profileHeader)
        profileHeader.topAnchor.constraint(equalTo: topAnchor).isActive = true
        profileHeader.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        profileHeader.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    private func setupMenuBar() {
        
        addSubview(menubar)
        menubar.topAnchor.constraint(equalTo: profileHeader.bottomAnchor).isActive = true
        menubar.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        menubar.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trips?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cell, for: indexPath) as! UserTripCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

}
