//
//  SearchTripViewController.swift
//  TravelApp
//
//  Created by Nitesh on 01/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReSwift

class SearchTripViewController: UIViewController, UICollectionViewDataSource,  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, StoreSubscriber {
    
    
    let cellId = "cellId"
    lazy var  collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect.init(), collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 100, green: 100, blue: 100, alpha: 0.2)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.subscribe(self)

        collectionView.register(SearchTripCell.self, forCellWithReuseIdentifier: cellId)
        view.backgroundColor = UIColor.white
        navigationItem.title = "Search Trip"
        
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        setupSearchBar()
        searchBar.rx.value.asDriver().drive(onNext: { (val) in
            print(val!)
        }).addDisposableTo(disposeBag)
        
        
        fetchTripsFeed()
        
    }
        
    var searchBar: UISearchBar = UISearchBar(frame: CGRect.zero)    
    
    var trips: [Trip]?
    func fetchTripsFeed() {
        store.dispatch(FetchTripsFeed)
    }
    
    func newState(state: AppState) {
        trips = state.tripState.feedTrips()
        collectionView.reloadData()
    }
    
    func setupSearchBar() {
        searchBar.placeholder = "Search"
//        navigationItem.titleView = searchBar
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: searchBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        view.addConstraintsWithFormat(format: "V:|-64-[v0(50)]-10-[v1]", views: searchBar, collectionView)
        
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trips?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! SearchTripCell
        cell.backgroundColor = UIColor.white
        cell.layer.shadowOffset = CGSize(width: 5, height: 5)
        cell.trip = trips?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
}
