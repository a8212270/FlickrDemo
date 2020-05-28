//
//  ReqResModel.swift
//  ARTouch
//
//  Created by Pony on 2019/11/12.
//  Copyright © 2019 Pony. All rights reserved.
//

import Foundation

enum APIURL: String {
    /// API name = api url
    case searchPhoto = "flickr.photos.search"
}

struct APIStatus: Codable {
    var stat: String
    var code, message: String?
}

struct searchPhotoType {
    struct Request: Codable {
        let text, per_page: String
    }
    
    struct Response: Codable {
        let stat: String
        let photos: Photos
        
        struct Photos: Codable {
            let photo: [Photo]
            
            struct Photo: Codable {
                let farm: Int
                let secret: String
                let id: String
                let server: String
                let title: String
                var imageUrl: URL {
                   return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg")!
                }
            }
        }
    }
}

enum ServerAPI_Code: String{
    ///成功
    case success = "ok"
    case fail = "fail"
    /// JSON Decoder Faild
    case IOS001
    /// JSON Encoder Faild
    case IOS002
    /// Response Empty
    case IOS014
    
    /// custom error msg
}
