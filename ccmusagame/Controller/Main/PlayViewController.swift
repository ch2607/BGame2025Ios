//
//  PlayViewController.swift
//  ccmusagame
//
//  Created by Carl Hsieh on 5/21/19.
//  Copyright © 2019 Carl Hsieh. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    
  let backgroundImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
       backgroundImageView.image = UIImage(named: "Help-1")
        view.sendSubviewToBack(backgroundImageView)
        
        let navigationBar = UINavigationBar()
        self.view.addSubview(navigationBar)
        NSLayoutConstraint.activate([
            navigationBar.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            navigationBar.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            navigationBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
            ])
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        //Creating a navigation bar item with title..
        let item = UINavigationItem(title: "")
        
        //Creating the chevron (back-arrow)
        //let img = makeBackChevron(size: CGSize(width: 20.0, height: 20.0), colour: nil)! //UIColor.red
        
        //Creating the chevron (back-arrow) to look like Apple's..
        let img = makeBackChevron(thickness: 3.0, size: CGSize(width: 22.0, height: 44.0), colour: nil)! //UIColor.red
        
        //Creating the bar button.. Note: Add your own target and action..
        let barButton = UIBarButtonItem(image: img, style: .done, target: nil, action:  #selector(self.backAction(_:)))
        
        //Set the left bar button item to be the one we created
        //Then set the items to be part of the navigation bar we created..
        item.leftBarButtonItems = [barButton]
        navigationBar.setItems([item], animated: true)
        
    }
    
    
    func makeBackChevron(thickness: CGFloat, size: CGSize, colour: UIColor? = nil) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let ctx = UIGraphicsGetCurrentContext()
        
        //Create a thin-line chevron with some left-padding..
        let padding: CGFloat = 0.20
        let path = UIBezierPath()
        path.move(to: CGPoint(x: padding + 0.5, y: 0.773))
        path.addLine(to: CGPoint(x: padding + 0.0, y: 0.5))
        path.addLine(to: CGPoint(x: padding + 0.5, y: 0.227))
        path.apply(CGAffineTransform(scaleX: size.width, y: size.height))
        
        //Use a stroke instead of a fill like previous algorithm..
        ctx?.setStrokeColor(colour?.cgColor ?? UIColor.white.cgColor)
        ctx?.addPath(path.cgPath)
        ctx?.setLineWidth(thickness) //Set arrow-thickness..
        ctx?.setLineJoin(.round) //Set line-join to round corners..
        ctx?.strokePath()
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return colour != nil ? img?.withRenderingMode(.alwaysOriginal) : img
    }
    @IBAction func backAction(_ sender: UIButton) {
        // let _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: false, completion: nil)
    }
    

}
