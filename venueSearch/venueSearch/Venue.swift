//
//  Venue.swift
//  venueSearch
//
//  Created by Stu Almeleh on 5/9/16.
//  Copyright © 2016 Stu Almeleh. All rights reserved.
//

import CoreData

@objc(Venue)

class Venue : NSManagedObject {
    
    //MARK: Properties
    @NSManaged var displayName: String
    @NSManaged var id: Int
    @NSManaged var lat: Double
    @NSManaged var lng: Double
    @NSManaged var street: String
    //var events: [Event]
    
    
    
    //MARK: Init
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(dictionary: [String : AnyObject], context: NSManagedObjectContext) {
        //core data
        let entity =  NSEntityDescription.entityForName("Venue", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        //dictionary
        displayName = dictionary[SongKickClient.JSONResponseKeys.DisplayName] as! String
        id = dictionary[SongKickClient.JSONResponseKeys.ID] as! Int
        lat = dictionary[SongKickClient.JSONResponseKeys.Lat] as! Double
        lng = dictionary[SongKickClient.JSONResponseKeys.Lng] as! Double
        street = dictionary[SongKickClient.JSONResponseKeys.Street] as! String
    }
    
    //MARK: From dict
    static func venuesFromDictionary(results: [[String : AnyObject]]) -> [Venue] {
        var venues = [Venue]()
        
        for result in results {
            venues.append(Venue(dictionary: result))
        }
        
        return venues
        
    }
    
    
}