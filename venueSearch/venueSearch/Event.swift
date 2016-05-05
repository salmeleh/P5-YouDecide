//
//  Event.swift
//  venueSearch
//
//  Created by Stu Almeleh on 5/5/16.
//  Copyright © 2016 Stu Almeleh. All rights reserved.
//

import Foundation

struct Event {
    
    //MARK: Properties
    var type: String
    var status: String
    var displayName: String
    var start: [String : String]
    var popularity: Double
    var location: [String: String]
    var uri: String
    var performance: [String : AnyObject]
    var ageRestriction: String
    var venue: String
    
    
    //MARK: Init
    init(dictionary: [String : AnyObject]) {
        self.type = dictionary[SongKickClient.JSONResponseKeys.Country] as! String
        self.status = dictionary[SongKickClient.JSONResponseKeys.Status] as! String
        self.displayName = dictionary[SongKickClient.JSONResponseKeys.DisplayName] as! String
        self.start = dictionary[SongKickClient.JSONResponseKeys.Start] as! [String : String]
        self.popularity = dictionary[SongKickClient.JSONResponseKeys.Popularity] as! Double
        self.location = dictionary[SongKickClient.JSONResponseKeys.Location] as! [String: String]
        self.uri = dictionary[SongKickClient.JSONResponseKeys.URI] as! String
        self.performance = dictionary[SongKickClient.JSONResponseKeys.Performance] as! [String : AnyObject]
        self.ageRestriction = dictionary[SongKickClient.JSONResponseKeys.AgeRestriction] as! String
        self.venue = dictionary[SongKickClient.JSONResponseKeys.Venue] as! String
    }
    

    
    
    //MARK: From dict
    
    static func eventsFromDictionary(results: [[String : AnyObject]]) -> [Event] {
        var events = [Event]()
        
        for result in results {
            events.append(Event(dictionary: result))
        }
        
        return events
        
    }
    
    
    
    
    
    
    
}