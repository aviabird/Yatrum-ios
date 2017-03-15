//
//  TripEdit.swift
//  TravelApp
//
//  Created by Pankaj Rawat on 17/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class TripEdit: UIView {
    var createTripCtrl: CreateTripController!
    var placeCells: PlaceEditCell!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.appBaseColor()
        
        setupViews()
    }
    
    var trip: Trip!
    
    func hideAll() {
        thumbnailImageView.frame = CGRect(x: 0, y: 0, width: thumbnailImageView.frame.width, height: 60)
        titleTextField.frame.origin.y = 25
        tripPhotoUploadButton.isHidden = true
    }
    
    func showAll() {
        thumbnailImageView.frame = CGRect(x: 0, y: 0, width: thumbnailImageView.frame.width, height: frame.height)
        titleTextField.frame.origin.y = frame.height / 2
        tripPhotoUploadButton.isHidden = false
    }
    
    var thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0.5
        return imageView
    }()
    
    let titleTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = UIColor.white
        tf.attributedPlaceholder =  NSAttributedString(string: "Title Here",
                           attributes: [NSForegroundColorAttributeName: UIColor.white])
        tf.tintColor = UIColor.appCallToActionColor()
        tf.textAlignment = .center
        return tf
    }()
    
    let descTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = UIColor.white
        tf.attributedPlaceholder =  NSAttributedString(string: "Description here Here",
                                                       attributes: [NSForegroundColorAttributeName: UIColor.white])
        tf.tintColor = UIColor.appCallToActionColor()
        tf.textAlignment = .center
        return tf
    }()
    
    let publishButton: UIButton = {
        let ub = UIButton(type: .system)
        ub.setTitle("Publish", for: .normal)
        ub.tintColor = UIColor.white
        ub.backgroundColor = UIColor.appCallToActionColor()
        ub.translatesAutoresizingMaskIntoConstraints = false
        ub.layer.cornerRadius = 2
        return ub
    }()
    
    let tagsButton: UIButton = {
        let ub = UIButton(type: .system)
        ub.setTitle("Tags", for: .normal)
        ub.tintColor = UIColor.white
        ub.backgroundColor = UIColor.appCallToActionColor()
        ub.translatesAutoresizingMaskIntoConstraints = false
        ub.layer.cornerRadius = 2
        return ub
    }()
    
    lazy var tripPhotoUploadButton: UIButton = {
        let ub = UIButton(type: .system)
        ub.setImage(UIImage(named: "camera-filled"), for: .normal)
        ub.tintColor = UIColor.white
        ub.translatesAutoresizingMaskIntoConstraints = false
        ub.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectTripImage)))
        return ub
    }()
    
    func handleSelectTripImage() {
        self.createTripCtrl.handleSelectTripImage()
    }

    let closeButton: UIButton = {
        let ub = UIButton(type: .system)
        ub.setImage(UIImage(named: "minimize"), for: .normal)
        ub.tintColor = UIColor.white
        ub.layer.shadowOpacity = 0.5
        ub.layer.shadowRadius = 3
        ub.layer.shadowOffset = CGSize(width: 0, height: 2)
        ub.layer.shadowColor = UIColor.darkGray.cgColor
        ub.translatesAutoresizingMaskIntoConstraints = false
        ub.addTarget(self, action: #selector(handleCloseView), for: .touchUpInside)
        return ub
    }()
    
    func handleCloseView() {
        statusBarBackgroundView.alpha = 1
        createTripCtrl?.dismiss(animated: true, completion: nil)
    }
    
    func setupViews() {
        addThumbnailImage()
        addCloseBtn()
        addPublishBtn()
        addTitleView()
        addTripPhotoUploadButton()
        addDescView()
//        addtagsBtn()
        
        publishButton.addTarget(self, action: #selector(addIntoTrip), for: .touchUpInside)
    }
    
    func handleFollow() {
//        user.is_followed_by_current_user = !user.is_followed_by_current_user
        
//        toggleFollow()
        
//        UserService.sharedInstance.followUser(followedId: (user.id)!) { (user: User) in
//            
//            guard user.is_followed_by_current_user != self.user.is_followed_by_current_user else {
//                return
//            }
//            
//            self.toggleFollow()
//        }
    }
    
    
    func addIntoTrip() {
        
        if titleTextField.text == "" && descTextField.text == ""{
            titleTextField.shake()
            descTextField.shake()
        } else {
            
            print(titleTextField.text!)
            print(descTextField.text!)
            createTripCtrl.creatingTrip()
            createTripCtrl.publishingTrip()
        }
        
        return
    }
    
    func addThumbnailImage() {
        addSubview(thumbnailImageView)
        
        thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    func addCloseBtn() {
        addSubview(closeButton)
        
        closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        closeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func addTitleView() {
        addSubview(titleTextField)
        
        titleTextField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleTextField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleTextField.widthAnchor.constraint(equalTo: widthAnchor, constant: -10).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func addDescView()  {
        addSubview(descTextField)
        descTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 5).isActive = true
        descTextField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        descTextField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        descTextField.widthAnchor.constraint(equalTo: widthAnchor, constant: -30).isActive = true
        descTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func addPublishBtn() {
        addSubview(publishButton)
        
        publishButton.topAnchor.constraint(equalTo: topAnchor, constant: 22).isActive = true
        publishButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        publishButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        publishButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func addtagsBtn() {
        addSubview(tagsButton)
        
        tagsButton.topAnchor.constraint(equalTo: descTextField.bottomAnchor).isActive = true
        tagsButton.leftAnchor.constraint(equalTo: leftAnchor, constant: -5).isActive = true
        tagsButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        tagsButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func addTripPhotoUploadButton() {
        addSubview(tripPhotoUploadButton)
        
        tripPhotoUploadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        tripPhotoUploadButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        tripPhotoUploadButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tripPhotoUploadButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = trip.thumbnail_image_url {
            thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl, width: Float(frame.width))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


