//
//  TripDetailViewController.swift
//  TravelApp
//
//  Created by Pankaj Rawat on 12/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit
import ReSwift

class TripDetailViewController: UIViewController, UICollectionViewDataSource,  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, StoreSubscriber {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor.appMainBGColor()
        
        UIView.animate(withDuration: 0.2, delay: 0.4, options: .curveEaseIn, animations: {
            statusBarBackgroundView.alpha = 0
        }, completion: nil)

        // Do any additional setup after loading the view.
        loadSubViews()
    }
    
    var trip: Trip?
    
    var tripView: UIView!
    var tripHeader: TripHeader!
    
    lazy var  collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "cellId"
    
    func loadSubViews() {
        store.subscribe(self)
        addTripHeader()
        setupCollectionViews()
    }
    
    func addTripHeader() {
        let height = view.frame.width * 9 / 16
        let tripHeaderFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
        tripHeader = TripHeader(frame: tripHeaderFrame)
        tripHeader.tripDetailCtrl = self
        
        view.addSubview(tripHeader)
    }
    
    func newState(state: AppState) {
        trip = state.tripState.selectedTrip()
        collectionView.reloadData()
    }
    
    func setupCollectionViews() {
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: tripHeader.bottomAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(PlaceCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trip?.places.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PlaceCell
        cell.place = trip?.places[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let text = trip?.places[indexPath.item].review
        
        let approxWidth = view.frame.width - 60
        let size = CGSize(width: approxWidth, height: 1000)
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 12)]
        
        let estimatedFrame = NSString(string: text!).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return CGSize(width: view.frame.width, height: estimatedFrame.height + 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            switch true {
            case scrollView.contentOffset.y >= 100:
                self.tripHeader.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
                self.collectionView.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: self.view.frame.height - 50)
                self.tripHeader.hideAll()
                break
            case scrollView.contentOffset.y <= 1:
                let height = self.view.frame.width * 9 / 16
                self.tripHeader.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: height)
                self.collectionView.frame = CGRect(x: 0, y: height, width: self.view.frame.width, height: self.view.frame.height - height)
                self.tripHeader.showAll()
                break
            default:
                break
            }
        }, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
