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
    
    let searchEndpoint:String = "https://api.giphy.com/v1/gifs/search?api_key=LI6YQkHbry3DO0tFA63mB1jm9lGAHyBu&q=&limit=25&offset=0&rating=G&lang=en"
    let trendingEndpoint:URL = URL(string: "https://api.giphy.com/v1/gifs/trending?api_key=LI6YQkHbry3DO0tFA63mB1jm9lGAHyBu&q=&limit=25&offset=0&rating=G&lang=en")!
    
    public func makeHTTPRequestForImageSearch(searchTerm:String, completionHandler:@escaping (_ data:Data?, _ error:Error?) -> Void) {
        if let endpointURL = URL(string:searchEndpoint+"&q="+searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) {
            callGiphyAPIWithURL(url: endpointURL, completionHandler: completionHandler)
        }
    }
    
    public func makeHTTPRequestForTrending(completionHandler:@escaping (_ data:Data?, _ error:Error?) -> Void) {
        callGiphyAPIWithURL(url: trendingEndpoint, completionHandler: completionHandler)
    }
        
    
    private func callGiphyAPIWithURL(url:URL, completionHandler:@escaping (_ data:Data?, _ error:Error?) -> Void) {
        let request = URLRequest(url: url)
        if let existingTask = self.currentTask {
            existingTask.cancel()
        }
        self.currentTask = URLSession.shared.dataTask(with: request) {data, _, error in
            var imageData:Data?
            var httpError:Error?
            if let apiError = error {
                if (apiError as NSError).code != -999 {
                    print("Error retrieving API data, \(apiError.localizedDescription)")
                    httpError = apiError
                }
            }
            if let result = data {
                imageData = result
            }
            completionHandler(imageData, httpError)
            return
        }
        if let task = self.currentTask {
            task.resume()
        }
    }
    
    
    
    public func getImageDataFromSource(sourceURL:String, completionHandler:@escaping(_ data:Data?, _ error:Error?) -> Void) {

        if let imageURL = URL(string: sourceURL) {
            let imageRequest = URLRequest(url: imageURL)
            URLSession.shared.dataTask(with: imageRequest) { (imageData, _, imageError) in
                var resultData:Data?
                if let imgError = imageError {
                    print("Error retrieving GIF image, \(imgError.localizedDescription)")
                }
                if let result = imageData {
                    resultData = result
                }
                completionHandler(resultData, imageError)
                return
            }.resume()
        }
    }
}
