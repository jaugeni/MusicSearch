//
//  Album.swift
//  MusicSearch
//
//  Created by YAUHENI IVANIUK on 6/6/17.
//  Copyright © 2017 YauheniIvaniuk. All rights reserved.
//

import UIKit

class Album: NSObject {
    
    var title: String!
    var artist: String!
    var genre: String!
    var artWorkUrl: String!
    
    init (title: String, artist: String, genre: String, artWorkUrl: String) {
        super.init()
        
        self.title = title
        self.artist = artist
        self.genre = genre
        self.artWorkUrl = artWorkUrl
    }

}
