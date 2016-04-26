//
//  VehicleInfo.swift
//  carSearch
//
//  Created by Stu Almeleh on 4/26/16.
//  Copyright © 2016 Stu Almeleh. All rights reserved.
//

import Foundation

struct VehicleInfo {
    
    //MARK: Properties
    var Make: String
    var Model: String
    var Year: Int
    var Trim: String
    var Style: String
    
    
    
    //MARK: Init with dictionary
    init(dictionary: [String : AnyObject]) {
        
        self.Make = dictionary[EdmundsClient.JSONResponseKeys.Make] as! String
        self.Model = dictionary[EdmundsClient.JSONResponseKeys.Model] as! String
        self.Year = dictionary[EdmundsClient.JSONResponseKeys.Year] as! Int
        self.Trim = dictionary[EdmundsClient.JSONResponseKeys.Trim] as! String
        self.Style = dictionary[EdmundsClient.JSONResponseKeys.Style] as! String
    }
    
    
    /* Given an array of dictionaries, convert to an array of StudentInfos */
    static func vehiclesFromDictionary(results: [[String : AnyObject]]) -> [VehicleInfo] {
        var vehicles = [VehicleInfo]()
        
        for result in results {
            vehicles.append(VehicleInfo(dictionary: result))
        }
        
        return vehicles
    }
    
    
}