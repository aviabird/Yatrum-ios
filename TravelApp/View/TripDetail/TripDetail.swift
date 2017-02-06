//
//  TripDetail.swift
//  TravelApp
//
//  Created by rawat on 04/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit
import ReSwift

class TripDetail: NSObject, UICollectionViewDataSource,  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, StoreSubscriber {
    
    var trip: Trip?
    
    var tripView: UIView!
    var tripHeader: TripHeader!
    var keyWindow = UIApplication.shared.keyWindow!
    
    lazy var  collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(white: 1, alpha: 0)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "cellId"
    
    func newState(state: AppState) {
        trip = state.tripState.selectedTrip()
        collectionView.reloadData()
    }
    
    func showTripDetai() {
        store.subscribe(self)
        
        tripView = UIView(frame: keyWindow.frame)
        tripView.backgroundColor = UIColor.rgb(red: 245, green: 245, blue: 245)
        
        tripView.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 50, width: 10, height: 10)
        
        keyWindow.addSubview(tripView)
        
        addSubViews()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.tripView.frame = self.keyWindow.frame
            UIApplication.shared.statusBarStyle = .lightContent
        }, completion: { (completedAnimation) in
        })
    }
    
    func addSubViews() {
        let height = keyWindow.frame.width * 9 / 16
        let tripHeaderFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
        tripHeader = TripHeader(frame: tripHeaderFrame)
        tripHeader.tripDetail = self
        tripView.addSubview(tripHeader)
        
        setupCollectionViews()
    }
    
    func closeView() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.tripView.frame = CGRect(x: self.keyWindow.frame.width, y: self.keyWindow.frame.height - 50, width: 0, height: 0)
            self.tripView.alpha = 0
            self.tripHeader.frame = CGRect()
            UIApplication.shared.statusBarStyle = .default
        }, completion: { (completedAnimation) in
        })
    }
    
    func setupCollectionViews() {
        tripView.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: tripView.topAnchor, constant: keyWindow.frame.width * 9 / 16 + 10).isActive = true
        collectionView.widthAnchor.constraint(equalTo: tripView.widthAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: tripView.leftAnchor, constant: 5).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: keyWindow.bottomAnchor).isActive = true
        
        collectionView.register(PlaceCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trip?.places.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PlaceCell
        cell.place = trip?.places[indexPath.item]
        cell.placeViewBadgeLabel.text = "Day \(indexPath.item + 1)"
        if let placeDescription = cell.place.placeDescription {
            cell.subTitleLabel.text = placeDescription
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: tripView.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
