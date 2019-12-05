//
//  AlbumObjectTest.swift
//  iTunesTests
//
//  Created by Anton Lopez on 12/3/19.
//  Copyright © 2019 Anton Lopez. All rights reserved.
//

import XCTest

class AlbumObjectTest: XCTestCase {

    var Album : AlbumObject?
    var JSONAlbum : AlbumObject?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        JSONAlbum = AlbumObject(JSONDictionary: [
            "artistName":"Stormzy",
            "id":"1487951013",
            "releaseDate":"2019-12-13",
            "name":"Heavy Is The Head",
            "kind":"album",
            "copyright":"℗ 2019 Hashtag Merky Music Limited under exclusive license to Atlantic Records UK, a division of Warner Music UK Limited.",
            "artistId":"394865154",
            "contentAdvisoryRating":"Explicit",
            "artistUrl":"https://music.apple.com/us/artist/stormzy/394865154?app=music",
            "artworkUrl100":"https://is5-ssl.mzstatic.com/image/thumb/Music123/v4/3c/a8/7c/3ca87c13-bffa-3ebd-eec6-68ea78ab556d/190295403003.jpg/200x200bb.png",
            "genres":[
                ["genreId":"18",
                "name":"Hip-Hop/Rap",
                "url":"https://itunes.apple.com/us/genre/id18"],
                ["genreId":"34",
                "name":"Music",
                "url":"https://itunes.apple.com/us/genre/id34"]],
            "url":"https://music.apple.com/us/album/heavy-is-the-head/1487951013?app=music"])
        
        Album = AlbumObject(JSONDictionary: [:])
    }
    
    func testJSONAlbum() {
        let imageView : UIImageView? = UIImageView()
        
        XCTAssertEqual(JSONAlbum?.Artist, "Stormzy")
        XCTAssertEqual(JSONAlbum?.Copyright, "℗ 2019 Hashtag Merky Music Limited under exclusive license to Atlantic Records UK, a division of Warner Music UK Limited.")
        XCTAssertEqual(JSONAlbum?.Genre, "Hip-Hop/Rap")
        XCTAssertEqual(JSONAlbum?.ImageURLString, "https://is5-ssl.mzstatic.com/image/thumb/Music123/v4/3c/a8/7c/3ca87c13-bffa-3ebd-eec6-68ea78ab556d/190295403003.jpg/200x200bb.png")
        XCTAssertEqual(JSONAlbum?.ItunesStoreURLString, "https://music.apple.com/us/album/heavy-is-the-head/1487951013?app=music")
        XCTAssertEqual(JSONAlbum?.ReleaseDate, "2019-12-13")
        XCTAssertEqual(JSONAlbum?.Title, "Heavy Is The Head")
        
        JSONAlbum?.SetFullImageForAlbum(imageView: imageView!)
        XCTAssertNil(imageView?.image)
    }
    
    func testEmptyAlbum() {
        
        XCTAssertNotNil(Album)
        
        XCTAssertEqual(Album?.Artist,"")
        XCTAssertEqual(Album?.Copyright,"")
        XCTAssertEqual(Album?.Genre,"")
        XCTAssertEqual(Album?.ImageURLString,"")
        XCTAssertEqual(Album?.ItunesStoreURLString,"")
        XCTAssertEqual(Album?.ReleaseDate,"")
        XCTAssertEqual(Album?.Title,"")
    }
}
