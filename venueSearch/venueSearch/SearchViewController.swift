//
//  SearchView.swift
//  venueSearch
//
//  Created by Stu Almeleh on 5/4/16.
//  Copyright © 2016 Stu Almeleh. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class SearchView: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var loadingWheel: UIActivityIndicatorView!
    var events: [Event] = [Event]()
    var venues: [Venue] = [Venue]()

    @IBOutlet weak var imageView: UIImageView!
    
    var tapRecognizer: UITapGestureRecognizer? = nil
    var zipLat: Double = 0.0
    var zipLon: Double = 0.0
    var userLocality: String? = ""
    var userSubLocality: String? = ""

    var isNewLocation: Bool = true

    
    //MARK: view...
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(SearchView.handleSingleTap(_:)))
        tapRecognizer?.numberOfTapsRequired = 1
        
        loadingWheel.hidesWhenStopped = true
        loadingWheel.hidden = true
        
        zipTextField.delegate = self
        
        imageView.image = UIImage(named: "skSmallBadge")
        
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        //add tap recognizer
        self.addKeyboardDismissRecognizer()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        //remove tap recognizer
        self.removeKeyboardDismissRecognizer()
    }

    
    
    //MARK: shared instance
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    

    //MARK: textField delegate methods
    func textFieldDidBeginEditing(textField: UITextField) {
        isNewLocation = true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //textField.text?.characters.count == 5
        searchButtonPressed(UIButton)
        return true
    }
    
    
    
    
    //MARK: searchButtonPressed
    @IBAction func searchButtonPressed(sender: AnyObject) {
        
        if zipTextField.text?.characters.count !== 5 {
            launchAlertController("invalid zip code")
            return
        }
        
        forwardGeocoding(zipTextField.text!, completionHandler: handlerForForwardGeocoding)

//
//        if userLocality == "" {
//            launchAlertController("press search again")
//            return
//        }
        

        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowVenueTableVC") {
            let viewController = segue.destinationViewController as! VenueTableView
            viewController.userLocality = sender as! String
            viewController.isNewLocation = self.isNewLocation
        }
    }
    
    
    func handlerForForwardGeocoding(error: String?) -> Void {
        if error == nil {
            dispatch_async(dispatch_get_main_queue(), {
                self.loadingWheel.stopAnimating()
            })
            performSegueWithIdentifier("ShowVenueTableVC", sender: userLocality)
        }
        
    }
    
    
    
    
    
    
    //MARK: forwardGeocoding
    //via http://mhorga.org/2015/08/14/geocoding-in-ios.html
    func forwardGeocoding(address: String, completionHandler: (error: String?) -> Void ) {
        dispatch_async(dispatch_get_main_queue(), {
            self.loadingWheel.hidden = false
            self.loadingWheel.startAnimating()
        })
        
        CLGeocoder().geocodeAddressString(address, completionHandler: { (placemarks, error) in
            completionHandler(error: "no userLocality yet")
            if error != nil {
                self.loadingWheel.stopAnimating()
                self.launchAlertController(String(error))
            }
            if placemarks?.count > 0 {
                let placemark = placemarks?[0]
                self.userSubLocality = placemark?.subLocality
                self.userLocality = placemark?.locality
                print("\((self.userLocality)!) = userLocality in fG")
                completionHandler(error: nil)
                let location = placemark?.location
                let coordinate = location?.coordinate
                self.zipLat = coordinate!.latitude
                self.zipLon = coordinate!.longitude
                
            }

        })
        
    }
    

    
    
    
    
    
    //MARK: launchAlertController
    /* shows alert view with error */
    func launchAlertController(error: String) {
        let alertController = UIAlertController(title: "", message: error, preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "Dismiss", style: .Default) { (action) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true) {
            
        }
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SearchView.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SearchView.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
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

