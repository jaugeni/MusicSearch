//
//  ItunseConnection.swift
//  MusicSearch
//
//  Created by YAUHENI IVANIUK on 6/6/17.
//  Copyright © 2017 YauheniIvaniuk. All rights reserved.
//

import UIKit

class ItunseConnection: NSObject {
    
    class func getAlbumForString(searchString: String, complectionHandler: @escaping (Album)->()) {
        
        let escapedString = searchString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let url = URL(string: "https://itunes.apple.com/search?term=\(escapedString!)&media=music")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                if let data = data {
                    let itunseDict: [String:AnyObject]!
                    do {
                        itunseDict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
                    } catch {
                        
                        return
                    }
                    
                    let resultsArray = itunseDict["results"] as! [Dictionary<String, AnyObject>]
                    
                    if resultsArray.count > 0 {
                        if let resultDict = resultsArray.first {
                            let artist = resultDict["artistName"] as! String
                            let artWorkUrl = resultDict["artworkUrl100"] as! String
                            
                            let albumTitle = resultDict["collectionName"] as! String
                            let genre = resultDict["primaryGenreName"] as! String
                            
                            let album = Album(title: albumTitle, artist: artist, genre: genre, artWorkUrl: artWorkUrl)
                            complectionHandler(album)
                        }
                    }
                }
            }
        }
        
        task.resume()
    }
    
}
