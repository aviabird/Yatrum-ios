//
//  ViewController.swift
//  TravelApp
//
//  Created by Pankaj Rawat on 21/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var sharedData = SharedData()
    var trips: [Trip]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        if sharedData.getToken() == "" {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            fetchTrips()
            navigationItem.title = "Home"
            navigationController?.navigationBar.isTranslucent =  false
            
            let titleLabel = UILabel(frame: CGRect(x:0, y:0, width:view.frame.width - 32, height: view.frame.height))
            titleLabel.text = "Home"
            titleLabel.textColor = UIColor.white
            titleLabel.font = UIFont.systemFont(ofSize: 20)
            navigationItem.titleView = titleLabel
            
            
            collectionView?.backgroundColor = UIColor.white
            
            collectionView?.register(TripCell.self, forCellWithReuseIdentifier: "cellId")
            
//            collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
//            collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
            
            
        }
    }
    
    func handleLogout() {
        
        sharedData.clearAll()
        
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
        
    }
    
    func fetchTrips() {
        let url = NSURL(string: "\(sharedData.API_URL)/trips.json?page=1")
        
        let configuration = URLSessionConfiguration.default
        
        let urlRequest = URLRequest(url: url as! URL)
        
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
                return
            }
                
            else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    
                    let responseJson = json as! [String: AnyObject]
                    let tripsArray = responseJson["trips"]
                    
                    self.trips = [Trip]()
                    
                    for dictionary in tripsArray as! [[String: AnyObject]] {
                        let trip = Trip()
                        trip.title = dictionary["name"] as! String?
                        trip.numberOfLikes = dictionary["trip_likes_count"] as! NSNumber?
                        trip.thumbnailImageURL = dictionary["thumbnail_image_url"] as! String?
                        
                        
                        // User Data
                        // ---------------------
                        let userDict = dictionary["user"] as! [String: AnyObject]
                        let user = User()
                        user.name = userDict["name"] as! String?
                        
                        let profilePic = userDict["profile_pic"] as! [String: AnyObject]
                        user.profileImageURL = profilePic["url"] as! String?
                        // --------User Data----------
                        
                        trip.user = user
                        
                        self.trips?.append(trip)
                    }
                    
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                    
                    return
                }
                catch let error as NSError {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trips?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! TripCell
        cell.trip = trips?[indexPath.item]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 +  88 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

