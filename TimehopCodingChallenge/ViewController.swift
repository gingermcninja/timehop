//
//  ViewController.swift
//  TimehopCodingChallenge
//
//  Created by Paul McGrath on 6/11/18.
//  Copyright © 2018 Paul McGrath. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    let gifRepo = GIFRepository()
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        gifRepo.loadGIFsWithSearchTerm(term: "happy") { (success, error) in
            if let err = error {
                print(err.localizedDescription)
            }
            print("okay")
        }
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

