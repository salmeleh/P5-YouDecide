//
//  SongKickConstants.swift
//  venueSearch
//
//  Created by Stu Almeleh on 5/4/16.
//  Copyright © 2016 Stu Almeleh. All rights reserved.
//

import Foundation
import UIKit

extension SongKickClient {
    
    
    //MARK: Constants
    struct Constants {
        static let songKickBaseURL: String = "http://api.songkick.com/api/3.0/"
        static let apiKey: String = "hI5oKbHPO5Z1U8FY"
        static let skPink: UIColor = UIColor(red: 248/255, green: 0, blue: 70/255, alpha: 1)
    }
    
    //MARK: Methods
    struct Methods {
        static let search = "search/"
        static let location = "locations.json"
        static let metroAreas = "metro_areas/"
        static let calendars = "/calendar.json"
        static let venues = "venues.json"
        
    }
    
    //MARK: JSON Body Keys
    struct JSONResponseKeys {
        static let City = "city"
        static let Country = "country"
        static let Lat = "lat"
        static let Lng = "lng"
        static let State = "state"
        static let MetroArea = "metroArea"
        static let ID = "id"
        static let URI = "uri"
        static let DisplayName = "displayName"
        
        static let Status = "status"
        static let Start = "start"
        static let Popularity = "popularity"
        static let Location = "location"
        static let Performance = "performance"
        static let AgeRestriction = "ageRestriction"
        static let Venue = "venue"
        
        static let Street = "street"
    }
    
    
}