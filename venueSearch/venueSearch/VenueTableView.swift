//
//  VenueTableView.swift
//  venueSearch
//
//  Created by Stu Almeleh on 5/4/16.
//  Copyright © 2016 Stu Almeleh. All rights reserved.
//

import UIKit
import CoreData

class VenueTableView: UITableViewController {
    
    var events: [Event] = [Event]()
    var venues: [Venue] = [Venue]()
    
    
    @IBOutlet weak var loadingWheel: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        loadingWheel.hidesWhenStopped = true
        loadingWheel.hidden = true
        
        self.navigationController!.navigationBar.tintColor = UIColor(red: 248/255, green: 0, blue: 70/255, alpha: 1)

    }
    
    
    // MARK: UITableViewController Methods
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellReuseIdentifier = "venueTVC"
        let venue = venues[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier) as! VenuteTableViewCell
        
        cell.titleLabel.text = venue.displayName
        cell.detailLabel.text = venue.street

        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //pull up calendar of events for venue
        let selectedVenue = venues[indexPath.row]
        self.performSegueWithIdentifier("showVenueCalendarTVC", sender: selectedVenue)

    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showVenueCalendarTVC") {
            let viewController = segue.destinationViewController as! VenueCalendarTableView
            viewController.selectedVenue = sender as! Venue
        }
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
    
    
    
}


