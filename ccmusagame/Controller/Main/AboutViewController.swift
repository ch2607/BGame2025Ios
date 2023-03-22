//
//  AboutViewController.swift
//  ccmusagame
//
//  Created by Carl Hsieh on 5/21/19.
//  Copyright © 2019 Carl Hsieh. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController
{

    
   let backgroundImageView = UIImageView()
 /*
    @IBAction func AboutBtn(_ sender: Any)
    {
        self.dismiss(animated: false, completion: nil)
        self.presentingViewController?.dismiss(animated: false, completion: nil)
    }*/
    let AboutLabel: UILabel =    // About InfoT
    {
        let AboutText = UILabel()
        AboutText.numberOfLines = 0
        AboutText.textColor = .black
        AboutText.font = UIFont.boldSystemFont(ofSize: 18)
        AboutText.translatesAutoresizingMaskIntoConstraints = false
        AboutText.text = "「聖經填字遊戲」（1.0 版)\n\n本遊戲中的經文採用中文和合本聖經，遊戲目的是幫助你熟悉經文，進而存記心中，成為你腳前的燈、路上的光。\n\n\n中國信徒佈道會出版（2019年)\n\n\n感謝：鄭月娥姊妹提供聖經經節\n\n感謝：Flo Snapchat"
        return AboutText
        
    }()
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
        
        view.addSubview(AboutLabel)
        setupLayout()
        
        
        
    }
    private func setupLayout ()
    {
        
        AboutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        AboutLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        AboutLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    /*
    @IBAction func backAction(_ sender: UIButton) {
        // let _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: false, completion: nil)
    }  */
    
  
}
