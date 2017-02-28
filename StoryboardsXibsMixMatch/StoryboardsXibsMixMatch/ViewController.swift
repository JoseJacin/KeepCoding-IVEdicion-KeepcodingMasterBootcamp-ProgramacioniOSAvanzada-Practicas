//
//  ViewController.swift
//  StoryboardsXibsMixMatch
//
//  Created by Jose Sanchez Rodriguez on 27/02/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func openVCUsingXib(_ sender: Any) {
        // opening a VC from this VC using XIB
        // regular, old way of doing this
        let vc = MyXibViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func openInitialVCFromStoryboardUsingCode(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Second", bundle: nil)
        if let vc = sb.instantiateInitialViewController() {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    @IBAction func openAnyVCFromStoryboardUsingCode(_ sender: Any) {
        let sb = UIStoryboard(name: "Second", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "UnconnectedVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

