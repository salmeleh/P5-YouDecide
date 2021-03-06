//
//  Event.swift
//  venueSearch
//
//  Created by Stu Almeleh on 5/5/16.
//  Copyright © 2016 Stu Almeleh. All rights reserved.
//

import Foundation
import CoreData

@objc(Event)

class Event : NSManagedObject {
    
    //MARK: Properties
    @NSManaged var displayName: String
    //@NSManaged var start: [String : AnyObject]
    @NSManaged var popularity: Double
    //@NSManaged var location: [String: AnyObject]
    @NSManaged var id: Int
    //@NSManaged var performance: [[String : AnyObject]]
    @NSManaged var uri: String
    @NSManaged var venue: Venue
    
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    //MARK: Init
    init(dictionary: [String : AnyObject], context: NSManagedObjectContext) {
        
        //Core Data
        let entity =  NSEntityDescription.entityForName("Event", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        
        //Dictionary
        displayName = dictionary[SongKickClient.JSONResponseKeys.DisplayName] as! String
        //start = dictionary[SongKickClient.JSONResponseKeys.Start] as! [String : AnyObject]
        popularity = dictionary[SongKickClient.JSONResponseKeys.Popularity] as! Double
        //location = dictionary[SongKickClient.JSONResponseKeys.Location] as! [String: AnyObject]
        id = dictionary[SongKickClient.JSONResponseKeys.ID] as! Int
        //performance = dictionary[SongKickClient.JSONResponseKeys.Performance] as! [[String : AnyObject]]
        //venue = dictionary[SongKickClient.JSONResponseKeys.Venue] as! Venue
        uri = dictionary[SongKickClient.JSONResponseKeys.URI] as! String
    }
    

    
    
    //MARK: from dict
    static func eventsFromDictionary(results: [[String : AnyObject]], context: NSManagedObjectContext) -> [Event] {
        var calendar = [Event]()
                
        for result in results {
            calendar.append(Event(dictionary: result, context: context))
        }
        
        return calendar
        
    }
    
    
    
    
    
    
    
}