//
//  HTTPRequestManager.swift
//  TimehopCodingChallenge
//
//  Created by Paul McGrath on 6/11/18.
//  Copyright © 2018 Paul McGrath. All rights reserved.
//

import Foundation

class HTTPRequestController {
    
    private var currentTask:URLSessionTask? = nil
    
    let endpoint:String = "https://api.giphy.com/v1/gifs/search?api_key=LI6YQkHbry3DO0tFA63mB1jm9lGAHyBu&q=&limit=25&offset=0&rating=G&lang=en"
    
    public func makeHTTPRequestForImageSearch(searchTerm:String, completionHandler:@escaping (_ data:Data?, _ error:Error?) -> Void) {
        
        if let endpointURL = URL(string:endpoint+"&q="+searchTerm) {
            let request = URLRequest(url: endpointURL)
            if let existingTask = self.currentTask {
                existingTask.cancel()
            }
            self.currentTask = URLSession.shared.dataTask(with: request) {data, _, error in
                var imageData:Data?
                if let apiError = error {
                    print("Error retrieving API data, \(apiError.localizedDescription)")
                }
                if let result = data {
                    imageData = result
                }
                completionHandler(imageData, error)
                return
                }
            if let task = self.currentTask {
                task.resume()
            }
        }
    }
}
