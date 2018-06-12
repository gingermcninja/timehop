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
public struct GIFImagesFixedWidth: Decodable {
    /**
    Fixed width URL of GIF
    */
    public var url: String
}

/**
 These structs are used to decode the JSON into a format we can use
 */
public struct GIFImages: Decodable {
    /**
     Fixed width data for GIF
    */
    public var fixed_width:GIFImagesFixedWidth
}

/**
 These structs are used to decode the JSON into a format we can use
 */
public struct GIFFile : Decodable {
    /**
    GIF id
    */
    public var id:String
    /**
     GIF source parameter
     */
    public var source:String
    /**
     GIF image information
    */
    public var images:GIFImages
}

/**
 These structs are used to decode the JSON into a format we can use
 */
public struct GIFData : Decodable {
    /**
     GIF data array
    */
    public var data:[GIFFile]
}
