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

    
    var tapRecognizer: UITapGestureRecognizer? = nil
    var zipLat: Double = 0.0
    var zipLon: Double = 0.0
    var userLocality: String = ""
    var userSubLocality: String = ""


    
    //MARK: view...
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(SearchView.handleSingleTap(_:)))
        tapRecognizer?.numberOfTapsRequired = 1
        
        loadingWheel.hidesWhenStopped = true
        loadingWheel.hidden = true
        
        zipTextField.delegate = self
        
//        /////temporarily hardcode coordiantes for testing (Wrigley Field)//////
//        zipLat = 41.9484
//        zipLon = -87.6553
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


    //MARK: textField delegate methods
    //via http://stackoverflow.com/questions/433337/set-the-maximum-character-length-of-a-uitextfield
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if(textField.text?.characters.count < 5) {return true}
        else {
            //calculate lat lng
            forwardGeocoding(zipTextField.text!)
            return false
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.text?.characters.count == 5 {
            forwardGeocoding(zipTextField.text!)
            searchButtonPressed(UIButton)
        }

        return true
    }
    
    
    //MARK: searchButtonPressed
    @IBAction func searchButtonPressed(sender: AnyObject) {
        print("searchButtonPressed")
        
        if zipTextField.text?.characters.count < 5 {
            launchAlertController("invalid zip code")
            return
        }
        
        if userLocality == "" {
            print("hit search agian")
            return
        }
        
        
        //start loading animation
        loadingWheel.hidden = false
        loadingWheel.startAnimating()
        
        
        //start songkick metroarea search
        //SongKickClient.sharedInstance().getMetroAreaID(zipLat, lon: zipLon, completionHandler: handlerForGetMetroArea)
        
        //start songkick venue search
        if userSubLocality == "" {
            SongKickClient.sharedInstance().getVenues(userLocality, completionHandler: handlerForGetVenues)
        }
        else {
            SongKickClient.sharedInstance().getVenues(userSubLocality, completionHandler: handlerForGetVenues)
        }
    }
    

    
    //MARK: completionhandlers
    func handlerForGetMetroArea(metroAreaID: Int?, error: String?) -> Void {
        if error == nil {
            print("getMetroArea returned no error. metroAreaID is: \(metroAreaID!)")
            //getMAEvents
            SongKickClient.sharedInstance().getMAEvents(metroAreaID!, completionHandler: handlerForGetMAEvents)
            
        }
        else {
            dispatch_async(dispatch_get_main_queue(), {
                self.loadingWheel.stopAnimating()
                self.launchAlertController(error!)
            })
        }
    }
    
    
    
    func handlerForGetMAEvents(result: [Event]?, error: String?) -> Void {
        if error == nil {
            print("getMetroAreaEvents returned no error. # of events: \((result?.count)!)")
            self.events = result!
            getMetroAreaEventsComplete()
        }
        else {
            dispatch_async(dispatch_get_main_queue(), {
                self.loadingWheel.stopAnimating()
                self.launchAlertController(error!)
            })
        }
    }
    
    
    func handlerForGetVenues(result: [Venue]?, error: String?) -> Void {
        if error == nil {
            print("getVenues returned no error. # of venues: \((result?.count)!)")
            self.venues = result!
            getMetroAreaEventsComplete()
        }
        else {
            dispatch_async(dispatch_get_main_queue(), {
                self.loadingWheel.stopAnimating()
                self.launchAlertController(error!)
            })
        }
    }
    
    
    
    
    func getMetroAreaEventsComplete() {
        dispatch_async(dispatch_get_main_queue(), {
            //stop loading animation
            self.loadingWheel.stopAnimating()
            
            //show venueTableView
            self.performSegueWithIdentifier("ShowVenueTableVC", sender: nil)
        })
        
        
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowVenueTableVC") {
            let viewController = segue.destinationViewController as! VenueTableView
            viewController.events = events
        }
    }
    
    
    
    
    
    
    //MARK: forwardGeocoding
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
                self.userSubLocality = placemark!.subLocality!
                self.userLocality = placemark!.locality!
                let coordinate = location?.coordinate
                self.zipLat = coordinate!.latitude
                self.zipLon = coordinate!.longitude
                print("lat: \(self.zipLat), lon: \(self.zipLon)")
                print("sublocality: \(self.userSubLocality)")
                print("locality: \(self.userLocality)")
                return
            }
        })
    }
    
    
    
    
    
    
    
    
    //MARK: launchAlertController
    /* shows alert view with error */
    func launchAlertController(error: String) {
        let alertController = UIAlertController(title: "", message: error, preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "Dismiss", style: .Default) { (action) in
            //self.dismissViewControllerAnimated(true, completion: nil)
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

