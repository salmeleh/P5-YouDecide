//
//  SongKickClient.swift
//  venueSearch
//
//  Created by Stu Almeleh on 5/4/16.
//  Copyright © 2016 Stu Almeleh. All rights reserved.
//

import Foundation

class SongKickClient: NSObject {
    
    //MARK: Properties
    var session: NSURLSession
    
    var sessionID : String? = nil
    var userID : Int? = nil
    
    override init() {
        session = NSURLSession.sharedSession()
        super.init()
    }
    
    
    //MARK: getMetroAreaID
    func getMetroAreaID(lat: Double, lon: Double, completionHandler: (result: [MetroArea], error: String) -> Void) {
        print("getMetroAreaID called")
        let params: [String : AnyObject] = ["location": "\(lat),\(lon)", "apikey": SongKickClient.Constants.apiKey]
        let urlString = SongKickClient.Constants.songKickBaseURL + SongKickClient.Methods.location + SongKickClient.escapedParameters(params)
        print("urlString: " + urlString)
        
        let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            guard (error == nil) else {
                completionHandler(result: [], error: "Connection Error")
                return
            }
            guard let data = data else {
                completionHandler(result: [], error: "No data was returned")
                return
            }
            
            let parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                print(parsedResult)
            } catch {
                parsedResult = nil
                print("Could not parse the data as JSON: '\(data)'")
                return
            }
        }
        task.resume()
        
        
        
    }
    
    
    
    
    //MARK: getMAEvents
    
    
    
    
    
    
    
    
    
    
    
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
    class func sharedInstance() -> SongKickClient{
        
        struct Singleton {
            static var sharedInstance = SongKickClient()
        }
        return Singleton.sharedInstance
    }
    
    
    
    
    
    
    
}