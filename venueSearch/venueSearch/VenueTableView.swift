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
    
//    var events: [Event] = [Event]()
    var venues: [Venue] = [Venue]()
    var userLocality: String?
    
    
    @IBOutlet weak var loadingWheel: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadingWheel.startAnimating()
        loadingWheel.hidden = false
        self.navigationController!.navigationBar.tintColor = UIColor(red: 248/255, green: 0, blue: 70/255, alpha: 1)

        venues = fetchAllVenues()
        
        SongKickClient.sharedInstance().getVenues(userLocality!, completionHandler: handlerForGetVenues)
        
        
    }
    
    
    //MARK: shared instance
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    
    //MARK: fetch all
    func fetchAllVenues() -> [Venue] {
        let fetchRequest = NSFetchRequest(entityName: "Venue")
        do {
            return try sharedContext.executeFetchRequest(fetchRequest) as! [Venue]
        } catch let error as NSError {
            print("Error in fetchAllVenues(): \(error)")
            return [Venue]()
        }
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
    
    
    
    //MARK: completionHandler for getVenues
    func handlerForGetVenues(result: [Venue]?, error: String?) -> Void {
        if error == nil {
            print("getVenues returned no error. # of venues: \((result?.count)!)")
            self.venues = result!
            
            dispatch_async(dispatch_get_main_queue(), {
                CoreDataStackManager.sharedInstance().saveContext()
            })
            
            tableView.reloadData()
            loadingWheel.stopAnimating()

        }
        else {
            dispatch_async(dispatch_get_main_queue(), {
                self.loadingWheel.stopAnimating()
                self.launchAlertController(error!)
            })
        }
    }
    
    
    
    //MARK: prepareForSegue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showVenueCalendarTVC") {
            let viewController = segue.destinationViewController as! VenueCalendarTableView
            viewController.selectedVenue = sender as! Venue
        }
    }
    
    
    
    
    //MARK: launchAlertController
    func launchAlertController(error: String) {
        let alertController = UIAlertController(title: "", message: error, preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "Dismiss", style: .Default) { (action) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true) {
            
        }
    }
    
    
    
}


