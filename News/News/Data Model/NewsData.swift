//
//  NewsData.swift
//  News
//
//  Created by cs3714 on 2/23/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import Foundation
import SwiftUI
 
// Global array of News structs
var newsStructList = [NewsObject]()
 
/*
 Difference between fileprivate and private:
 fileprivate --> makes this constant accessible anywhere only inside this source file.
 private     --> makes it accessible only inside the type (e.g., class, struct) that declared it.
 */
fileprivate let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
 
/*
 ******************************
 MARK: - Read News Data File
 ******************************
 */
public func readNewsDataFile() {
   
    let newsDataFilename = "NewsData.json"
   
    // Obtain URL of the News data file in document directory on user's device
    let urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(newsDataFilename)
 
    do {
        _ = try Data(contentsOf: urlOfJsonFileInDocumentDirectory)
       
        // News data file exists in the document directory
 
        newsStructList = loadFromDocumentDirectory(newsDataFilename)
        print("NewsData is loaded from document directory")
       
    } catch {
        // News data file does not exist in the document directory; Load it from the main bundle.
       
        newsStructList = loadFromMainBundle(newsDataFilename)
        print("NewsData is loaded from main bundle")
    }
}
 
/*
***********************************************
MARK: - Load News Data File from Main Bundle
***********************************************
*/
func loadFromMainBundle<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    let data: Data
   
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Unable to find \(filename) in main bundle.")
    }
   
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Unable to load \(filename) from main bundle:\n\(error)")
    }
   
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Unable to parse \(filename) as \(T.self):\n\(error)")
    }
}
 
/*
 *****************************************************
 MARK: - Write News Data File to Document Directory
 *****************************************************
 */
public func writeNewsDataFile() {
 
    // Obtain the URL of the JSON file in the document directory on the user's device
    let urlOfJsonFileInDocumentDirectory: URL? = documentDirectory.appendingPathComponent("NewsData.json")
 
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(newsStructList) {
        do {
            try encoded.write(to: urlOfJsonFileInDocumentDirectory!)
        } catch {
            fatalError("Unable to write encoded news data to document directory!")
        }
    } else {
        fatalError("Unable to encode news data!")
    }
}
 
/*
******************************************************
MARK: - Load News Data File from Document Directory
******************************************************
*/
func loadFromDocumentDirectory<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    let data: Data
   
    // Obtain the URL of the JSON file in the document directory on the user's device
    let urlOfJsonFileInDocumentDirectory: URL? = documentDirectory.appendingPathComponent(filename)
   
    guard let file = urlOfJsonFileInDocumentDirectory
        else {
            fatalError("Unable to find \(filename) in document directory.")
    }
   
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Unable to load \(filename) from document directory:\n\(error)")
    }
   
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Unable to parse \(filename) as \(T.self):\n\(error)")
    }
}
 
/*
***************************************
MARK: - Get News Flag Image from URL
***************************************
This public function fetches image data from the given URL in an asynchronous manner
under a URLSession, converts it to UIImage, and then returns it as SwiftUI Image.
*/
public func getImageFromUrl(url: String) -> Image {
   
    // ImageUnavailable is provided in Assets.xcassets
    var imageObtainedFromUrl = Image("ImageUnavailable")
 
    let headers = [
        "accept": "image/jpg, image/jpeg, image/png",
        "cache-control": "cache",
        "connection": "keep-alive",
    ]
 
    // Convert given URL string into URL struct
    guard let imageUrl = URL(string: url) else {
        return Image("ImageUnavailable")
    }
 
    let request = NSMutableURLRequest(url: imageUrl,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
 
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
 
    /*
     Create a semaphore to control getting and processing API data.
     signal() -> Int    Signals (increments) a semaphore.
     wait()             Waits for, or decrements, a semaphore.
     */
    let semaphore = DispatchSemaphore(value: 0)
 
    URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        /*
        URLSession is established and the image file from the URL is set to be fetched
        in an asynchronous manner. After the file is fetched, data, response, error
        are returned as the input parameter values of this Completion Handler Closure.
        */
 
        // Process input parameter 'error'
        guard error == nil else {
            semaphore.signal()
            return
        }
 
        // Process input parameter 'response'. HTTP response status codes from 200 to 299 indicate success.
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            semaphore.signal()
            return
        }
 
        // Unwrap Optional 'data' to see if it has a value
        guard let imageDataFromUrl = data else {
            semaphore.signal()
            return
        }
 
        // Convert fetched imageDataFromUrl into UIImage object
        let uiImage = UIImage(data: imageDataFromUrl)
 
        // Unwrap Optional uiImage to see if it has a value
        if let imageObtained = uiImage {
            // UIImage is successfully obtained. Convert it to SwiftUI Image.
            imageObtainedFromUrl = Image(uiImage: imageObtained)
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
 
    return imageObtainedFromUrl
}
 
