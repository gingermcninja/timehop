//
//  ViewController.swift
//  TimehopCodingChallenge
//
//  Created by Paul McGrath on 6/11/18.
//  Copyright © 2018 Paul McGrath. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let httpController:HTTPRequestController = HTTPRequestController()
        httpController.makeHTTPRequestForImageSearch(searchTerm: "happy") { (data, error) in
            
            if let result:Data = data {
                let str:String = String(data: result, encoding: String.Encoding.utf8)!
                print(str)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

