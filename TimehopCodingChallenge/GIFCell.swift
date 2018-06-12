//
//  GIFCell.swift
//  TimehopCodingChallenge
//
//  Created by Paul McGrath on 6/11/18.
//  Copyright © 2018 Paul McGrath. All rights reserved.
//

import UIKit

/**
 This class is used to display an individual gif image in our collection view
 */
public class GIFCell:UICollectionViewCell {
    /**
     UIImageView for displaying the final .gif image
    */
    @IBOutlet var imageView:UIImageView!
    
    /**
     HTTPRequestController object for retrieving the raw image data
    */
    private let requestManager:HTTPRequestController = HTTPRequestController()
    
    /**
     The URL of the GIF in string format.
     
     - Note: Setting this parameter will call the HTTPRequestController.makeGETRequestWithURL() function and set the image in the imageview. Doing so will cancel any existing request in progress.
    */
    public var imageSource:String? {
        didSet {
            if let imageSrc = imageSource, let imageURL = URL(string: imageSrc) {
                requestManager.makeGETRequestWithURL(url: imageURL) { (data, error) in
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

}
