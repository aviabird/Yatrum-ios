//
//  PlaceCell.swift
//  TravelApp
//
//  Created by rawat on 04/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class PlaceCell: BaseCell, UICollectionViewDataSource,  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    lazy var  photoCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        if let flowLayout = cv.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isPagingEnabled = true
        
        return cv
    }()
    
    var place: Place! {
        didSet{
            placeViewBadgeTitleLabel.text = place.name
            placeViewBadgeDateLabel.text = place.created_at?.humanizeDate(format: "dd MMM yy hh:mm a")
            placeDescText.text = place.review
            
//            placeDescTextHeightConstraint.constant = placeDescText.contentSize.height + 30
//            placeDescTextHeightConstraint.isActive = true
        }
    }
    
    let placeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let placeViewVerticalSeparator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        return view
    }()
    
    let streetViewButton: UIButton = {
        let ub = UIButton(type: .system)
        ub.setImage(UIImage(named: "street-view"), for: .normal)
        ub.tintColor = UIColor.appCallToActionColor()
        ub.translatesAutoresizingMaskIntoConstraints = false
        return ub
    }()
    
    let placeViewBadge: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.rgb(red: 41, green: 128, blue: 185)
        view.layer.cornerRadius = 2
        return view
    }()
    
    let navMarkerButton: UIButton = {
        let ub = UIButton(type: .system)
        ub.setImage(UIImage(named: "nav-marker"), for: .normal)
        ub.tintColor = UIColor.white
        ub.translatesAutoresizingMaskIntoConstraints = false
        return ub
    }()
    
    let placeViewBadgeDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Day 1"
        label.numberOfLines = 1
        label.font = label.font.withSize(10)
        label.textColor = UIColor.white
        label.textAlignment = .left
        return label
    }()
    
    let placeViewBadgeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 2
        label.font = label.font.withSize(12)
        label.textAlignment = .right
        label.textColor = UIColor.white
        return label
    }()
    
    let placeDescText: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Amazing View of eiffel tower."
        textView.textColor = UIColor.gray
        textView.backgroundColor = UIColor(white: 0, alpha: 0)
        textView.isEditable = false
        textView.textAlignment = .justified
        return textView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addPlaceView()
        addPlaceViewBadge()
        addPlaceImages()
        addSubViewToPlaceView()
        addStreetViewBtn()
    }
    
    func addStreetViewBtn() {
        addSubview(streetViewButton)
        addSubview(placeViewVerticalSeparator)
        
        streetViewButton.bottomAnchor.constraint(equalTo: placeViewBadge.bottomAnchor).isActive = true
        streetViewButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 0.3).isActive = true
        streetViewButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        streetViewButton.heightAnchor.constraint(equalTo: placeViewBadge.heightAnchor).isActive = true
        
        placeViewVerticalSeparator.topAnchor.constraint(equalTo: streetViewButton.bottomAnchor, constant: 5).isActive = true
        placeViewVerticalSeparator.centerXAnchor.constraint(equalTo: streetViewButton.centerXAnchor).isActive = true
        placeViewVerticalSeparator.widthAnchor.constraint(equalToConstant: 2).isActive = true
        placeViewVerticalSeparator.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func addPlaceViewBadge() {
        addSubview(placeViewBadge)
        placeViewBadge.addSubview(placeViewBadgeTitleLabel)
        placeViewBadge.addSubview(placeViewBadgeDateLabel)
        placeViewBadge.addSubview(navMarkerButton)
        
        placeViewBadge.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        placeViewBadge.widthAnchor.constraint(equalTo: widthAnchor, constant: -50).isActive = true
        placeViewBadge.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        placeViewBadge.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        navMarkerButton.centerYAnchor.constraint(equalTo: placeViewBadge.centerYAnchor).isActive = true
        navMarkerButton.rightAnchor.constraint(equalTo: placeViewBadge.rightAnchor, constant: -5).isActive = true
        navMarkerButton.widthAnchor.constraint(equalToConstant: 15).isActive = true
        navMarkerButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        placeViewBadgeTitleLabel.centerYAnchor.constraint(equalTo: placeViewBadge.centerYAnchor).isActive = true
        placeViewBadgeTitleLabel.widthAnchor.constraint(equalTo: placeViewBadge.widthAnchor, multiplier: 2.5/6).isActive = true
        placeViewBadgeTitleLabel.rightAnchor.constraint(equalTo: navMarkerButton.leftAnchor, constant: -5).isActive = true
        placeViewBadgeTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        placeViewBadgeDateLabel.centerYAnchor.constraint(equalTo: placeViewBadge.centerYAnchor).isActive = true
        placeViewBadgeDateLabel.leftAnchor.constraint(equalTo: placeViewBadge.leftAnchor, constant: 5).isActive = true
        placeViewBadgeDateLabel.widthAnchor.constraint(equalTo: placeViewBadge.widthAnchor, multiplier: 2.4/6).isActive = true
        placeViewBadgeDateLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
    }
    
    func addPlaceView() {
        addSubview(placeView)
        
        placeView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        placeView.widthAnchor.constraint(equalTo: widthAnchor, constant: -20).isActive = true
        placeView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        placeView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    var placeDescTextHeightConstraint: NSLayoutConstraint!
    
    func addSubViewToPlaceView() {
        placeView.addSubview(placeDescText)
        
        placeDescText.topAnchor.constraint(equalTo: placeViewBadge.bottomAnchor, constant: 10).isActive = true
        placeDescText.widthAnchor.constraint(equalTo: placeViewBadge.widthAnchor).isActive = true
        placeDescText.centerXAnchor.constraint(equalTo: placeViewBadge.centerXAnchor).isActive = true
//        placeDescTextHeightConstraint = placeDescText.heightAnchor.constraint(equalToConstant: 10)
//        placeDescTextHeightConstraint.constant = 100
        placeDescText.bottomAnchor.constraint(equalTo: photoCollectionView.topAnchor, constant: -5).isActive = true
        
    }
    
    func addPlaceImages() {
        placeView.addSubview(photoCollectionView)
        
        photoCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        photoCollectionView.rightAnchor.constraint(equalTo: placeViewBadge.rightAnchor).isActive = true
        photoCollectionView.widthAnchor.constraint(equalTo: placeViewBadge.widthAnchor).isActive = true
        photoCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        photoCollectionView.heightAnchor.constraint(equalToConstant: 210).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return place.pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowRadius = 2
        cell.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell.layer.shadowColor = UIColor.darkGray.cgColor
        
        let placeImage = CustomImageView()
        placeImage.loadImageUsingUrlString(urlString: place.pictures[indexPath.item].url!, width: Float(frame.width))
        placeImage.translatesAutoresizingMaskIntoConstraints = false
        cell.addSubview(placeImage)
        placeImage.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        placeImage.leftAnchor.constraint(equalTo: cell.leftAnchor).isActive = true
        placeImage.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
        placeImage.widthAnchor.constraint(equalTo: cell.widthAnchor).isActive = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = placeDescText.frame.width
        return CGSize(width: width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
