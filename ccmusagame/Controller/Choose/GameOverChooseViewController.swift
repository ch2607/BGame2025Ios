//
//  GameOverChooseViewController.swift
//  ccmusagame
//
//  Created by Carl Hsieh on 1/12/23.
//  Copyright © 2023 Carl Hsieh. All rights reserved.
//

import UIKit

class GameOverChooseViewController: UIViewController {
    let backgroundImageView = UIImageView()
    @IBOutlet weak var LabelTextOK: UILabel!
    @IBOutlet weak var LabelText: UILabel!
    
    @IBOutlet weak var backimg: UIImageView!
    @IBAction func ContBtn(_ sender: Any)
    {
         let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageChooseViewController") as! PageChooseViewController
            self.present(vc, animated: true, completion: nil)
          GameName.shared.isLastQuestion = false
    }
   // @IBOutlet weak var backimg: UIImageView!
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
     //   let hmgif = UIImage.gifImageWithName("face")
        let hmgif = UIImage(named: "backimg")
        backimg.image = hmgif
     
        GameName.shared.over = 0
        GameName.shared.currentQuestion = 0
        GameName.shared.correctAnswers  = 0
        GameName.shared.numberOfQuestions = 10
       
        LabelText.text = String("錯誤")  + String(GameName.shared.error) + "次"
       // LabelText.layer.cornerRadius = 8
        LabelText.layer.borderColor = UIColor.black.cgColor
      //  LabelText.layer.borderWidth = 2
        LabelText.textAlignment = .center
        LabelText.font = UIFont.systemFont(ofSize: 30, weight: .light)
        
        LabelTextOK.text = String("答對")  + String(GameName.shared.ok) + "次"
       // LabelTextOK.layer.cornerRadius = 8
        LabelTextOK.layer.borderColor = UIColor.black.cgColor
       // LabelTextOK.layer.borderWidth = 2
        LabelTextOK.textAlignment = .center
        LabelTextOK.font = UIFont.systemFont(ofSize: 30, weight: .light)
      //  GameName.shared.isLastQuestion = false
        
        if GameName.shared.ChooseLevel ==  1  // easy level
        {
            var sname = ""
            let name = "ce"
            
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
            do
            {
                
                let dir: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last! as URL
                let url = dir.appendingPathComponent(sname)
                try String(GameName.shared.error).appendLineToURL(fileURL: url as URL)
                try String(GameName.shared.ok).appendLineToURL(fileURL: url as URL)
                try String(contentsOf: url as URL, encoding: String.Encoding.utf8)
                
            }
            catch
            {
                print("Could not write to file")
            }
            
        }
        else
        {
            if GameName.shared.ChooseLevel ==  2   // middle level
            {
                
                var sname = ""
                let name = "cm"
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
                do
                {
                    
                    let dir: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last! as URL
                    let url = dir.appendingPathComponent(sname)
                    try String(GameName.shared.error).appendLineToURL(fileURL: url as URL)
                    try String(GameName.shared.ok).appendLineToURL(fileURL: url as URL)
                    try String(contentsOf: url as URL, encoding: String.Encoding.utf8)
                    
                }
                catch
                {
                    print("Could not write to file")
                }
               
            }
            else
            {
                
                //
                //  ChooseLevel 3 here
                //
                var sname = ""
                let name = "ch"
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
                    try String(GameName.shared.error).appendLineToURL(fileURL: url as URL)
                    try String(GameName.shared.ok).appendLineToURL(fileURL: url as URL)
                    try String(contentsOf: url as URL, encoding: String.Encoding.utf8)
                    
                }
                catch {
                    print("Could not write to file")
                }
            }
        }
        
        //
        // reset here
        //
        
        GameName.shared.btnenable = false
        GameName.shared.error = 0
        GameName.shared.ok = 0
      
    }
    
}
