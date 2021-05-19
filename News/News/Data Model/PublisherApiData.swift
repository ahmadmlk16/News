//
//  PublisherApiData.swift
//  News
//
//  Created by cs3714 on 2/27/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import Foundation
import SwiftUI

// Global list of all Publishers accessible in all Swift files
var listOfAllNewsPublishers = [NewsPublisherObject]()


/*
 ======================================
 MARK: - Obtain All Publishers from API
 ======================================
 */

public func obtainPublishersFromApi() {
    
    let apiUrl = "https://newsapi.org/v2/sources?language=en"
    
    /*
     *******************************
     *   HTTP GET Request Set Up   *
     *******************************
     */
    
    let headers = [
        "x-api-key": "80e7f33df12a472e9663e91ebd9070ac",
        "accept": "application/json",
        "cache-control": "no-cache",
        "connection": "keep-alive",
        "host": "newsapi.org"
    ]
    
    let request = NSMutableURLRequest(url: NSURL(string: apiUrl)! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    /*
     *********************************************************************
     *  Setting Up a URL Session to Fetch the JSON File from the API     *
     *  in an Asynchronous Manner and Processing the Received JSON File  *
     *********************************************************************
     */
    
    /*
     Create a semaphore to control getting and processing API data.
     signal() -> Int    Signals (increments) a semaphore.
     wait()             Waits for, or decrements, a semaphore.
     */
    let semaphore = DispatchSemaphore(value: 0)
    
    URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        /*
         URLSession is established and the JSON file from the API is set to be fetched
         in an asynchronous manner. After the file is fetched, data, response, error
         are returned as the input parameter values of this Completion Handler Closure.
         */
        
        // Process input parameter 'error'
        guard error == nil else {
            semaphore.signal()
            return
        }
        
        /*
         ----------------------------------------------------
         🔴 Any 'return' used within the completionHandler
         exits the completionHandler; not the public function
         ----------------------------------------------------
         */
        
        // Process input parameter 'response'. HTTP response status codes from 200 to 299 indicate success.
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            semaphore.signal()
            return
        }
        
        // Process input parameter 'data'. Unwrap Optional 'data' if it has a value.
        guard let jsonDataFromApi = data else {
            semaphore.signal()
            return
        }
        
        //------------------------------------------------
        // JSON data is obtained from the API. Process it.
        //------------------------------------------------
        do {
            /*
             Foundation framework’s JSONSerialization class is used to convert JSON data
             into Swift data types such as Dictionary, Array, String, Number, or Bool.
             */
            
            var newsDataDictionary = Dictionary<String, Any>()
            //response from API
            let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi,
                                                                options: JSONSerialization.ReadingOptions.mutableContainers)
            //convert response into an dataDictionary
            if let jsonObject = jsonResponse as? [String: Any] {
                 newsDataDictionary = jsonObject
            } else { return }
            //extract "sources" from object
            var newsJsonArray = [Any]()
            if let jArray = newsDataDictionary["sources"] as? [Any] {
                newsJsonArray = jArray
            } else {
                semaphore.signal()
                return
            }
            
            var newsJsonObject = [String: Any]()
            var i = 0
            
            //go through array to generate list
            for _ in newsJsonArray{
                
                if let jObject = newsJsonArray[i] as?[String: Any]{
                    newsJsonObject = jObject
                    i = i + 1
                    
                    let nId = UUID()
                    var nName = ""
                    var nDescription = ""
                    var nUrl = ""
                    var nCategory = ""
                    var nLanguage = ""
                    var nCountry = ""
                    
                 
                    if let name = newsJsonObject["name"]as? String{
                        nName = name
                    }
                    if let description = newsJsonObject["description"]as? String{
                        nDescription = description
                    }
                    if let url = newsJsonObject["url"]as? String{
                        nUrl = url
                    }
                    if let category = newsJsonObject["category"]as? String{
                        nCategory = category
                    }
                    if let language = newsJsonObject["language"]as? String{
                        nLanguage = language
                    }
                    if let country = newsJsonObject["country"]as? String{
                        nCountry = country
                    }
                    //add all attributes to the list
                    listOfAllNewsPublishers.append(NewsPublisherObject(id: nId, name: nName, description: nDescription, url: nUrl, category: nCategory, language: nLanguage, country: nCountry))
                    
                    
                }else{
                    semaphore.signal()
                    return
                }
            }
            
            


            
        } catch {
            semaphore.signal()
            return
        }
        
        semaphore.signal()
    }).resume()
    
    /*
     The URLSession task above is set up. It begins in a suspended state.
     The resume() method starts processing the task in an execution thread.
     
     The semaphore.wait blocks the execution thread and starts waiting.
     Upon completion of the task, the Completion Handler code is executed.
     The waiting ends when .signal() fires or timeout period of 10 seconds expires.
     */
    
    _ = semaphore.wait(timeout: .now() + 10)
    
}



