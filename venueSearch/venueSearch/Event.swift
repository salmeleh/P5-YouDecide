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
    var displayName = ""
    var start: [String : AnyObject]
    var popularity = 0.0
    var location: [String: AnyObject]
    var id = 0
    var performance: [[String : AnyObject]]
    var venue: [String : AnyObject]
    
    
    //MARK: Init
    init(dictionary: [String : AnyObject]) {
        displayName = dictionary[SongKickClient.JSONResponseKeys.DisplayName] as! String
        start = dictionary[SongKickClient.JSONResponseKeys.Start] as! [String : AnyObject]
        popularity = dictionary[SongKickClient.JSONResponseKeys.Popularity] as! Double
        location = dictionary[SongKickClient.JSONResponseKeys.Location] as! [String: AnyObject]
        id = dictionary[SongKickClient.JSONResponseKeys.ID] as! Int
        performance = dictionary[SongKickClient.JSONResponseKeys.Performance] as! [[String : AnyObject]]
        venue = dictionary[SongKickClient.JSONResponseKeys.Venue] as! [String : AnyObject]
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