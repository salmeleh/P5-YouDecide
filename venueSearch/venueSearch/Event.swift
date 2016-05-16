//
//  Event.swift
//  venueSearch
//
//  Created by Stu Almeleh on 5/5/16.
//  Copyright © 2016 Stu Almeleh. All rights reserved.
//
 
import CoreData

@objc(Event)

class Event : NSManagedObject {
    
    //MARK: Properties
    @NSManaged var displayName: String
    @NSManaged var popularity: Double
    @NSManaged var id: Int64
    @NSManaged var venue: Venue?
    
    
    //MARK: Init
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(dictionary: [String : AnyObject], context: NSManagedObjectContext) {
        //core data
        let entity =  NSEntityDescription.entityForName("Event", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        //dictionary
        displayName = dictionary[SongKickClient.JSONResponseKeys.DisplayName] as! String
        popularity = dictionary[SongKickClient.JSONResponseKeys.Popularity] as! Double
        id = dictionary[SongKickClient.JSONResponseKeys.ID] as! Int64
        venue = dictionary[SongKickClient.JSONResponseKeys.Venue] as? Venue
    }
    

    
    
    //MARK: From dict
    static func eventsFromDictionary(results: [[String : AnyObject]], context: NSManagedObjectContext) -> [Event] {
        var calendar = [Event]()
                
        for result in results {
            calendar.append(Event(dictionary: result, context: context))
        }
        
        return calendar
        
    }
    
    
    
    
    
    
    
}