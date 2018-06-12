//
//  GIFRepository.swift
//  TimehopCodingChallenge
//
//  Created by Paul McGrath on 6/11/18.
//  Copyright © 2018 Paul McGrath. All rights reserved.
//

import Foundation

/**
 This class maintains the current array of GIFs to be displayed. It acts as a go-between between the view controller
 and the HTTP layer
 */
public class GIFRepository {
    /**
     The current array of GIF objects
    */
    public var gifArray:[GIFFile]?
    
    /**
     HTTPRequestController for making requests to the Giphy API
    */
    private let httpController:HTTPRequestController = HTTPRequestController()
    
    /**
     Retrieve a list of GIFs based on an input search term and stores the results in the gifArray
     
     - parameter term: The term to search on
     - parameter completionHandler: An enclosure to be executed upon completion.
     - parameter success: Returns true of the request was successful
     - parameter error: Any error created by the request
    */
    public func loadGIFsWithSearchTerm(term:String, completionHandler:@escaping (_ success:Bool, _ error:Error?) -> Void) {
        httpController.makeHTTPRequestForImageSearch(searchTerm: term) { (data, error) in
            if let result:Data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let gifData:GIFData = try jsonDecoder.decode(GIFData.self, from: result)
                    self.gifArray = gifData.data
                    completionHandler(true, nil)
                } catch let error {
                    completionHandler(false, error)
                }
            }
        }
    }
    
    /**
     Retrieve a list of trending GIFs and stores the results in the gifArray
     
     - parameter completionHandler: An enclosure to be executed upon completion.
     - parameter success: Returns true of the request was successful
     - parameter error: Any error created by the request
     */
    public func loadTrendingGIFs(completionHandler:@escaping (_ success:Bool, _ error:Error?) -> Void) {
        httpController.makeHTTPRequestForTrending { (data, error) in
            if let result:Data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let gifData:GIFData = try jsonDecoder.decode(GIFData.self, from: result)
                    self.gifArray = gifData.data
                    completionHandler(true, nil)
                } catch let error {
                    completionHandler(false, error)
                }
            }
        }
    }
    
    
}
