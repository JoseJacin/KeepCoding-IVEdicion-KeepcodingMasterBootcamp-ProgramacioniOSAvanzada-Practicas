//
//  ViewController.swift
//  HackerBooks
//
//  Created by Jose Sanchez Rodriguez on 13/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func downloadBtnClick(_ sender: Any) {
        print("Before download")
        
        let queue = DispatchQueue(label: "myqeue", attributes: .concurrent)
        queue.async {
            self.download()
        }
        
        print("After download")
    }
    
    func download() {
        let urlString = "http://www.castellonaldia.es/wp-content/uploads/2014/01/La-Gioconda-carmen-de-mairena.jpg"
        
        let url: URL = NSURL(string: urlString) as! URL
        do {
            let data: Data = try Data(contentsOf: url)
            let img = UIImage(data: data)
            
            DispatchQueue.main.async {
                self.imageView.image = img
            }
        } catch {
            
        }
    }
}

