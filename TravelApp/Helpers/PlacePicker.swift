//
//  PlacePicker.swift
//  TravelApp
//
//  Created by rawat on 18/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit
import GooglePlaces

extension CreateTripController: GMSAutocompleteViewControllerDelegate {
    
    func autocompleteClicked() {
        let autocompleteController = GMSAutocompleteViewController()
        
        autocompleteController.delegate = self
        autocompleteController.tableCellBackgroundColor = UIColor.appBaseColor()
        autocompleteController.tableCellSeparatorColor = UIColor.appMainBGColor()
        autocompleteController.primaryTextColor = UIColor.lightGray
        autocompleteController.primaryTextHighlightColor = UIColor.appCallToActionColor()
        autocompleteController.secondaryTextColor = UIColor.lightGray
        autocompleteController.tintColor = UIColor.appLightBlue()
        
        present(autocompleteController, animated: true, completion: nil)
    }
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        selectedPlaceEditCell?.placeViewBadgeTitleLabel.text = place.name
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
