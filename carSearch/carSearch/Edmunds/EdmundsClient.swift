//
//  EdmundsClient.swift
//  carSearch
//
//  Created by Stu Almeleh on 4/26/16.
//  Copyright © 2016 Stu Almeleh. All rights reserved.
//

import Foundation

class EdmundsClient: NSObject {
    
    //MARK: Properties
    var session: NSURLSession
    
    var sessionID : String? = nil
    var userID : Int? = nil
    
    override init() {
        session = NSURLSession.sharedSession()
        super.init()
    }
    
    //MARK: Get Makes
    func getMakes(completionHandler: (result: [VehicleInfo]?, error: String?) -> Void) {
        print("getMakes called")
        let params = ["state": "new", "year": 2016, "fmt": "json", "api_key": EdmundsClient.Constants.APIkey]
        let urlString = EdmundsClient.Constants.edmundsBaseURL + EdmundsClient.Methods.Makes + EdmundsClient.escapedParameters(params as! [String : AnyObject])
        print("urlString: " + urlString)

        let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            guard (error == nil) else {
                completionHandler(result: nil, error: "Connection Error")
                return
            }
            guard let data = data else {
                completionHandler(result: nil, error: "No data was returned")
                return
            }
            
            let parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                //print(parsedResult)
            } catch {
                parsedResult = nil
                print("Could not parse the data as JSON: '\(data)'")
                return
            }
        
            //GUARD: Is the 'makes' key in the parsedResults?
            guard let makesDictionary = parsedResult["makes"] as? NSDictionary else {
                print("Cannot find key 'makes' in parsedResult")
                return
            }
            
            //GUARD: Is the 'makesCount' key in makesDictionary?
            guard let totalMakesVal = parsedResult["makesCount"] as? Int else {
                print("Cannot find key 'makesCount' in parsedResult")
                return
            }
            
            print(totalMakesVal)
            
            
            /* GUARD: Is the "make" key in makesDictionary? */
            guard let idArray = makesDictionary["id"] as? [[String: AnyObject]] else {
                print("Cannot find key 'id' in makesDictionary")
                return
            }
            
            let makeDictionary = idArray[0] as [String: AnyObject]
            let makeName = makeDictionary["name"] as? String
            print(makeName)
            
            
            
            

        }
        task.resume()
    }
    
    
    
    
    
    
    
    //MARK: Helper functions
    /* Raw JSON -> useable object */
    class func parseJSONWithCompletionHandler(data: NSData, completionHandler: (result: AnyObject!, error: String?) -> Void){
        
        var parsedResult: AnyObject!
        do {
            parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
        } catch {
            completionHandler(result: nil, error: "Could not parse the data as JSON")
        }
        completionHandler(result: parsedResult, error: nil)
    }
    
    
    /* URL -> String */
    class func escapedParameters(parameters: [String : AnyObject]) -> String {
        var urlVars = [String]()
        for (key, value) in parameters {
            let stringValue = "\(value)"
            let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            urlVars += [key + "=" + "\(escapedValue!)"]
        }
        return (!urlVars.isEmpty ? "?" : "") + urlVars.joinWithSeparator("&")
    }
    
    
    
    /* MARK: Shared Instance */
    class func sharedInstance() -> EdmundsClient{
        
        struct Singleton {
            static var sharedInstance = EdmundsClient()
        }
        return Singleton.sharedInstance
    }

    
}