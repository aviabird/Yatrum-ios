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

class SearchTripViewController: UIViewController, UICollectionViewDataSource,  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    let cellId = "cellId"
    lazy var  collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect.init(), collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        view.backgroundColor = UIColor.white
        navigationItem.title = "Search Trip"
        
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        setupSearchBar()
        searchBar.rx.value.asDriver().drive(onNext: { (val) in
            print(val!)
        }).addDisposableTo(disposeBag)
        
    }
    
    var searchBar: UISearchBar = UISearchBar(frame: CGRect.zero)    
    
    func setupSearchBar() {
        searchBar.placeholder = "Search"
//        navigationItem.titleView = searchBar
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: searchBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        view.addConstraintsWithFormat(format: "V:|-64-[v0(50)]-10-[v1]", views: searchBar, collectionView)
        
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = UIColor.blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height / 4)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
}
