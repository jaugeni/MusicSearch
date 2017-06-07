//
//  MusicView.swift
//  MusicSearch
//
//  Created by YAUHENI IVANIUK on 6/7/17.
//  Copyright © 2017 YauheniIvaniuk. All rights reserved.
//

import UIKit

class MusicView: UIView {

    @IBOutlet weak var artWorkImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var artistLbl: UILabel!
    @IBOutlet weak var genreLbl: UILabel!
    
    func addDataToMusicView (album: Album) {
        
        do {
            let data = try Data(contentsOf: URL(string: album.artWorkUrl)!)
            
            artWorkImageView.image = UIImage(data: data)

        } catch {return}
        
        titleLbl.text = album.title
        artistLbl.text = album.artist
        genreLbl.text = album.genre
    }
}
