//
//  Extensions .swift
//  YoutubeClone
//
//  Created by Pankaj Rawat on 20/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit
import SwiftDate

extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}

extension UITextField {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static func appBaseColor() -> UIColor {
        return rgb(red: 44, green: 62, blue: 80)
    }
    
    static func appCallToActionColor() -> UIColor {
        return rgb(red: 231, green: 76, blue: 60)
    }
    
    static func appMainBGColor() -> UIColor {
        return rgb(red: 236, green: 240, blue: 241)
    }
    
    static func appLightBlue() -> UIColor {
        return rgb(red: 52, green: 152, blue: 219)
    }
    
    static func appDarkBlue() -> UIColor {
        return rgb(red: 41, green: 128, blue: 185)
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
    
    func loadImageUsingUrlString(urlString: String, width: Float) {
        
        // Change width of image
        var urlString = urlString
        let regex = try! NSRegularExpression(pattern: "upload", options: NSRegularExpression.Options.caseInsensitive)
        let range = NSMakeRange(0, urlString.characters.count)
        urlString = regex.stringByReplacingMatches(in: urlString,
                                                               options: [],
                                                               range: range,
                                                               withTemplate: "upload/w_\(Int(width * 1.5))")
        
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

//MARK: - UITextView
extension UITextView{
    
    func numberOfLines() -> Int{
        if let fontUnwrapped = self.font{
            return Int(self.contentSize.height / fontUnwrapped.lineHeight)
        }
        return 0
    }
    
}

extension String {
    func humanizeDate(format: String = "MM-dd-yyyy HH:mm:ss") -> String {
        //"yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale.init(identifier: "en_GB")
        let dateObj = dateFormatter.date(from: self)
        
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: dateObj!)
    }
    
    func relativeDate() -> String {
        
        let date = try! DateInRegion(string: humanizeDate(), format: .custom("MM-dd-yyyy HH:mm:ss"))
        let relevantTime = try! date.colloquialSinceNow().colloquial
        
        return relevantTime
    }
}

extension CreateTripController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func handleSelectTripImage() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let imagePicked = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            self.tripEditForm.thumbnailImageView.image = imagePicked
            statusBarBackgroundView.alpha = 0
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
