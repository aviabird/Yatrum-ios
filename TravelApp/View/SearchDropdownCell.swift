//
//  SearchDropdownCell.swift
//  TravelApp
//
//  Created by Nitesh on 10/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class SearchDropdownCell: BaseCell {
    
    var searchedLabel : UILabel = {
        let st = UILabel()
        st.translatesAutoresizingMaskIntoConstraints = false
        st.backgroundColor = UIColor.white
        return st
    }()
    
    var selectedSearch: String = ""
    var searchCtrl: SearchTripViewController!
    
    
    override func setupViews() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectSearch))
        searchedLabel.isUserInteractionEnabled = true
        searchedLabel.addGestureRecognizer(tapGesture)
        
        addSubview(searchedLabel)
        searchedLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        searchedLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        searchedLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func selectSearch() {
        searchCtrl.searchTrips(query: searchedLabel.text!)
    }
    
}
