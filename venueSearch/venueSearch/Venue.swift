//
//  Venue.swift
//  venueSearch
//
//  Created by Stu Almeleh on 5/9/16.
//  Copyright © 2016 Stu Almeleh. All rights reserved.
//

import Foundation
import CoreData

@objc(Venue)

class Venue : NSManagedObject {
    
    //MARK: Properties
    @NSManaged var displayName: String
    @NSManaged var id: Int
    @NSManaged var lat: NSNumber?
    @NSManaged var lng: NSNumber?
    @NSManaged var street: String
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    
    //MARK: Init
    init(dictionary: [String : AnyObject], context: NSManagedObjectContext) {
        
        // Core Data
        let entity =  NSEntityDescription.entityForName("Venue", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        //Dictionary
        displayName = dictionary[SongKickClient.JSONResponseKeys.DisplayName] as! String
        id = dictionary[SongKickClient.JSONResponseKeys.ID] as! Int
        lat = dictionary[SongKickClient.JSONResponseKeys.Lat] as? Double
        lng = dictionary[SongKickClient.JSONResponseKeys.Lng] as? Double
        street = dictionary[SongKickClient.JSONResponseKeys.Street] as! String
    }
    
    
    //MARK: from dict
    static func venuesFromDictionary(results: [[String : AnyObject]], context: NSManagedObjectContext) -> [Venue] {
        var venues = [Venue]()
        
        for result in results {
            venues.append(Venue(dictionary: result, context: context))
        }
        
        return venues
        
    }
    
    
}