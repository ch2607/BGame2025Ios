//
//  Page2ViewController.swift
//  ccmusagame
//
//  Created by Carl Hsieh on 3/6/23.
//  Copyright © 2023 Carl Hsieh. All rights reserved.
//

import UIKit

class Page2ViewController: UIViewController {
    
    let backgroundImageView = UIImageView()
    @IBOutlet var gifimg: UIImageView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.image = UIImage(named: "page2")
        view.sendSubviewToBack(backgroundImageView)
 
    }
    

  

}
