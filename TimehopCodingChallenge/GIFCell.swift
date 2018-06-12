//
//  GIFCell.swift
//  TimehopCodingChallenge
//
//  Created by Paul McGrath on 6/11/18.
//  Copyright © 2018 Paul McGrath. All rights reserved.
//

import UIKit

class GIFCell:UICollectionViewCell {
    let requestManager:HTTPRequestController = HTTPRequestController()
    var imageSource:String? {
        didSet {
            if let imageSrc = imageSource {
                requestManager.getImageDataFromSource(sourceURL: imageSrc) { (data, error) in
                    var img:UIImage = UIImage(named: "timehop_icon")!
                    if let imgData = data, let retrievedImage = UIImage(data: imgData) {
                        img = retrievedImage
                    }
                    DispatchQueue.main.async{ () -> Void in
                        self.imageView.image = img
                    }
                }
            }
        }
    }
    @IBOutlet var imageView:UIImageView!
}
