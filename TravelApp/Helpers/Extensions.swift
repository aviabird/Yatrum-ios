//
//  Extensions .swift
//  YoutubeClone
//
//  Created by Pankaj Rawat on 20/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static func appBaseColor() -> UIColor {
        return rgb(red: 0, green: 163, blue: 136, alpha: 0.95)
    }
    
    static func appSecondaryColor() -> UIColor {
        return rgb(red: 247, green: 84, blue: 56, alpha: 1)
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        for(index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    func addBackground(imageName: String) {
        // screen width and height:
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.image = UIImage(named: imageName)
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.scaleAspectFill
        
        self.addSubview(imageViewBackground)
        self.sendSubview(toBack: imageViewBackground)
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        
        imageUrlString = urlString
        
        image = nil
        backgroundColor = UIColor.gray
        
        let url = NSURL(string: urlString)
        let configuration = URLSessionConfiguration.default
        
        let urlRequest = URLRequest(url: url as! URL)
        
        let session = URLSession(configuration: configuration)
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        session.dataTask(with: urlRequest) { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
                return
            } else {
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data!)
                    
                    if self.imageUrlString == urlString {
                        self.image = imageToCache
                    }
                    
                    if imageToCache != nil {
                        imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                    }
                }
                return
            }
        }.resume()
    }
}
