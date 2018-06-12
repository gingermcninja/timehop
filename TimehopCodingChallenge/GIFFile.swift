//
//  GIFFile.swift
//  TimehopCodingChallenge
//
//  Created by Paul McGrath on 6/11/18.
//  Copyright © 2018 Paul McGrath. All rights reserved.
//

import Foundation

/**
 These structs are used to decode the JSON into a format we can use
 */
struct GIFImagesFixedWidth: Decodable {
    var url: String
}

/**
 These structs are used to decode the JSON into a format we can use
 */
struct GIFImages: Decodable {
    var fixed_width:GIFImagesFixedWidth
}

/**
 These structs are used to decode the JSON into a format we can use
 */
struct GIFFile : Decodable {
    var id:String
    var source:String
    var images:GIFImages
}

/**
 These structs are used to decode the JSON into a format we can use
 */
struct GIFData : Decodable {
    var data:[GIFFile]
}
