//
//  CreateTrip.swift
//  TravelApp
//
//  Created by Pankaj Rawat on 24/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class CreateTripController: UIViewController, UICollectionViewDataSource,  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var trip = Trip()
    
    var tripView: UIView!
    var tripEditForm: TripEdit!
    var selectedPlaceEditCell: PlaceEditCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.appMainBGColor()
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard)))
        
        // Do any additional setup after loading the view.
        loadSubViews()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    lazy var  collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    lazy var datePickerView: UIView = {
        let dpv = UIView()
        dpv.backgroundColor = UIColor.appMainBGColor()
        dpv.translatesAutoresizingMaskIntoConstraints = false
        return dpv
    }()
    
    lazy var datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.backgroundColor = UIColor.appMainBGColor()
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
    }()
    
    lazy var datePickerDoneButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.appMainBGColor()
        button.setTitle("Done", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.appLightBlue(), for: .normal)
        button.addTarget(self, action: #selector(handleDoneAddingDate), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    func handleDoneAddingDate() {
        handleDateSelection(sender: self.datePicker)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.datePickerView.frame = CGRect(x: 0, y:  (self.view.frame.height), width: (self.view.frame.width), height: 200)
        })
    }
    
    func handleDateSelection(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.short
        selectedPlaceEditCell?.placeViewBadgeDateLabel.text = dateFormatter.string(from: sender.date)
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
        datePickerView.addSubview(datePickerDoneButton)
        datePickerView.addSubview(datePicker)
        
        datePickerView.topAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        datePickerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        datePickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        datePickerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        datePickerDoneButton.topAnchor.constraint(equalTo: datePickerView.topAnchor, constant: 2).isActive = true
        datePickerDoneButton.rightAnchor.constraint(equalTo: datePickerView.rightAnchor, constant: -2).isActive = true
        datePickerDoneButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        datePickerDoneButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        datePicker.topAnchor.constraint(equalTo: datePickerDoneButton.bottomAnchor).isActive = true
        datePicker.widthAnchor.constraint(equalTo: datePickerView.widthAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: datePickerView.bottomAnchor).isActive = true
        datePicker.leftAnchor.constraint(equalTo: datePickerView.leftAnchor).isActive = true
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
                self.tripEditForm.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60)
                self.collectionView.frame = CGRect(x: 0, y: 60, width: self.view.frame.width, height: self.view.frame.height - 60)
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
