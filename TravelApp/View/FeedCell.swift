//
//  FeedCell.swift
//  TravelApp
//
//  Created by rawat on 29/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit
import ReSwift

class FeedCell: BaseCell, UICollectionViewDataSource,  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, StoreSubscriber {
    
    lazy var  collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "cellId"
    var trips: [Trip]?
    
    func fetchTripsFeed() {
        store.dispatch(FetchTripsFeed)
    }
    
    func newState(state: AppState) {
        trips = state.tripState.feedTrips()
        collectionView.reloadData()
    }

    override func setupViews() {
        super.setupViews()
        
        store.subscribe(self)
        
        fetchTripsFeed()
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(TripCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trips?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! TripCell
        cell.trip = trips?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height * 0.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tripDetail = TripDetail()
        tripDetail.trip = (trips?[indexPath.item])!
        tripDetail.showTripDetai()
    }

}
