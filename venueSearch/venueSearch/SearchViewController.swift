//
//  SearchView.swift
//  venueSearch
//
//  Created by Stu Almeleh on 5/4/16.
//  Copyright © 2016 Stu Almeleh. All rights reserved.
//

import UIKit
import CoreLocation

class SearchView: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    var tapRecognizer: UITapGestureRecognizer? = nil
    var zipLat: Double = 0.0
    var zipLon: Double = 0.0

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        zipTextField.delegate = self
        
        tapRecognizer = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        tapRecognizer?.numberOfTapsRequired = 1
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        /* Add tap recognizer to dismiss keyboard */
        self.addKeyboardDismissRecognizer()
        
        /* Subscribe to keyboard events so we can adjust the view to show hidden controls */
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        /* Remove tap recognizer */
        self.removeKeyboardDismissRecognizer()
        
        /* Unsubscribe to all keyboard events */
        self.unsubscribeToKeyboardNotifications()
    }



    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.zipTextField {
            searchButtonPressed(UIButton)
        }
        return true
    }
    
    //via http://stackoverflow.com/questions/433337/set-the-maximum-character-length-of-a-uitextfield
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if(textField.text?.characters.count < 5) {return true}
        else {return false}
        
    }
    
    
    @IBAction func searchButtonPressed(sender: AnyObject) {
        print("searchButtonPressed")
        
        //calculate lat lng
        forwardGeocoding(zipTextField.text!)
        
        //start songkick search
        SongKickClient.sharedInstance().getMetroAreaID(zipLat, lon: zipLon, completionHandler: handlerForGetMetroArea)
        
        
    }
    
    
    func handlerForGetMetroArea(result: [MetroArea]?, error: String?) -> Void {
        if error == "" {
            getMetroAreaComplete()
        }
        else {
//            dispatch_async(dispatch_get_main_queue(), {
//                self.loadingWheel.stopAnimating()
//                self.loginButton.hidden = false
//                self.launchAlertController(error)
//            })
        }
    }

    func getMetroAreaComplete() {
        dispatch_async(dispatch_get_main_queue(), {
            //stop loading animation
            //self.loadingWheel.stopAnimating()
            
            //show venueTableView
            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("VenueTableView") as! UITableViewController
            self.presentViewController(controller, animated: true, completion: nil)
        })
        
        
    }
    
    
    
    //via http://mhorga.org/2015/08/14/geocoding-in-ios.html
    func forwardGeocoding(address: String) {
        CLGeocoder().geocodeAddressString(address, completionHandler: { (placemarks, error) in
            if error != nil {
                print(error)
                return
            }
            if placemarks?.count > 0 {
                let placemark = placemarks?[0]
                let location = placemark?.location
                let coordinate = location?.coordinate
                let zipLat: Double = coordinate!.latitude
                let zipLon: Double = coordinate!.longitude
                print("lat: \(zipLat), lon: \(zipLon)")
            }
        })
    }
    
    
    
    
    
    
    
    // MARK: Show/Hide Keyboard
    func addKeyboardDismissRecognizer() {
        self.view.addGestureRecognizer(tapRecognizer!)
    }
    
    func removeKeyboardDismissRecognizer() {
        self.view.removeGestureRecognizer(tapRecognizer!)
    }
    
    func handleSingleTap(recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0.0 {
            self.view.frame.origin.y -= self.getKeyboardHeight(notification) / 2
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0.0 {
            self.view.frame.origin.y += self.getKeyboardHeight(notification) / 2
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }

    
    
    
}

