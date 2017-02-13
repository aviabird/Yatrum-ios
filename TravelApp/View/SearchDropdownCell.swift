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
        st.font = UIFont.preferredFont(forTextStyle: .footnote)
        st.textColor = UIColor.brown
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
        searchedLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -70).isActive = true
        searchedLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        searchedLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func selectSearch() {
        searchCtrl.searchTrips(query: searchedLabel.text!)
    }
    
}
