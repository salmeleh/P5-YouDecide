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
    
    var events: [Event] = [Event]()
    var venues: [Venue] = [Venue]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    
    
    
    
}