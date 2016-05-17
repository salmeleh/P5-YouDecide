//
//  VenueCalendarTableView.swift
//  venueSearch
//
//  Created by Stu Almeleh on 5/10/16.
//  Copyright © 2016 Stu Almeleh. All rights reserved.
//

import UIKit
import CoreData

class VenueCalendarTableView: UITableViewController {
    
    var selectedVenue: Venue!
    var events: [Event] = [Event]()
    
    @IBOutlet weak var loadingWheel: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingWheel.startAnimating()
        loadingWheel.hidden = false

        self.navigationController!.navigationBar.tintColor = UIColor(red: 248/255, green: 0, blue: 70/255, alpha: 1)
        
        events = fetchAllEvents()
        SongKickClient.sharedInstance().getVenueCalendar(selectedVenue.id, completionHandler: handlerForGetVenueCalendar)
        

    }

    
    //MARK: shared instance
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    
    //MARK: fetchAll
    func fetchAllEvents() -> [Event] {
        let fetchRequest = NSFetchRequest(entityName: "Event")
        do {
            return try sharedContext.executeFetchRequest(fetchRequest) as! [Event]
        } catch let error as NSError {
            print("Error in fetchAllVenues(): \(error)")
            return [Event]()
        }
    }
    
    
    
    // MARK: UITableViewController Methods
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellReuseIdentifier = "venueCalendarTVC"
        let event = events[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier) as UITableViewCell!
        
        cell.textLabel!.text = event.displayName        
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    
    
    
    //MARK: completionHandler for getVenueCalendar
    func handlerForGetVenueCalendar(result: [Event]?, error: String?) -> Void {
        if error == nil {
            print("getVenueCalendar returned no error. # of events: \((result?.count)!)")
            self.events = result!

            for e in events {
                e.venue = selectedVenue
            }
            
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