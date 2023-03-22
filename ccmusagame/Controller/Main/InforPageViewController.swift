//
//  InforPageViewController.swift
//  ccmusagame
//
//  Created by Carl Hsieh on 3/3/23.
//  Copyright © 2023 Carl Hsieh. All rights reserved.
//

import UIKit

class InforPageViewController:  UIViewController {
    
  
    let backgroundImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.image = UIImage(named: "Yandnbg")
        view.sendSubviewToBack(backgroundImageView)
        
    
        let hmgif = UIImage.gifImageWithName("biblegame")
        let imageView = UIImageView(image: hmgif)
        imageView.frame = CGRect(x: 10.0, y: 180.0, width: self.view.frame.size.width , height: 450.0)
           view.addSubview(imageView)

    }

}
