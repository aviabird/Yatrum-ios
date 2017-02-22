//
//  PlaceEditCell.swift
//  TravelApp
//
//  Created by rawat on 18/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit
import RxSwift

class PlaceEditCell: BaseCell {
    
    var place: Place!
    var createTripCtrl: CreateTripController!
    let disposeBag = DisposeBag()

    let placeViewBadge: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.rgb(red: 41, green: 128, blue: 185)
        return view
    }()
    
    lazy var calenderButton: UIButton = {
        let ub = UIButton(type: .system)
        ub.setImage(UIImage(named: "calender"), for: .normal)
        ub.tintColor = UIColor.white
        ub.translatesAutoresizingMaskIntoConstraints = false
        ub.addTarget(self, action: #selector(handleDatePickerSelection), for: .touchUpInside)
        return ub
    }()

    
    lazy var placeViewBadgeDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add Date"
        label.numberOfLines = 2
        label.font = label.font.withSize(12)
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDatePickerSelection)))
        
        return label
    }()
    
    func handleDatePickerSelection() {
        createTripCtrl.selectedPlaceEditCell = self
        createTripCtrl.dismissKeyboard()
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.createTripCtrl.datePickerView.frame = CGRect(x: 0, y:  (self.window?.frame.height)! - 200, width: (self.window?.frame.width)!, height: 200)
            self.createTripCtrl.collectionView.scrollToItem(at: self.createTripCtrl.collectionView.indexPath(for: self)!, at: .top, animated: true)
        }, completion: nil)
    }
    
    lazy var placeViewBadgeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add Place"
        label.numberOfLines = 2
        label.font = label.font.withSize(12)
        label.textAlignment = .right
        label.textColor = UIColor.white
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAddPlace)))
        return label
    }()
    
    lazy var navMarkerButton: UIButton = {
        let ub = UIButton(type: .system)
        ub.setImage(UIImage(named: "nav-marker"), for: .normal)
        ub.tintColor = UIColor.white
        ub.translatesAutoresizingMaskIntoConstraints = false
        ub.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAddPlace)))
        return ub
    }()
    
    func handleAddPlace() {
        createTripCtrl.selectedPlaceEditCell = self
        createTripCtrl.autocompleteClicked()
    }
    
    lazy var placeReviewTextPlaceHolder: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Share something cool about this place."
        label.numberOfLines = 2
        label.font = label.font.withSize(15)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    lazy var placeReviewText: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = ""
        textView.textColor = UIColor.darkGray
        textView.backgroundColor = UIColor.appMainBGColor()
        textView.textAlignment = .justified
        textView.isScrollEnabled = false
        textView.isEditable = true
        textView.font = .systemFont(ofSize: 15)
        return textView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = UIColor.appMainBGColor()
        
        placeReviewText.rx.value.asDriver().drive(onNext: { (val) in
            if (val?.isEmpty)! {
                self.placeReviewTextPlaceHolder.alpha = 1
            } else {
                self.placeReviewTextPlaceHolder.alpha = 0
            }
        }).addDisposableTo(disposeBag)
        
        addPlaceViewBadge()
        addPlaceReviewText()
    }
    
    func addPlaceViewBadge() {
        addSubview(placeViewBadge)
        placeViewBadge.addSubview(placeViewBadgeTitleLabel)
        placeViewBadge.addSubview(navMarkerButton)
        placeViewBadge.addSubview(placeViewBadgeDateLabel)
        placeViewBadge.addSubview(calenderButton)
        
        placeViewBadge.topAnchor.constraint(equalTo: topAnchor).isActive = true
        placeViewBadge.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        placeViewBadge.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        placeViewBadge.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        calenderButton.centerYAnchor.constraint(equalTo: placeViewBadge.centerYAnchor).isActive = true
        calenderButton.leftAnchor.constraint(equalTo: placeViewBadge.leftAnchor, constant: 5).isActive = true
        calenderButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        calenderButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        placeViewBadgeDateLabel.centerYAnchor.constraint(equalTo: placeViewBadge.centerYAnchor).isActive = true
        placeViewBadgeDateLabel.leftAnchor.constraint(equalTo: calenderButton.rightAnchor, constant: 5).isActive = true
        placeViewBadgeDateLabel.widthAnchor.constraint(equalTo: placeViewBadge.widthAnchor, multiplier: 1.6/6).isActive = true
        placeViewBadgeDateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        navMarkerButton.centerYAnchor.constraint(equalTo: placeViewBadge.centerYAnchor).isActive = true
        navMarkerButton.rightAnchor.constraint(equalTo: placeViewBadge.rightAnchor, constant: -5).isActive = true
        navMarkerButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        navMarkerButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        placeViewBadgeTitleLabel.centerYAnchor.constraint(equalTo: placeViewBadge.centerYAnchor).isActive = true
        placeViewBadgeTitleLabel.rightAnchor.constraint(equalTo: navMarkerButton.leftAnchor, constant: -5).isActive = true
        placeViewBadgeTitleLabel.widthAnchor.constraint(equalTo: placeViewBadge.widthAnchor, multiplier: 3/6).isActive = true
        placeViewBadgeTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func addPlaceReviewText() {
        addSubview(placeReviewText)
        placeReviewText.addSubview(placeReviewTextPlaceHolder)
        
        placeReviewText.topAnchor.constraint(equalTo: placeViewBadge.bottomAnchor, constant: 5).isActive = true
        placeReviewText.widthAnchor.constraint(equalTo: placeViewBadge.widthAnchor, constant: -10).isActive = true
        placeReviewText.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        placeReviewText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        
        placeReviewTextPlaceHolder.topAnchor.constraint(equalTo: placeReviewText.topAnchor, constant: 5).isActive = true
        placeReviewTextPlaceHolder.leftAnchor.constraint(equalTo: placeReviewText.leftAnchor, constant: 5).isActive = true
        placeReviewTextPlaceHolder.heightAnchor.constraint(equalToConstant: 20).isActive = true
        placeReviewTextPlaceHolder.widthAnchor.constraint(equalTo: placeReviewText.widthAnchor).isActive = true
    }

}
