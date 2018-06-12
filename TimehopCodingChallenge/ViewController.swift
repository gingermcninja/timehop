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
        
        gifRepo.loadTrendingGIFS { (success, error) in
            if let err = error {
                print(err.localizedDescription)
            }
            if success {
                DispatchQueue.main.async { () -> Void in
                    self.collectionView?.reloadData()
                }
            }
            
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let gifArray = gifRepo.gifArray {
            return gifArray.count
        } else { return 0 }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:GIFCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GIFCell
        if let gifArray = gifRepo.gifArray {
            cell.imageSource = gifArray[indexPath.row].images.fixed_width.url
        }
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

