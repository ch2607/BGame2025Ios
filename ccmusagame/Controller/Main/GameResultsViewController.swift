//
//  GameResultsViewController.swift
//  ccmusagame
//
//  Created by Carl Hsieh on 7/29/19.
//  Copyright © 2019 Carl Hsieh. All rights reserved.
//

import UIKit

class GameResultsViewController: UIViewController {

    @IBOutlet weak var EasyButton: UIButton!
    @IBOutlet weak var MedButton: UIButton!
    @IBOutlet weak var HardButton: UIButton!
    
    @IBAction func ActEasy(_ sender: Any)
    {
         GameName.shared.level = 1
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AllResults") as! ResultsViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func ActMed(_ sender: Any)
    {
         GameName.shared.level = 2
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AllResults") as! ResultsViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func ActHard(_ sender: Any)
    {
         GameName.shared.level = 3
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AllResults") as! ResultsViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    let backgroundImageView = UIImageView()
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        
       
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.image = UIImage(named: "win")
        view.sendSubviewToBack(backgroundImageView)
        
        
        // ButtonAnimation()
        
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
    override func viewWillAppear(_ animated: Bool)
    {
        
        ButtonAnimation()
    }
    func makeBackChevron(thickness: CGFloat, size: CGSize, colour: UIColor? = nil) -> UIImage?
    {
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
    
    @IBAction func backAction(_ sender: UIButton)
    {
        print("new selbtn = \(GameName.shared.btnenable)")
        self.dismiss(animated: false, completion: nil)
    }
   
    private func ButtonAnimation()
    {
        // EasyButton
        
        UIView.animate(withDuration: 0.5, delay: 1.5, options: UIView.AnimationOptions.curveEaseIn, animations:
            {
                //Frame Option 1:
                // self.GameButton.frame = CGRect(x: self.GameButton.frame.origin.x, y: 10, width: self.GameButton.frame.width, height: self.GameButton.frame.height)
                self.EasyButton.frame = CGRect(x: -350, y: 270, width: 50 , height: 50)
                //Frame Option 2:
                //  self.EasyButton.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 4)
                self.EasyButton.backgroundColor = .blue
                
        },completion:
            { finish in
                
                UIView.animate(withDuration: 1, delay: 0.25,options: UIView.AnimationOptions.curveEaseOut,animations:
                    {
                        //  self.GameButton.backgroundColor = .blue
                        self.EasyButton.transform = CGAffineTransform(scaleX: 1, y: 1)
                        
                        //    self.animationButton.isEnabled = false // If you want to restrict the button not to repeat animation..You can enable by setting into true
                        
                },completion: nil)
                
        })
        
        // MedButton
        
        UIView.animate(withDuration: 0.5, delay: 2, options: UIView.AnimationOptions.curveEaseIn, animations:
            {
                //Frame Option 1:
                //  self.ConGameButton.frame = CGRect(x: self.ConGameButton.frame.origin.x, y: 20, width: self.ConGameButton.frame.width, height: self.ConGameButton.frame.height)
                self.MedButton.frame = CGRect(x: 1000, y: 270, width: 50 , height: 50)
                //Frame Option 2:
                //self.myView.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 4)
                self.MedButton.backgroundColor = .red
                
        },completion:
            { finish in
                
                UIView.animate(withDuration: 1, delay: 0.25,options: UIView.AnimationOptions.curveEaseOut,animations:
                    {
                        //  self.ConGameButton.backgroundColor = .red
                        self.MedButton.transform = CGAffineTransform(scaleX: 1, y: 1)
                        
                        //    self.animationButton.isEnabled = false // If you want to restrict the button not to repeat animation..You can enable by setting into true
                        
                },completion: nil)})
        
        
        // HardButton
        
        UIView.animate(withDuration: 0.5, delay: 2.0, options: UIView.AnimationOptions.curveEaseIn, animations:
            {
                //Frame Option 1:
                // self.PlayButton.frame = CGRect(x: self.InfoButton.frame.origin.x, y: 20, width: self.PlayButton.frame.width, height: self.PlayButton.frame.height)
                self.HardButton.frame = CGRect(x: -320, y: 370, width: 50 , height: 50)
                //Frame Option 2:
                //self.myView.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 4)
                self.HardButton.backgroundColor = .blue
                
        },completion:
            { finish in
                
                UIView.animate(withDuration: 1, delay: 0.25,options: UIView.AnimationOptions.curveEaseOut,animations:
                    {
                        //  self.PlayButton.backgroundColor = .blue
                        self.HardButton.transform = CGAffineTransform(scaleX: 1, y: 1)
                        
                },completion: nil)})
    }

}
