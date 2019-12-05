//
//  AlbumTableViewController.swift
//  iTunes
//
//  Created by Anton Lopez on 12/2/19.
//  Copyright © 2019 Anton Lopez. All rights reserved.
//

import Foundation
import UIKit

class AlbumTableViewController: UITableViewController {
    var ListOfAlbums : Array<AlbumObject>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ListOfAlbums = Array<AlbumObject>()

        // -------------
        //  -Load list from api here through the 'Loader' singleton
        //  -Set data after loading has completed within the completion handler
        // -------------
        JSONLoader.Instance.LoadJSONFrom(String: "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/10/explicit.json") { [weak self] (data) in
            // -------------
            //  -Pass weak self to prevent memory leaks by increasing retain counter
            //  -Casting from 'Any' is a bit jumbled. With more time, I would set up a class/struct heirarchy for the JSON
            //      in order to serialize to that archetecture
            // -------------
            
            let rootDict : [String:Any] = (data?["feed"] as? [String:Any])!
            guard let albumsDict = rootDict["results"] as? [Any],
                let weakself = self
                else { return }
            
            albumsDict.forEach { (dict) in
                let album = AlbumObject(JSONDictionary: (dict as! [String:Any]))
                weakself.ListOfAlbums.append(album)
            }
            
            // -------------
            //  -Forcing the reload on the main thread
            // -------------
            DispatchQueue.main.async {
                weakself.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // -------------
        //  -Hide the navigation bar for a cleaner look
        //  -In this section so it gets re-hidden after coming back from the 'DetailViewController'
        // -------------
        if let navController = navigationController {
            navController.navigationBar.isHidden = true
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListOfAlbums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AlbumCell = tableView.dequeueReusableCell(withIdentifier: "AlbumCellIdentifier") as! AlbumCell
        
        guard let title = cell.AlbumTitle,
            let artist = cell.Artist,
            let image = cell.iconImageView,
            ListOfAlbums.count > indexPath.row
        else { return AlbumCell() }
        
        title.text = ListOfAlbums[indexPath.row].Title
        artist.text = ListOfAlbums[indexPath.row].Artist
        
        // -------------
        //  -Allow the album to set the image so that it's all in one place
        // -------------
        ListOfAlbums[indexPath.row].SetIconImageForAlbum(imageView: image)
        
        return cell
    }
    
    // -------------
    //  -Precedurally call the segue settup in the Storybaord and pass the selected album
    // -------------
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard ListOfAlbums.count > indexPath.row else { return }
        performSegue(withIdentifier: "EnhancedDetailPageSegue", sender: ListOfAlbums[indexPath.row])
    }

    // -------------
    //  -Passing the data through to the new uiviewcontroller could have also been done with a delegate method, but
    //      this method seemed more human readable with just 1 segue
    // -------------
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? DetailViewController)?.Album = sender as? AlbumObject
    }
}
