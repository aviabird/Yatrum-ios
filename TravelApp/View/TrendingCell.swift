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
        store.dispatch(FetchTrendingTripsFeed)
    }
    
    override func newState(state: AppState) {
        trips = state.tripState.trendingTrips()
        collectionView.reloadData()
    }

}
