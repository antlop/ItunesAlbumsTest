//
//  DetailViewController.swift
//  iTunes
//
//  Created by Anton Lopez on 12/3/19.
//  Copyright © 2019 Anton Lopez. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var AlbumImage : UIImageView?
    @IBOutlet var ArtistLabel : UILabel?
    @IBOutlet var AlbumTitleLabel : UILabel?
    @IBOutlet var GenreLabel : UILabel?
    @IBOutlet var ReleaseDateLabel : UILabel?
    @IBOutlet var CopyrightLabel : UILabel?
    
    public var Album : AlbumObject?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // -------------
        //  -Show the navigation controller in order to allow the user to go 'Back'
        // -------------
        if let navControl = navigationController {
            navControl.navigationBar.isHidden = false
        }
        
        if let album = Album {
            // -------------
            //  -Allowing the Album to set the image
            // -------------
            if let image = AlbumImage {
                album.SetFullImageForAlbum(imageView: image)
            }
            
            
            // -------------
            //  -Setting all the label's values
            // -------------
            guard let artist = ArtistLabel,
                let albumName = AlbumTitleLabel,
                let genre = GenreLabel,
                let releaseDate = ReleaseDateLabel,
                let copyright = CopyrightLabel
            else { return }
            
            artist.text = album.Artist
            albumName.text = album.Title
            genre.text = album.Genre
            releaseDate.text = "Released \(album.ReleaseDate ?? "")"
            copyright.text = album.Copyright
        }
    }
    
    @IBAction func GoToITunesStore() {
        // -------------
        //  -This method will open the iTunes app to the album
        //  -If the iTunes app is not on the phone (which is the case for simulator) it will attempt to open
        //      the default web browser to the itunes album website
        //  -The simulator seems to have issues with the web link but I did confirm that this method works properly
        //      on the Device
        // -------------
        if let album = Album, let url = URL(string: album.ItunesStoreURLString),
        UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
