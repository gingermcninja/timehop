//
//  GIFRepository.swift
//  TimehopCodingChallenge
//
//  Created by Paul McGrath on 6/11/18.
//  Copyright © 2018 Paul McGrath. All rights reserved.
//

import Foundation

class GIFRepository {
    var gifArray:[GIFFile]?
    let httpController:HTTPRequestController = HTTPRequestController()
    func loadGIFsWithSearchTerm(term:String, completionHandler:@escaping (_ success:Bool, _ error:Error?) -> Void) {
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
    
    func loadTrendingGIFS(completionHandler:@escaping (_ success:Bool, _ error:Error?) -> Void) {
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
