//
//  EasyEndViewController.swift
//  GameApp
//
//  Created by Carl Hsieh on 5/2/19.
//  Copyright © 2019 Carl Hsieh. All rights reserved.
//

import UIKit

class EndGameViewController: UIViewController {

    let viewToAnimate = UIView()
   
    @IBAction func Back(_ sender: Any)
    {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameHome") as! MainViewController
        self.present(vc, animated: true, completion: nil)
    }
    var fireTimer = Timer()
  
  
    @IBOutlet weak var Label5: UILabel!
    @IBOutlet weak var Label4: UILabel!
    @IBOutlet weak var Label3: UILabel!
    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var Label1: UILabel!
    var watchString = ""

    @IBAction func Contine(_ sender: Any)
    {
        if GameName.shared.level ==  1  // easy level
        {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameLevel") as! GameViewController
            self.present(vc, animated: true, completion: nil)
        }
        else
        {
            if GameName.shared.level ==  2   // middle level
            {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameLevel") as! GameViewController
                self.present(vc, animated: true, completion: nil)
            }
            else
            {
                if GameName.shared.level ==  3   // hard level
                {
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameLevel") as! GameViewController
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let fractions = GameName.shared.fractions
        let seconds = GameName.shared.seconds
        let minuties = GameName.shared.minuties
        let fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutiesString = minuties > 9 ? "\(minuties)" : "0\(minuties)"
       
        watchString = "遊戲時間: \(minutiesString):\(secondsString).\(fractionsString)"
        Label3.text = watchString
        if GameName.shared.over == 1
        {
            Label1.text = "遊戲死掉"
          //  Label2.text = "String("錯誤太多超過")  + String(GameName.shared.err) + "次"
            Label2.text = String("錯誤太多超過")  + String(GameName.shared.err) + "次"
        }
        else
        {
            Label1.text = "遊戲結束"
            if GameName.shared.err == 0
            {
                Label2.text = "恭喜您全部答對"
            }
            else
            {
                Label2.text = "加油錯誤" + String(GameName.shared.err) + "次"
            }
            
        }
       
       
        Label4.text = GameName.shared.item3
        Label5.text = GameName.shared.item1
        GameName.shared.btnenable = false
       
       // fireTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(EndGameViewController.startFireTimer), userInfo: nil, repeats: true)
    }
    
  
    @objc func startFireTimer()
    {
        /*
        self.fire1.isHidden = false
        UIView.animate(withDuration: 0.3, animations:
        {
            self.fire1.frame =  CGRect(x: 10,y: 500, width: 374, height: 128)
            }) { (finished) in
            self.fire1.isHidden = true
            self.fire2.isHidden = false
        }
     
        UIView.animate(withDuration: 0.3, animations:
        {
           
            self.fire2.frame =  CGRect(x: 10,y: 500, width: 374, height: 128)
        }) { (finished) in
           // self.fire1.isHidden = true
            self.fire2.isHidden = true
            self.fire3.isHidden = false
        }
        
        UIView.animate(withDuration: 0.3, animations:
        {
            
            self.fire3.frame =  CGRect(x: 10,y: 500, width: 374, height: 128)
        }) {
       (finished) in
           // self.fire2.isHidden = true
            self.fire3.isHidden = true
           // self.fire4.isHidden = false
        }
        
        UIView.animate(withDuration: 0.3, animations:
        {
            self.fire4.frame =  CGRect(x: 10,y: 500 , width: 374, height: 128)
            }) { (finished) in
          
            self.fire4.isHidden = true
            self.fire5.isHidden = false
        }
        UIView.animate(withDuration: 0.3, animations:
            {
                self.fire5.frame =  CGRect(x: 10,y: 500, width: 374, height: 128)
        }) {
            (finished) in
            self.fire4.isHidden = true
            self.fire6.isHidden = false
           
        }
        UIView.animate(withDuration: 0.3, animations:
            {
                self.fire6.frame =  CGRect(x:  10,y: 500, width: 374, height: 128)
        }) { (finished) in
            self.fire4.isHidden = true
            self.fire7.isHidden = false
         
        }
        UIView.animate(withDuration: 0.3, animations:
            {
                self.fire7.frame =  CGRect(x: 10,y: 500, width: 374, height: 128)
        }) {
            (finished) in
           
            self.fire8.isHidden = false
            
        }
        UIView.animate(withDuration: 0.3, animations:
            {
                self.fire8.frame =  CGRect(x: 10,y: 500, width: 374, height: 128)
        }) { (finished) in
            self.fire8.isHidden = true
            self.fire7.isHidden = true
             self.fire9.isHidden = false
            
        }
        UIView.animate(withDuration: 0.3, animations:
            {
                self.fire9.frame =  CGRect( x: 10,y: 500, width: 374, height: 128)
        }) { (finished) in
            self.fire4.isHidden = true
            self.fire10.isHidden = false
            
        }
        UIView.animate(withDuration: 0.3, animations:
            {
                self.fire10.frame =  CGRect( x: 10,y: 500, width: 374, height: 128)
        }) { (finished) in
            self.fire4.isHidden = true
            self.fire7.isHidden = true
            
        }   */
    }
            
}
