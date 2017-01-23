//
//  BaseCell.swift
//  TravelApp
//
//  Created by rawat on 23/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
