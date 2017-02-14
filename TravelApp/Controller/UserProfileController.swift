//
//  UserProfileController.swift
//  TravelApp
//
//  Created by Nitesh on 14/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class UserProfileController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let cellId  = "cellId"
    
    lazy var  collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView()
//        frame: CGRect.init(), collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 100, green: 100, blue: 100, alpha: 0.2)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UserTripCell.self, forCellWithReuseIdentifier: cellId)
        view.addSubview(collectionView)
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }

}

