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
    var start: [String : AnyObject]
    var popularity: Double
    var location: [String: AnyObject]
    var uri: String
    var id: Int
    var performance: [String : AnyObject]
    var ageRestriction: String
    var venue: [String : AnyObject]
    
    
    //MARK: Init
    init(dictionary: [String : AnyObject]) {
        self.type = dictionary[SongKickClient.JSONResponseKeys.Country] as! String
        self.status = dictionary[SongKickClient.JSONResponseKeys.Status] as! String
        self.displayName = dictionary[SongKickClient.JSONResponseKeys.DisplayName] as! String
        self.start = dictionary[SongKickClient.JSONResponseKeys.Start] as! [String : AnyObject]
        self.popularity = dictionary[SongKickClient.JSONResponseKeys.Popularity] as! Double
        self.location = dictionary[SongKickClient.JSONResponseKeys.Location] as! [String: AnyObject]
        self.uri = dictionary[SongKickClient.JSONResponseKeys.URI] as! String
        self.id = dictionary[SongKickClient.JSONResponseKeys.ID] as! Int
        self.performance = dictionary[SongKickClient.JSONResponseKeys.Performance] as! [String : AnyObject]
        self.ageRestriction = dictionary[SongKickClient.JSONResponseKeys.AgeRestriction] as! String
        self.venue = dictionary[SongKickClient.JSONResponseKeys.Venue] as! [String : AnyObject]
    }
    

    
    
    //MARK: From dict
    
    static func eventsFromDictionary(results: [[String : AnyObject]]) -> [Event] {
        print("eventsFromDictionary called")
        var calendar = [Event]()
        
        for result in results {
            calendar.append(Event(dictionary: result))
        }
        
        return calendar
        
    }
    
    
    
    
    
    
    
}