//
//  NewGameViewController.swift
//  ccmusagame
//
//  Created by Carl Hsieh on 5/21/19.
//  Copyright © 2019 Carl Hsieh. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController
{
    
    @IBOutlet weak var Choose: UIButton!
    @IBOutlet weak var YandN: UIButton!
    @IBOutlet weak var VeryHardButton: UIButton!
    @IBOutlet weak var LoadLevelgif: UIImageView!
    let backgroundImageView = UIImageView()
 
    @IBAction func ActYandN(_ sender: Any)
    {
      
    }
    @IBAction func ActChoose(_ sender: Any)
    {
      
    }
  
    @IBAction func ActVhard(_ sender: Any) {
      
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let levelgif = UIImage.gifImageWithName("newgames")
        LoadLevelgif.image = levelgif
      
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.image = UIImage(named: "newgame")
        view.sendSubviewToBack(backgroundImageView)
  
    }
  
}
