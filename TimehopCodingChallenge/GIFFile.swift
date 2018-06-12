//
//  GIFFile.swift
//  TimehopCodingChallenge
//
//  Created by Paul McGrath on 6/11/18.
//  Copyright © 2018 Paul McGrath. All rights reserved.
//

import Foundation

struct GIFImagesFixedWidth: Decodable {
    var url: String
}

struct GIFImages: Decodable {
    var fixed_width:GIFImagesFixedWidth
}

struct GIFFile : Decodable {
    var id:String
    var source:String
    var images:GIFImages
}

struct GIFData : Decodable {
    var data:[GIFFile]
}
