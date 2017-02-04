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
        }
    }
    
    var tripView: UIView!
    var keyWindow = UIApplication.shared.keyWindow!
    
    func showTripDetai() {
        tripView = UIView(frame: keyWindow.frame)
        tripView.backgroundColor = UIColor.rgb(red: 245, green: 245, blue: 245)
        
        tripView.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
        
        let height = keyWindow.frame.width * 9 / 16
        let tripHeaderFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
        let tripHeader = TripHeader(frame: tripHeaderFrame)
        tripHeader.trip = self.trip
        tripHeader.tripDetail = self
        tripView.addSubview(tripHeader)
        
        keyWindow.addSubview(tripView)
        
        addSubViews()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.tripView.frame = self.keyWindow.frame
        }, completion: { (completedAnimation) in
            UIApplication.shared.setStatusBarHidden(true, with: .fade)
        })
    }
    
    func addSubViews() {
    }
    
    func closeView() {
        keyWindow.willRemoveSubview(tripView)
        keyWindow.removeFromSuperview()
    }
    
}
