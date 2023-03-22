//
//  ResultsViewController.swift
//  ccmusagame
//
//  Created by Carl Hsieh on 7/29/19.
//  Copyright © 2019 Carl Hsieh. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet var y5: UILabel!       // yandtotal
    @IBOutlet var org4: UILabel!   // org total
    @IBOutlet var org3: UILabel!   // org over
    @IBOutlet var org2: UILabel!   // org error
    @IBOutlet var org1: UIView!
    
    @IBOutlet var y4: UILabel!      // org ok
    @IBOutlet var y3: UILabel!      // yandnover
    @IBOutlet var y2: UILabel!      // yandnerror
    @IBOutlet var y1: UILabel!      // yandnok
    
    @IBOutlet var ch3: UILabel!      // chover
    @IBOutlet var ch4: UILabel!     // cherror
    @IBOutlet var ch2: UILabel!     // chtotal
    @IBOutlet var ch1: UILabel!    // chok
    
    let backgroundImageView = UIImageView()
    var name = ""
    var sname = ""
    var count = 0
    var idx = ""
    var ret = 0
    var all = 0
    var err = 0;
    var over = 0
    var total = 0
    var loop = 0
    var chkerr = 0
    var chkok = 0
    
    var chooseok = 0
    var chooseerr = 0
    var chooseover = 0
    var choosetotal = 0
    
    var yandnok = 0
    var yandnerr = 0
    var yandnover = 0
    var yandntotal = 0
    
 
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
        // Choose   遊戲選擇
        for index in 0...29
        {
            name = "ce"
            sname = name + String(index) + ".txt"
       
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
            {
                let file = documentsDirectory.appendingPathComponent(sname)
          
                do
                {
                  
                    let fileExists = try file.checkResourceIsReachable()
                    if fileExists
                    {
                        let text = try String(contentsOf: file, encoding: .utf8)
                        let lines = text.split(separator: "\n")
                        
                        for line in lines
                        {
                            if loop ==  0
                            {
                                chkerr = (line as NSString).integerValue
                                loop = 1
                            }
                            else
                            {
                                if loop == 1
                                {
                                    chkok = (line as NSString).integerValue
                              
                                    if chkerr > 3
                                    {
                                        chooseover  += 1
                                    }
                                    else
                                    {
                                        if chkok == 10
                                        {
                                            chooseok  += 1
                                            print("carl ok index \(index) ok \(chooseok)")
                                        }
                                        else
                                        {
                                            chooseerr  += 1
                                        }
                                    }
                                   
                                    loop = 0
                      
                                }
                            }
                        }
                    }
                }
                catch
                {
                    choosetotal += 1
                }
            }
        }
       
        // YandN  遊戲是非
        for index in 0...29
        {
            name = "ye"
            sname = name + String(index) + ".txt"
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
            {
                let file = documentsDirectory.appendingPathComponent(sname)
          
                do
                {
                  
                    let fileExists = try file.checkResourceIsReachable()
                    if fileExists
                    {
                        let text = try String(contentsOf: file, encoding: .utf8)
                        let lines = text.split(separator: "\n")
                        
                        for line in lines
                        {
                            if loop ==  0
                            {
                                chkerr = (line as NSString).integerValue
                            //    print("Carl read \(sname) chkerr = \(chkerr)  idx  \(index)")
                                loop = 1
                            }
                            else
                            {
                                if loop == 1
                                {
                                    chkok = (line as NSString).integerValue
                              
                                    if chkerr > 3
                                    {
                                        yandnover  += 1
                                    }
                                    else
                                    {
                                        if chkok == 10
                                        {
                                            yandnok  += 1
                                        }
                                        else
                                        {
                                            yandnerr  += 1
                                        }
                                    }
                                   
                                    loop = 0
                      
                                }
                            }
                        }
                    }
                }
                catch
                {
                    yandntotal += 1
                }
            }
        }

        // 遊戲填空
        for index in 0...399
        {
           
            name = "h"
            sname = name + String(index) + ".txt"
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
            {
                let file = documentsDirectory.appendingPathComponent(sname)
                do
                {
                  
                    let fileExists = try file.checkResourceIsReachable()
                    if fileExists
                    {
                        
                        let text = try String(contentsOf: file, encoding: .utf8)
                        ret = (text as NSString).integerValue
                        if ret == 1
                        {
                            all += 1
                        }
                        else
                        {
                            if ret == 2
                            {
                                err += 1
                            }
                            else
                            {
                                if ret == 3
                                {
                                    over += 1
                                }
                            }
                        }
                    }
                }
                catch
                {
                    total += 1
                }
            }
        }
        // ch1 is  ok
        ch1.text = String("全部答對經節:")  + String(chooseok) + "次"
        // ch2 is total value
        ch2.text = String("尚未完的經節:")  + String(choosetotal) + "次"
        // ch3 over value
        ch3.text = String("答錯太多經節:")  + String(chooseover) + "次"
        // ch4 is Error
        ch4.text = String("答錯經節:")   +   String(chooseerr) + "次"
        
        // y1 is ok vaule
        y1.text = String("全部答對經節: ")  + String(yandnok) + "次"
        // y2 is Error
        y2.text = String("答錯經節: ")  + String(yandnerr) + "次"
        // y3 is Over value
        y3.text = String("答錯太多經節:")  + String(yandnover) + "次"
        // y5 is total value
        y5.text = String("尚未完的經節: ")  +  String(yandntotal) + "次"
  
        //   y4 is org  ok
        y4.text = String("全部答對經節:  ") + String(all) + "次"
        // org2 is Error
        org2.text = String("答錯經節: ")  + String(err) + "次"
       // org3 is Over
        org3.text = String("答錯太多經節: ")  + String(over) + "次"
       // org4 is Total
        org4.text = String("尚未完的經節:") + String(total) + "次"
        // 選擇
       // 是非
        // 填空
      
    }
   
}
