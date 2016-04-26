//
//  EdmundsConstants.swift
//  carSearch
//
//  Created by Stu Almeleh on 4/26/16.
//  Copyright © 2016 Stu Almeleh. All rights reserved.
//

import Foundation

extension EdmundsClient {
    
    //MARK: Constants
    struct Constants {
        static let edmundsBaseURL: String = "https://api.edmunds.com/api/vehicle/v2/"
        static let APIkey: String = "uxjksbmg9e78achw7ry5vkjt"
    }
    
    //MARK: Methods
    struct Methods {
        static let Makes = "makes"
        static let Model = "model"
        static let Style = "style"
    }
    
    //MARK: Parameters
    struct Parameters {
        static let State = "state"
        static let Year = "year"
    }
    
    //MARK: JSON Body Keys
    struct JSONBodyKeys {
        
    }
    
    
    //MARK: JSON Response Keys
    struct JSONResponseKeys {
        static let Make = "make"
        static let Model = "model"
        static let Year = "year"
        static let Trim = "trim"
        static let Style = "style"

    }
    
    
    
    
    
    
    
}