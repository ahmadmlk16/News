//
//  TopHeadlineApiData.swift
//  News
//
//  Created by cs3714 on 2/29/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//


import Foundation
import SwiftUI

// Global list of all newsItems accessible in all Swift files
var listOfAllTopHeadLines = [NewsObject]()

/*
 ======================================
 MARK: - Obtain All newsItems from API
 ======================================
 */



public func obtainTopHeadlinesFromApi(category: String, dateFrom : String, dateTo: String, sortBy: String) {

    var apiUrl = ""
    // If selected category is default value "all", we omit the category parameter.
    if category == "all" {
        apiUrl = "https://newsapi.org/v2/top-headlines?country=us&language=en&from=\(dateFrom)&to=\(dateTo)&sortBy=\(sortBy)"
    } else if category != "all"{
        apiUrl = "https://newsapi.org/v2/top-headlines?country=us&language=en&category=\(category)&from=\(dateFrom)&to=\(dateTo)&sortBy=\(sortBy)"
    }
    
    
    
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
        
        //remove previous entries from the list before generating a new list
        listOfAllTopHeadLines.removeAll()

        do {
            /*
             Foundation framework’s JSONSerialization class is used to convert JSON data
             into Swift data types such as Dictionary, Array, String, Number, or Bool.
             */
            
            var newsDataDictionary = Dictionary<String, Any>()
            
            //response from API
            let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi,
                                                                options: JSONSerialization.ReadingOptions.mutableContainers)
            
            
       
            
            //feed response into a dataDictionary
            if let jsonObject = jsonResponse as? [String: Any] {
                newsDataDictionary = jsonObject
            } else { return }
            
            //extract articles from the dictionary
            var newsJsonArray = [Any]()
            if let jArray = newsDataDictionary["articles"] as? [Any] {
                newsJsonArray = jArray
            } else {
                semaphore.signal()
                return
            }
            
            
            
            
            
            
            
            var newsJsonObject = [String: Any]()
            var i = 0
            
       
            //loop through each news item
            for _ in newsJsonArray{
                
                
                if let jObject = newsJsonArray[i] as?[String: Any]{
                    newsJsonObject = jObject
                    i = i + 1
                    
                 
                    //instantiate variables with default values
                    let nId = UUID()    // Storage Type: String, Use Type (format): UUID
                    var nSourceName = ""
                    var nAuthor = ""
                    var nTitle = ""
                    var nDescription = ""
                    var nUrl = ""
                    var nUrlToImage = ""
                    var nPublishedAt = ""
                    var nContent = ""

                    //extract the nested "sources" object
                    var sourceJsonObject = [String: Any]()
                    if let iObject = newsJsonObject["source"] as? [String: Any] {
                        sourceJsonObject = iObject
                    } else {
                        semaphore.signal()
                        return
                    }
                    
                      // feed values from json into the variables
            
                    if let name = sourceJsonObject["name"]as? String{
                        nSourceName = name
                    }
                    if let author = newsJsonObject["author"]as? String{
                        nAuthor = author
                    }
                    if let title = newsJsonObject["title"]as? String{
                        nTitle = title
                    }
                    if let description = newsJsonObject["description"]as? String{
                        nDescription = description
                    }
                    if let url = newsJsonObject["url"]as? String{
                        nUrl = url
                    }
                    if let urlToImage = newsJsonObject["urlToImage"]as? String{
                        nUrlToImage = urlToImage
                    }
                    if let publishedAt = newsJsonObject["publishedAt"]as? String{
                                           nPublishedAt = publishedAt
                                       }
                    if let content = newsJsonObject["content"]as? String{
                                           nContent = content
                                       }
                    //append the new News item into the list
                                        listOfAllTopHeadLines.append(NewsObject(id: nId, sourceName : nSourceName, author: nAuthor, title: nTitle, description: nDescription, url: nUrl, urlToImage: nUrlToImage, publishedAt: nPublishedAt, content: nContent))
                    
                
                    
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





