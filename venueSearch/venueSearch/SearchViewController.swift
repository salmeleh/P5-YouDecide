//
//  SearchView.swift
//  venueSearch
//
//  Created by Stu Almeleh on 5/4/16.
//  Copyright © 2016 Stu Almeleh. All rights reserved.
//

import UIKit

class SearchView: UIViewController {

    //MARK: Properties
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    var tapRecognizer: UITapGestureRecognizer? = nil

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
<<<<<<< HEAD
        zipTextField.delegate = self
        
//        tapRecognizer = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
//        tapRecognizer?.numberOfTapsRequired = 1
=======
        tapRecognizer = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        tapRecognizer?.numberOfTapsRequired = 1
>>>>>>> parent of 7c0cbb0... starting API call
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        
//        /* Add tap recognizer to dismiss keyboard */
//        self.addKeyboardDismissRecognizer()
//        
//        /* Subscribe to keyboard events so we can adjust the view to show hidden controls */
//        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
//        /* Remove tap recognizer */
//        self.removeKeyboardDismissRecognizer()
//        
//        /* Unsubscribe to all keyboard events */
//        self.unsubscribeToKeyboardNotifications()
    }



    
    
    
    
    
    @IBAction func searchButtonPressed(sender: AnyObject) {
        print("searchButtonPressed")
<<<<<<< HEAD
        
        //calculate lat lng
        forwardGeocoding(zipTextField.text!)
        
        //start songkick search
        //SongKickClient.sharedInstance().getMetroAreaID(zipLat, lon: zipLon, completionHandler: handlerForGetMetroArea)
        
        
=======
>>>>>>> parent of 7c0cbb0... starting API call
    }
    

    
    
    
    
    
//    // MARK: Show/Hide Keyboard
//    func addKeyboardDismissRecognizer() {
//        self.view.addGestureRecognizer(tapRecognizer!)
//    }
//    
//    func removeKeyboardDismissRecognizer() {
//        self.view.removeGestureRecognizer(tapRecognizer!)
//    }
//    
//    func handleSingleTap(recognizer: UITapGestureRecognizer) {
//        self.view.endEditing(true)
//    }
//    
//    func subscribeToKeyboardNotifications() {
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
//    }
//    
//    func unsubscribeToKeyboardNotifications() {
//        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
//    }
//    
//    func keyboardWillShow(notification: NSNotification) {
//        if self.view.frame.origin.y == 0.0 {
//            self.view.frame.origin.y -= self.getKeyboardHeight(notification) / 2
//        }
//    }
//    
//    func keyboardWillHide(notification: NSNotification) {
//        if self.view.frame.origin.y != 0.0 {
//            self.view.frame.origin.y += self.getKeyboardHeight(notification) / 2
//        }
//    }
//    
//    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
//        let userInfo = notification.userInfo
//        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
//        return keyboardSize.CGRectValue().height
//    }

    
    
    
}

