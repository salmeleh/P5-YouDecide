//
//  SongKickConstants.swift
//  venueSearch
//
//  Created by Stu Almeleh on 5/4/16.
//  Copyright © 2016 Stu Almeleh. All rights reserved.
//

import Foundation

extension SongKickClient {
    
    
    //MARK: Constants
    struct Constants {
        static let songKickBaseURL: String = "http://api.songkick.com/api/3.0/"
        static let apiKey: String = "hI5oKbHPO5Z1U8FY"
    }
    
    //MARK: Methods
    struct Methods {
        static let location = "search/locations.json"
        static let metroaAreas = "metro_areas/"
        
    }
    
    //MARK: JSON Body Keys
    struct JSONResponseKeys {
        static let City = "city"
        static let Country = "country"
        static let Lat = "lat"
        static let Lng = "lng"
        static let State = "state"
        static let MetroArea = "metroArea"
        static let ID = "is"
        static let URI = "uri"
        static let DisplayName = "displayName"
    }
    
    
}