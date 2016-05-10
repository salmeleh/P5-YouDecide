//
//  Venue.swift
//  venueSearch
//
//  Created by Stu Almeleh on 5/9/16.
//  Copyright © 2016 Stu Almeleh. All rights reserved.
//

import Foundation
import CoreData

struct Venue {
    
    //MARK: Properties
    var displayName = ""
    var id = 0
    var lat: Double?
    var lng: Double?
    var street = ""
    //var events: [Event]
    
    
    
    //MARK: Init
    init(dictionary: [String : AnyObject]) {
        displayName = dictionary[SongKickClient.JSONResponseKeys.DisplayName] as! String
        id = dictionary[SongKickClient.JSONResponseKeys.ID] as! Int
        lat = dictionary[SongKickClient.JSONResponseKeys.Lat] as? Double
        lng = dictionary[SongKickClient.JSONResponseKeys.Lng] as? Double
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