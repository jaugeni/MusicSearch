//
//  ViewController.swift
//  MusicSearch
//
//  Created by YAUHENI IVANIUK on 6/6/17.
//  Copyright © 2017 YauheniIvaniuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var searchTxt: UITextField!
    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var pageIndicator: UIPageControl!
    
    var numberOfItem = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageIndicator.numberOfPages = 0
        
        scrolView.delegate = self
    }

    @IBAction func searchForMusicPressed(_ sender: Any) {
        searchTxt.resignFirstResponder()
        
        guard searchTxt.text != "", let textSearch = searchTxt.text else {
            searchTxt.text = ""
            return
        }
        
        ItunseConnection.getAlbumForString(searchString: textSearch) { (album: Album) in
            
            self.numberOfItem += 1
            self.pageIndicator.numberOfPages = self.numberOfItem
            
            self.scrolView.contentSize = CGSize(width: CGFloat(self.numberOfItem) * self.scrolView.frame.size.width, height: self.scrolView.frame.height)
            
            let musicView = Bundle.main.loadNibNamed("MusicView", owner: self, options: nil)?.last as! MusicView
            
            musicView.frame = CGRect(x: CGFloat(self.numberOfItem - 1) * self.scrolView.frame.size.width, y: 0, width: self.scrolView.frame.size.width, height: self.scrolView.frame.size.height)
            musicView.updateConstraints()
            
            DispatchQueue.main.async(execute: { 
                musicView.addDataToMusicView(album: album)
                self.scrolView.addSubview(musicView)
                
                self.scrolView.scrollRectToVisible(musicView.frame, animated: true)
            })
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrolView.contentOffset.x / scrolView.frame.size.width)
        pageIndicator.currentPage = page
    }


}

