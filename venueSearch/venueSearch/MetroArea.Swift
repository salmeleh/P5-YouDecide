//
//  MetroArea.swift
//  venueSearch
//
//  Created by Stu Almeleh on 5/4/16.
//  Copyright © 2016 Stu Almeleh. All rights reserved.
//

import Foundation

struct MetroArea {
    
    //MARK: Properites
    var country: String
    var displayName: String
    var id: Int
    var lat: Double
    var lng: Double
    var state: String
    var uri: String
    
    init(dictionary: [String : AnyObject]) {
        self.country = dictionary[SongKickClient.JSONResponseKeys.Country] as! String
        self.displayName = dictionary[SongKickClient.JSONResponseKeys.DisplayName] as! String
        self.id = dictionary[SongKickClient.JSONResponseKeys.ID] as! Int
        self.lat = dictionary[SongKickClient.JSONResponseKeys.Lat] as! Double
        self.lng = dictionary[SongKickClient.JSONResponseKeys.Lng] as! Double
        self.state = dictionary[SongKickClient.JSONResponseKeys.State] as! String
        self.uri = dictionary[SongKickClient.JSONResponseKeys.URI] as! String
        
    }
    
    
    static func metroAreasFromDictionary(results: [[String : AnyObject]]) -> [MetroArea] {
        var locations = [MetroArea]()
        
        for result in results {
            locations.append(MetroArea(dictionary: result))
        }
        
        return locations
        
    }
    
    
}