//
//  Page5ViewController.swift
//  ccmusagame
//
//  Created by Carl Hsieh on 3/10/23.
//  Copyright © 2023 Carl Hsieh. All rights reserved.
//

import UIKit

class Page5ViewController: UIViewController {

    let backgroundImageView = UIImageView()

    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        let jeremyGif = UIImage.gifImageWithName("playgif")
            let imageView = UIImageView(image: jeremyGif)
            imageView.frame = CGRect(x: 20.0, y: 50.0, width: self.view.frame.size.width - 40, height: 450.0)
            view.addSubview(imageView)
        /*
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.image = UIImage(named: "page6")
        view.sendSubviewToBack(backgroundImageView)  */
     
    }
    

  

}
