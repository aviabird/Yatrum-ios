//
//  CreateTrip.swift
//  TravelApp
//
//  Created by Pankaj Rawat on 24/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class CreateTripController: UIViewController, UICollectionViewDataSource,  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.appMainBGColor()
        
        // Do any additional setup after loading the view.
        loadSubViews()
    }
    
    var trip = Trip()
    
    var tripView: UIView!
    var tripEditForm: TripEdit!
    var selectedPlaceEditCell: PlaceEditCell?
    
    lazy var  collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    lazy var datePickerView: UIDatePicker = {
        let dp = UIDatePicker()
        dp.backgroundColor = UIColor.appMainBGColor()
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.addTarget(self, action: #selector(handleDateSelection), for: .valueChanged)
        dp.isHidden = true
        return dp
    }()
    
    func handleDateSelection(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.short
        selectedPlaceEditCell?.placeViewBadgeDateLabel.text = dateFormatter.string(from: sender.date)
        sender.isHidden = true
        collectionView.reloadData()
    }
    
    let cellId = "cellId"
    
    func loadSubViews() {
        trip.user = SharedData.sharedInstance.getCurrentUser()!
        trip.places = [Place(), Place()]
        
        addTripEditForm()
        setupCollectionViews()
        addDatePickerView()
    }
    
    func addTripEditForm() {
        let tripHeaderFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: 150)
        tripEditForm = TripEdit(frame: tripHeaderFrame)
        tripEditForm.createTripCtrl = self
        tripEditForm.layer.shadowOpacity = 0.5
        tripEditForm.layer.shadowRadius = 3
        tripEditForm.layer.shadowOffset = CGSize(width: 0, height: 2)
        tripEditForm.layer.shadowColor = UIColor.black.cgColor
        
        view.addSubview(tripEditForm)
    }
    
    func setupCollectionViews() {
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: tripEditForm.bottomAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(PlaceEditCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func addDatePickerView() {
        view.addSubview(datePickerView)
        
        datePickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        datePickerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        datePickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        datePickerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trip.places.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PlaceEditCell
        cell.place = trip.places[indexPath.item]
        cell.createTripCtrl = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let text = trip.places[indexPath.item].review
        
        let approxWidth = view.frame.width - 60
        let size = CGSize(width: approxWidth, height: 1000)
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 12)]
        
        let estimatedFrame = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return CGSize(width: view.frame.width, height: estimatedFrame.height + 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            switch true {
            case scrollView.contentOffset.y >= 100:
                self.tripEditForm.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
                self.collectionView.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: self.view.frame.height - 50)
                self.tripEditForm.hideAll()
                break
            case scrollView.contentOffset.y <= 1:
                let height = self.view.frame.width * 9 / 16
                self.tripEditForm.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: height)
                self.collectionView.frame = CGRect(x: 0, y: height, width: self.view.frame.width, height: self.view.frame.height - height)
                self.tripEditForm.showAll()
                break
            default:
                break
            }
        }, completion: nil)
        
    }
    
}
