//
//  Location.swift
//  venueSearch
//
//  Created by Stu Almeleh on 5/4/16.
//  Copyright © 2016 Stu Almeleh. All rights reserved.
//

import Foundation

struct Location {
    
    //MARK: Properites
    var country: String
    var displayName: String
    var id: Int
    var lat: Double
    var lng: Double
    var state: String
    var uri: String
    
    
    //MARK: init
    init(dictionary: [String : AnyObject]) {
        self.country = dictionary[SongKickClient.JSONResponseKeys.Country] as! String
        self.displayName = dictionary[SongKickClient.JSONResponseKeys.DisplayName] as! String
        self.id = dictionary[SongKickClient.JSONResponseKeys.ID] as! Int
        self.lat = dictionary[SongKickClient.JSONResponseKeys.Lat] as! Double
        self.lng = dictionary[SongKickClient.JSONResponseKeys.Lng] as! Double
        self.state = dictionary[SongKickClient.JSONResponseKeys.State] as! String
        self.uri = dictionary[SongKickClient.JSONResponseKeys.URI] as! String
        
    }
    
    //MARK: from dict
    static func locationsFromDictionary(results: [[String : AnyObject]]) -> [Location] {
        var locations = [Location]()
        
        for result in results {
            locations.append(Location(dictionary: result))
        }
        
        return locations
        
    }
    
    
}