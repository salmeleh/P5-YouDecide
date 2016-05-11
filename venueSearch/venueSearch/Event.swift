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
    @NSManaged var start: [String : AnyObject]
    @NSManaged var popularity: Double
    @NSManaged var location: [String: AnyObject]
    @NSManaged var id: Int64
    @NSManaged var performance: [[String : AnyObject]]
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
        start = dictionary[SongKickClient.JSONResponseKeys.Start] as! [String : AnyObject]
        popularity = dictionary[SongKickClient.JSONResponseKeys.Popularity] as! Double
        location = dictionary[SongKickClient.JSONResponseKeys.Location] as! [String: AnyObject]
        id = dictionary[SongKickClient.JSONResponseKeys.ID] as! Int64
        performance = dictionary[SongKickClient.JSONResponseKeys.Performance] as! [[String : AnyObject]]
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