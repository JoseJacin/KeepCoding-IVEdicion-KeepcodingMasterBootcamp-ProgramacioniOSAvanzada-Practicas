//
//  UIViewController+Pop.swift
//  Everpobre
//
//  Created by Jose Sanchez Rodriguez on 23/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import UIKit

// Se hace mediante el método de Extensión
extension UIViewController {
    public func popExtended(nav: UINavigationController?) {
        let _ = nav?.popViewController(animated: true)
    }
}

// Se hace mediante el método de Orientado a Protocolo
extension UIViewController: Popable {
    func popProtocolOriented(nav: UINavigationController?) {
        let _ = nav?.popViewController(animated: true)
    }
}
