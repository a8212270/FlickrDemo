//
//  PhotoCollectionViewCell.swift
//  FlickrDemo
//
//  Created by Pony on 2020/5/28.
//  Copyright © 2020 Pony. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var Img_photo: UIImageView!
    @IBOutlet weak var Lbl_title: UILabel!
    
    var data: searchPhotoType.Response.Photos.Photo! {
        didSet {
            Lbl_title.text = data.title
            
            let downloader = ImageDownloader()
            let urlRequest = URLRequest(url: data.imageUrl)
            self.Img_photo.image = nil
            downloader.download(urlRequest) { response in
                if case .success(let image) = response.result {
                    
                    self.Img_photo.image = image
                }
            }
        }
    }
}
