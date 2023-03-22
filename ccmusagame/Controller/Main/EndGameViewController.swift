//
//  EndGameViewController.swift
//  ccmusagame
//
//  Created by Carl Hsieh on 5/21/19.
//  Copyright © 2019 Carl Hsieh. All rights reserved.
//

import UIKit

class EndGameViewController: UIViewController {

    var fireworkImage: [UIImage] = []
    
    @IBOutlet weak var fireworkView: UIImageView!
    let backgroundImageView = UIImageView()
    
    @IBAction func Back(_ sender: Any)
    {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameHome") as! MainViewController
        self.present(vc, animated: true, completion: nil)
    }
    var fireTimer = Timer()
    let filename = ""
   
    
    @IBAction func Contine(_ sender: Any)
    {
        if GameName.shared.level ==  1  // easy level
        {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageOrgViewController") as! PageOrgViewController
            self.present(vc, animated: true, completion: nil)
           /*
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Games") as! UINavigationController
            self.present(vc, animated: true, completion: nil)  */
            
         
        }
        else
        {
            if GameName.shared.level ==  2   // middle level
            {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageOrgViewController") as! PageOrgViewController
                self.present(vc, animated: true, completion: nil)
               /*
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Games") as! UINavigationController
                self.present(vc, animated: true, completion: nil)  */
                
           
            }
            else
            {
                if GameName.shared.level ==  3   // hard level
                {
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageOrgViewController") as! PageOrgViewController
                    self.present(vc, animated: true, completion: nil) 
                   /*
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Games") as! UINavigationController
                    self.present(vc, animated: true, completion: nil)  */
                }
            }
        }
    }
    
    let TextView1: UILabel =       // Title
    {
        let textViewLab1 = UILabel()
        
        textViewLab1.font = UIFont.boldSystemFont(ofSize: 18)
        textViewLab1.translatesAutoresizingMaskIntoConstraints = false
        textViewLab1.textColor = .brown
        if GameName.shared.over == 1
        {
            textViewLab1.text = "遊戲終止"
          
        }
        else
        {
          
            textViewLab1.text = "遊戲結束"
        }
        return textViewLab1
        
    }()
    let TextView2: UILabel =    // Time
    {
        var watchString = ""
        let fractions = GameName.shared.fractions
        let seconds = GameName.shared.seconds
        let minuties = GameName.shared.minuties
        let fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutiesString = minuties > 9 ? "\(minuties)" : "0\(minuties)"
        
        watchString = "遊戲時間: \(minutiesString):\(secondsString).\(fractionsString)"
        
        let textViewLab2 = UILabel()
        textViewLab2.font = UIFont.boldSystemFont(ofSize: 18)
        textViewLab2.translatesAutoresizingMaskIntoConstraints = false
        textViewLab2.text = watchString
        
        textViewLab2.textColor = .brown
        return textViewLab2
        
    }()
    
    let TextView3: UILabel =   // result
    {
        let textViewLab3 = UILabel()
        textViewLab3.font = UIFont.boldSystemFont(ofSize: 18)
        textViewLab3.translatesAutoresizingMaskIntoConstraints = false
        textViewLab3.textColor = .brown
        if GameName.shared.err == 0
        {
            textViewLab3.text = "恭喜您全部答對"
        }
        else
        {
            if GameName.shared.over == 1
            {
                textViewLab3.text = String("錯誤太多超過")  + String(GameName.shared.err) + "次"
            }
            else
            {
                textViewLab3.text = "加油錯誤" + String(GameName.shared.err) + "次"
            }
        }
        return textViewLab3
        
    }()
    
    let TextView4: UILabel =    // 章節
    {
        let textViewLab4 = UILabel()
    
        textViewLab4.font = UIFont.boldSystemFont(ofSize: 18)
        textViewLab4.translatesAutoresizingMaskIntoConstraints = false
        textViewLab4.text =  GameName.shared.item3
        textViewLab4.textColor = .brown
        return textViewLab4
        
    }()
    let TextView5: UILabel =    // 經節 T
    {
        let textViewLab5 = UILabel()
        textViewLab5.numberOfLines = 15
        textViewLab5.textColor = .brown
        textViewLab5.font = UIFont.boldSystemFont(ofSize: 18)
        textViewLab5.translatesAutoresizingMaskIntoConstraints = false
        textViewLab5.text =  GameName.shared.item1
        return textViewLab5
        
    }()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        setBackground()
        if GameName.shared.over == 1
        {
            self.title = "遊戲終止"
            fireworkImage = createImageArray(total: 15, imagePrefix: "cross")
        }
        else
        {
            if GameName.shared.err > 0
            {
                 fireworkImage = createImageArray(total: 15, imagePrefix: "cross")
                self.title = "遊戲結束"
            }
            else
            {
                fireworkImage = createImageArray(total: 20, imagePrefix: "fire")
                self.title = "遊戲結束"
            }
        }
       // Label3.text = watchString
        view.addSubview(TextView2)
        view.addSubview(TextView3)
        view.addSubview(TextView4)
        view.addSubview(TextView5)
        setupLayout()
        
        
        if GameName.shared.level ==  1  // easy level
        {
            var sname = ""
            let name = "e"
          //  print("err  =\(GameName.shared.err)", "over = \(GameName.shared.over)")
            if GameName.shared.err == 0
            {
                GameName.shared.results = 1
                
            }
            else
            {
                if GameName.shared.over  == 1
                {
                    GameName.shared.results = 3
                }
                else
                {
                    GameName.shared.results = 2
                }
            }
            
            sname = name + String(GameName.shared.num) + ".txt"
            let fileManger = FileManager.default
            let doumentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
            let filePath = doumentDirectoryPath.appendingPathComponent(sname)
            if fileManger.fileExists(atPath: filePath)
            {
                do
                {
                    try fileManger.removeItem(atPath: filePath)
                }
                catch let error
                {
                    print("error occurred, here are the details:\n \(error)")
                }
            }
            do {
                
                let dir: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last! as URL
                let url = dir.appendingPathComponent(sname)
                try String(GameName.shared.results).appendLineToURL(fileURL: url as URL)
                try String(contentsOf: url as URL, encoding: String.Encoding.utf8)
                
            }
            catch {
                print("Could not write to file")
            }
            
        }
        else
        {
            if GameName.shared.level ==  2   // middle level
            {
                
                var sname = ""
                let name = "m"
                
                if GameName.shared.err == 0
                {
                    GameName.shared.results = 1
                }
                else
                {
                    if GameName.shared.over  == 1
                    {
                        GameName.shared.results = 3
                    }
                    else
                    {
                        GameName.shared.results = 2
                    }
                }
                
                sname = name + String(GameName.shared.mnum) + ".txt"
                let fileManger = FileManager.default
                let doumentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
                let filePath = doumentDirectoryPath.appendingPathComponent(sname)
                if fileManger.fileExists(atPath: filePath)
                {
                    do
                    {
                        try fileManger.removeItem(atPath: filePath)
                    }
                    catch let error
                    {
                        print("error occurred, here are the details:\n \(error)")
                    }
                }
                do {
                    
                    let dir: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last! as URL
                    let url = dir.appendingPathComponent(sname)
                    try String(GameName.shared.results).appendLineToURL(fileURL: url as URL)
                    try String(contentsOf: url as URL, encoding: String.Encoding.utf8)
                    
                }
                catch {
                    print("Could not write to file")
                }
               
            }
            else
            {
                if GameName.shared.level ==  3   // hard level
                {
                    var sname = ""
                    let name = "h"
                    
                    if GameName.shared.err == 0
                    {
                        GameName.shared.results = 1
                    }
                    else
                    {
                        if GameName.shared.over  == 1
                        {
                            GameName.shared.results = 3
                        }
                        else
                        {
                            GameName.shared.results = 2
                        }
                    }
                    
                    sname = name + String(GameName.shared.hnum) + ".txt"
                    let fileManger = FileManager.default
                    let doumentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
                    let filePath = doumentDirectoryPath.appendingPathComponent(sname)
                    if fileManger.fileExists(atPath: filePath)
                    {
                        do
                        {
                            try fileManger.removeItem(atPath: filePath)
                        }
                        catch let error
                        {
                            print("error occurred, here are the details:\n \(error)")
                        }
                    }
                    do {
                        
                        let dir: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last! as URL
                        let url = dir.appendingPathComponent(sname)
                        try String(GameName.shared.results).appendLineToURL(fileURL: url as URL)
                        try String(contentsOf: url as URL, encoding: String.Encoding.utf8)
                        
                    }
                    catch {
                        print("Could not write to file")
                    }
                }
            }
        }
        //
        // reset here
        //
        
        GameName.shared.btnenable = false
        GameName.shared.err = 0
        GameName.shared.over = 0
        GameName.shared.anscount = 0
        
        fireTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(EndGameViewController.startFireTimer), userInfo: nil, repeats: true)
    }
    
    // Can be refactored to an extension on Array.
    func createImageArray(total: Int, imagePrefix: String) -> [UIImage] {
        
        var imageArray: [UIImage] = []
        
        for imageCount in 1..<total {
           // let imageName = "\(imagePrefix)-\(imageCount).png"
            let imageName = "\(imagePrefix)\(imageCount)"
            let image = UIImage(named: imageName)!
            
            imageArray.append(image)
        }
        return imageArray
    }
    
    // Can be refactored to an extension on UIImage
    func animate(imageView: UIImageView, images: [UIImage]) {
        imageView.animationImages = images
        imageView.animationDuration = 1.0
        imageView.animationRepeatCount = 1
        imageView.startAnimating()
    }
    
    private func setupLayout ()
    {
        
        TextView2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        TextView2.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        //   TextView1.widthAnchor.constraint(equalToConstant: 40).isActive = true
        //    TextView1.heightAnchor.constraint(equalToConstant: 40).isActive = true
        TextView2.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        
        TextView3.topAnchor.constraint(equalTo: TextView2.bottomAnchor, constant: 30).isActive = true
        //  TextView3.widthAnchor.constraint(equalToConstant: 40).isActive = true
        //  TextView3.heightAnchor.constraint(equalToConstant: 40).isActive = true
        TextView3.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        TextView3.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        TextView4.topAnchor.constraint(equalTo: TextView3.bottomAnchor, constant:30).isActive = true
        //   TextView4.widthAnchor.constraint(equalToConstant: 40).isActive = true
        //    TextView4.heightAnchor.constraint(equalToConstant: 40).isActive = true
        TextView4.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        TextView4.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        TextView5.topAnchor.constraint(equalTo: TextView4.bottomAnchor, constant: 30).isActive = true
        //  TextView5.widthAnchor.constraint(equalToConstant: 40).isActive = true
        // TextView5.heightAnchor.constraint(equalToConstant: 40).isActive = true
        TextView5.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        TextView5.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        //   TextView5.topAnchor.constraint(equalTo: TextView4.bottomAnchor, constant: 10).isActive = true
        // TextView5.widthAnchor.constraint(equalToConstant: 40).isActive = true
        // TextView5.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // TextView5.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        //  TextView5.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        // TextView5.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    @objc func startFireTimer()
    {
        animate(imageView: fireworkView, images: fireworkImage)
        fireTimer.invalidate()
    }
    private func setBackground()
    {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.image = UIImage(named: "BK-1")
        view.sendSubviewToBack(backgroundImageView)
        
    }
    
    

}
