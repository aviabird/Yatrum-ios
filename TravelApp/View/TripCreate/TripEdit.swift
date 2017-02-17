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

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.appBaseColor()
        
        setupViews()
    }
    
    var trip: Trip!
    
    func hideAll() {
        
    }
    
    func showAll() {
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
    
    let publishButton: UIButton = {
        let ub = UIButton(type: .system)
        ub.setTitle("Publish", for: .normal)
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
    
    func addPublishBtn() {
        addSubview(publishButton)
        
        publishButton.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        publishButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        publishButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        publishButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
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
