//
//  Location.swift
//  venueSearch
//
//  Created by Stu Almeleh on 5/4/16.
//  Copyright © 2016 Stu Almeleh. All rights reserved.
//

import CoreData

@objc(Location)

class Location : NSManagedObject {
    
    //MARK: Properites
    @NSManaged var country: String
    @NSManaged var displayName: String
    @NSManaged var id: Int
    @NSManaged var lat: Double
    @NSManaged var lng: Double
    @NSManaged var state: String
    @NSManaged var uri: String
    
    
    //MARK: init
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(dictionary: [String : AnyObject], context: NSManagedObjectContext) {
        //core data
        let entity =  NSEntityDescription.entityForName("Location", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        //dicitonary
        country = dictionary[SongKickClient.JSONResponseKeys.Country] as! String
        displayName = dictionary[SongKickClient.JSONResponseKeys.DisplayName] as! String
        id = dictionary[SongKickClient.JSONResponseKeys.ID] as! Int
        lat = dictionary[SongKickClient.JSONResponseKeys.Lat] as! Double
        lng = dictionary[SongKickClient.JSONResponseKeys.Lng] as! Double
        state = dictionary[SongKickClient.JSONResponseKeys.State] as! String
        uri = dictionary[SongKickClient.JSONResponseKeys.URI] as! String
        
    }
    
    //MARK: from dict
    static func locationsFromDictionary(results: [[String : AnyObject]], context: NSManagedObjectContext) -> [Location] {
        var locations = [Location]()
        
        for result in results {
            locations.append(Location(dictionary: result, context: context))
        }
        
        return locations
        
    }
    
    
}