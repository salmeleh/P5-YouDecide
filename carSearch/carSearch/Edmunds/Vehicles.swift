//
//  Vehicles.swift
//  carSearch
//
//  Created by Stu Almeleh on 4/26/16.
//  Copyright © 2016 Stu Almeleh. All rights reserved.
//

import Foundation

class Vehicles {
    
    var vehicles: [VehicleInfo] = [VehicleInfo]()
    
    class func sharedInstance() -> Vehicles {
        
        struct Singleton {
            static var sharedInstance = Vehicles()
        }
        
        return Singleton.sharedInstance
        
    }
}