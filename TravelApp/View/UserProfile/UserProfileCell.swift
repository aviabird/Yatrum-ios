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
    
    lazy var menubar: UserMenuBar = {
        let mb = UserMenuBar()
        mb.userProfileCell = self
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
        
//        fetchUserTripsFeed()
        
        setupProfileHeader()        
        setupMenuBar()
        setupCollectionView()
        
    }
    
    func scrollToMenuIndex(menuIndex: IndexPath) {
        collectionView.scrollToItem(at: menuIndex, at: [], animated: true)
    }
    
    private func setupCollectionView() {
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
            
        }
        collectionView.isPagingEnabled = true
        
        
        addSubview(collectionView)
//        collectionView.register(UserTripCell.self, forCellWithReuseIdentifier: cell)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cell)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menubar.horizontalBarLeftAnchor?.constant = scrollView.contentOffset.x / 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cell, for: indexPath)
        let colors: [UIColor] = [.blue, .yellow, .red,.green]
        cell.backgroundColor = colors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return trips?.count ?? 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cell, for: indexPath) as! UserTripCell
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: frame.width, height: 200)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }

}
