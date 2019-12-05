//
//  AlbumObject.swift
//  iTunes
//
//  Created by Anton Lopez on 12/2/19.
//  Copyright © 2019 Anton Lopez. All rights reserved.
//

import Foundation
import UIKit

class AlbumObject {
    var Title: String?
    var Artist: String?
    var ReleaseDate: String?
    var Genre: String?
    var Copyright: String?
    var ImageURLString: String?
    var ItunesStoreURLString: String
    
    // ------------
    // -Cached Values
    // ------------
    var IconImage: UIImage?
    var FullImage: UIImage?
    
    
    init(title:String, artist:String, releaseDate:String, genre:String, copyright:String, imageURLString:String, itunesString:String) {
        Title = title
        Artist = artist
        ReleaseDate = releaseDate
        Genre = genre
        Copyright = copyright
        ItunesStoreURLString = itunesString
        ImageURLString = imageURLString
    }
    
    convenience init(JSONDictionary dict:[String:Any]) {

        // ------------
        //  -Verify we have all the data we need
        // ------------
        guard let artist = dict["artistName"] as? String,
            let title = dict["name"] as? String,
            let release = dict["releaseDate"] as? String,
            let iconURL = dict["artworkUrl100"] as? String,
            let itunesURL = dict["url"] as? String,
            let copyright = dict["copyright"] as? String,
            let genre = (dict["genres"] as? [Any])
            else {
                self.init(title: "",artist: "",releaseDate: "", genre: "", copyright: "",imageURLString: "",itunesString: "")
                return }
        
        self.init(title: title,artist: artist,releaseDate: release, genre: (genre.first as? [String:String])?["name"] ?? "", copyright: copyright,imageURLString: iconURL,itunesString: itunesURL)
    }
    
    func SetIconImageForAlbum(imageView:UIImageView) {

        // ------------
        //  -Here we cache the image gathered from the API to increase speed at the cost of application's memory footprint while running
        // ------------
        if let image = IconImage {
            imageView.image = image
            return
        }
        
        if let urlString = ImageURLString, let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                if error == nil, let weakself = self {
                    
                    weakself.IconImage = UIImage(data: data!)

                    // ------------
                    //  -UI opperations on main thread
                    // ------------
                    DispatchQueue.main.async {
                        imageView.image = weakself.IconImage
                    }
                }
            }
            task.resume()
        }
    }
    
    func SetFullImageForAlbum(imageView:UIImageView) {

        // ------------
        //  -Here we cache the image gathered from the API to increase speed at the cost of application's memory footprint while running
        // ------------
        if let image = FullImage {
            imageView.image = image
            return
        }
        
        if let urlString = ImageURLString?.replacingOccurrences(of: "200x200", with: "400x400"), let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                
                if error == nil, let weakself = self {
                    
                    weakself.FullImage = UIImage(data: data!)
                    
                    // ------------
                    //  -UI opperations on main thread
                    // ------------
                    DispatchQueue.main.async {
                        imageView.image = weakself.FullImage
                    }
                }
            }
            task.resume()
        }
    }
}
