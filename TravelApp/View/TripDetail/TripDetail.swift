//
//  TripDetail.swift
//  TravelApp
//
//  Created by rawat on 04/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit
import ReSwift

class TripDetail: NSObject, StoreSubscriber {
    
    var trip: Trip?
    
    var tripView: UIView!
    var tripHeader: TripHeader!
    var keyWindow = UIApplication.shared.keyWindow!
    
    func newState(state: AppState) {
        trip = state.tripState.selectedTrip()
    }
    
    func showTripDetai() {
        store.subscribe(self)
        
        tripView = UIView(frame: keyWindow.frame)
        tripView.backgroundColor = UIColor.rgb(red: 245, green: 245, blue: 245)
        
        tripView.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 50, width: 10, height: 10)
        
        let height = keyWindow.frame.width * 9 / 16
        let tripHeaderFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
        tripHeader = TripHeader(frame: tripHeaderFrame)
        tripHeader.tripDetail = self
        tripView.addSubview(tripHeader)
        
        keyWindow.addSubview(tripView)
        
        addSubViews()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.tripView.frame = self.keyWindow.frame
            UIApplication.shared.statusBarStyle = .lightContent
        }, completion: { (completedAnimation) in
        })
    }
    
    func addSubViews() {
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
    
}
