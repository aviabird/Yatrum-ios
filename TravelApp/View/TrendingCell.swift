//
//  TrendingCell.swift
//  TravelApp
//
//  Created by rawat on 29/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {

    override func fetchTripsFeed() {
        TripService.sharedInstance.fetchTrendingTripsFeed { (trips: [Trip]) in
            self.trips = trips
            self.collectionView.reloadData()
        }
    }

}
