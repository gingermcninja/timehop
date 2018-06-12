//
//  GIFFile.swift
//  TimehopCodingChallenge
//
//  Created by Paul McGrath on 6/11/18.
//  Copyright © 2018 Paul McGrath. All rights reserved.
//

import Foundation

struct GIFFile : Decodable {
    var id:String
    var source:String
}

struct GIFData : Decodable {
    var data:[GIFFile]
}
