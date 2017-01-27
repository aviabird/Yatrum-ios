//
//  MenuBar.swift
//  TravelApp
//
//  Created by rawat on 27/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout =  UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(white: 1, alpha: 0.95)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "cellId"
    let imageNames = ["feeds", "trending", "notifications", "near-me"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId )
        addSubview(collectionView)
        addConstraintsWithFormat(format:  "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        let selectedIndexPath = NSIndexPath(item: 0, section: 0) as IndexPath
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
        
        setupHorizontalBar()
    }
    
    func setupHorizontalBar() {
        let horizontalBar = UIView()
        horizontalBar.backgroundColor = UIColor.green
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as!  MenuCell
        cell.imageName = imageNames[indexPath.item]
        cell.imageView.image = UIImage(named: cell.imageName)?.withRenderingMode(.alwaysTemplate)
        cell.labelView.text = imageNames[indexPath.item].capitalized
        
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

class MenuCell: BaseCell {
    
    var imageName: String = ""
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "feeds-filled")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.darkGray
        return iv
    }()
    
    let labelView: UILabel = {
        let labelView = UILabel()
        labelView.textColor = UIColor.darkGray
        labelView.font = labelView.font.withSize(10)
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
        if status {
            imageView.image = UIImage(named: "\(self.imageName)-filled")?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = UIColor.appBaseColor()
            labelView.textColor = UIColor.appBaseColor()
        } else {
            imageView.image = UIImage(named: "\(self.imageName)")?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = UIColor.darkGray
            labelView.textColor = UIColor.darkGray
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addSubview(labelView)
        addConstraintsWithFormat(format: "H:[v0(25)]", views: imageView)
        addConstraintsWithFormat(format: "V:[v0(25)]-[v1]", views: imageView, labelView)
        
        
        
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -8).isActive = true
        
        labelView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        labelView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
    }
}
