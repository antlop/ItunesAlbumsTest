//
//  JSONLoader.swift
//  iTunes
//
//  Created by Anton Lopez on 12/3/19.
//  Copyright © 2019 Anton Lopez. All rights reserved.
//

import Foundation

class JSONLoader {
    // ------------
    //  -Singleton pattern
    //  -I usually use this pattern for object factories and resource loaders since the loading should be done asyncronysly anyways
    // ------------
    static let Instance = JSONLoader()
    private init(){}
    
    func LoadJSONFrom(String urlString:String, completion: @escaping (_ root: [String:Any]? ) -> Void ) {
        
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error == nil && data != nil {
                    
                    do {
                        try completion(JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any])
                    } catch {
                        print("Error de-serializing json")
                    }
                    
                } else {
                    print("Error Loading from url: " + url.absoluteString)
                }
            }
            task.resume()
        }
    }
}
