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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    // MARK: UITableViewController Methods
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellReuseIdentifier = "venueTVC"
        let venue = venues[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier) as UITableViewCell!
        
        cell.textLabel!.text = venue.displayName
        cell.detailTextLabel!.text = venue.street

        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //pull up calendar of events for venue
        let venueID = venues[indexPath.row].id
        SongKickClient.sharedInstance().getVenueCalendar(venueID, completionHandler: handlerForGetVenueCalendar)

    }
    

    func handlerForGetVenueCalendar(result: [Event]?, error: String?) -> Void {
        if error == nil {
            print("getVenueCalendar returned no error. # of events: \((result?.count)!)")
            self.events = result!
            self.performSegueWithIdentifier("showVenueCalendarTVC", sender: nil)
        }
        else {
            dispatch_async(dispatch_get_main_queue(), {
                //self.loadingWheel.stopAnimating()
                self.launchAlertController(error!)
            })
        }
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showVenueCalendarTVC") {
            let viewController = segue.destinationViewController as! VenueCalendarTableView
            viewController.events = events
            viewController.venues = venues
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


