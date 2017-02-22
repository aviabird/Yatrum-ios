//
//  UserMenuBar.swift
//  TravelApp
//
//  Created by Nitesh on 16/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class UserMenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    let cell = "cellID"
    
    let profileTabs = ["Trips", "Followers", "Following", "Media"]

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.red
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var userProfileCell: UserProfileCell!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(UserMenuCell.self, forCellWithReuseIdentifier: cell)
        setupCollectionView()
        
        let selectedIndexPath = NSIndexPath(item: 0, section: 0) as IndexPath
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
        setupHorizontalBar()
        
        
    }
    
    func setupCollectionView() {
        addSubview(collectionView)
        addConstraintsWithFormat(format:  "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
    }
    
    var horizontalBarLeftAnchor: NSLayoutConstraint?
    
    func setupHorizontalBar() {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor.orange
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        
        horizontalBarLeftAnchor = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAnchor?.isActive = true
        horizontalBarView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        let x = CGFloat(indexPath.item) * frame.width / 4
        horizontalBarLeftAnchor?.constant = x
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
            self.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.75) { 
            self.layoutIfNeeded()
        }
        userProfileCell.scrollToMenuIndex(menuIndex: indexPath)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cell, for: indexPath) as! UserMenuCell
        cell.labelView.text = profileTabs[indexPath.item].capitalized
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class UserMenuCell: BaseCell {
    
    let labelView: UILabel = {
        let labelView = UILabel()
        labelView.textColor = UIColor.darkGray
        labelView.font = labelView.font.withSize(12)
        labelView.text = "Hello"
//        labelView.backgroundColor = UIColor.b
        labelView.textAlignment = .center
        labelView.translatesAutoresizingMaskIntoConstraints = false
        return labelView
    }()
    
    override var isHighlighted: Bool {
        didSet {
            updateViewOnSelectedAndHighlight(status: isHighlighted)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            updateViewOnSelectedAndHighlight(status: isSelected)
        }
    }
    
    func updateViewOnSelectedAndHighlight(status: Bool) {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            if status {
                self.labelView.tintColor = UIColor.appCallToActionColor()
                self.labelView.textColor = UIColor.appCallToActionColor()
            } else {
                self.labelView.tintColor = UIColor.darkGray
                self.labelView.textColor = UIColor.darkGray
            }
        }, completion: nil)
    }
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = UIColor.yellow
        
        addSubview(labelView)
        
        
        labelView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        labelView.widthAnchor.constraint(equalTo: widthAnchor, constant: 2).isActive = true
        labelView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        labelView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
}












