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
    
    var trips: [Trip]?
    var tags = ["river", "rafting", "india", "america", "mountains", "treking", "cycling", "swiming", "camping", "religious", "nature"]
    var filteredsearch:[String] = []
    
    let cellId = "cellId"
    let cellId2 = "cellId2"
    
    lazy var  collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect.init(), collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 100, green: 100, blue: 100, alpha: 0.2)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    lazy var  cellectionViewSearch: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect.init(), collectionViewLayout: layout)
        //        cv.backgroundColor = UIColor.rgb(red: 100, green: 100, blue: 100, alpha: 0.2)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var searchActive: Bool = false
    
    var searchBar: UISearchBar = UISearchBar(frame: CGRect.zero)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.subscribe(self)
        
        view.backgroundColor = UIColor.white
        navigationItem.title = "Search Trip"
        
        collectionView.register(SearchTripCell.self, forCellWithReuseIdentifier: cellId)
        cellectionViewSearch.register(SearchDropdownCell.self, forCellWithReuseIdentifier: cellId2)
        
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        view.addSubview(cellectionViewSearch)
        
        setupSearchBar()
        setupCollectionView()
        setupCollectionViewSearch()
        
        func filterContentForSearchText(searchText: String) {
            filteredsearch = tags.filter { tag in
                return tag.lowercased().contains(searchText.lowercased())
            }
        }
        
        searchBar.rx.value.asDriver().debounce(0.5).drive(onNext: { (val) in
            filterContentForSearchText(searchText: val!)
            TripService.sharedInstance.searchTrips(keywords: val!,
                                                   completion: { (searchedTrips: [Trip]) in
                                                    self.trips = searchedTrips
                                                    self.collectionView.reloadData()
                                                    self.cellectionViewSearch.reloadData()
            })
            
        }).addDisposableTo(disposeBag)
        
        
        fetchTripsFeed()
        
    }
    
    func fetchTripsFeed() {
        //        store.dispatch(FetchTripsFeed)
    }
    
    func newState(state: AppState) {
        //        trips = state.tripState.feedTrips()
        //        collectionView.reloadData()
    }
    
    func setupSearchBar() {
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 65).isActive = true
        searchBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    func setupCollectionView() {
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
//        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupCollectionViewSearch() {
        cellectionViewSearch.translatesAutoresizingMaskIntoConstraints = false
        cellectionViewSearch.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        cellectionViewSearch.widthAnchor.constraint(equalTo: searchBar.widthAnchor).isActive = true
        cellectionViewSearch.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(filteredsearch)
        return filteredsearch.count
//        return trips?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId2, for: indexPath) as! SearchDropdownCell
        cell.searchedLabel.text = filteredsearch[indexPath.row]
        return cell
        
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchTripCell
//            cell.backgroundColor = UIColor.white
//            cell.layer.shadowOffset = CGSize(width: 5, height: 5)
//            cell.trip = trips?[indexPath.item]
//            return cell


    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 30)
//        return CGSize(width: view.frame.width, height: 250)

    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("Hello")
//    }
//    
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return 0
    //    }
}
