//
//  GTableViewController.swift
//  ccmusagame
//
//  Created by Carl Hsieh on 5/27/19.
//  Copyright © 2019 Carl Hsieh. All rights reserved.
//

import UIKit

class GTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var tableView: UITableView!
    let backgroundImageView = UIImageView()
    var fname = ""
    var name = ""
    var sname = ""
    var count = 0
    var idx = ""
    var ret = 0
    var myArray:[String] = []
    var myArraySel:[String] = []
    /*
    private let  table: UITableView  = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()  */
    
    override func viewWillAppear(_ animated: Bool)
    {
        
        super.viewWillAppear(animated)
      
        fetch_data()
        tableView.reloadData()
     
        
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
     
        self.navigationItem.titleView = setTitle(title:"填空題")
        GameName.shared.level = 2
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
 //       backgroundImageView.image = UIImage(named: "Choosebg")
      
    //    tableView.delegate = self
  //      tableView.dataSource = self
        tableView.backgroundColor = UIColor.lightGray
      //  view.addSubview(tableView)
        fname = GameName.shared.hname
        name = "h"
       
        //
        // 打開easy, med, hard file , 將內容資料把放進tablelist 中、可以讓使用者來選擇題目
        //
        print("Carl name = \(fname) level = \(GameName.shared.level)")
        if let filepath = Bundle.main.path(forResource: fname, ofType: "txt")
        {
            do
            {
                let contents  = try String(contentsOfFile: filepath)
                let lines = contents.split(separator: "\r\n")
               
           
                for line in lines
                {
                    if GameName.shared.level == 0
                    {
                        myArray.append(String(line))
                      //  myArrayeasy.append(String(line))
                    }
                    else
                    {
                        if GameName.shared.level == 1
                        {
                            myArray.append(String(line))
                         //   myArrayhard.append(String(line))
                          //  print("carl  lines =\(line)")
                        }
                        else
                        {
                            if GameName.shared.level == 2
                            {
                                myArray.append(String(line))
                               // myArrayvery.append(String(line))
                            }
                        }
                    }
                }
            }
            catch
            {
                print("Carl Contents could not be loaded.")
            }
   
            //
            // 這是檢查有多少題目做過有錯有對、把它放在tablelist 前面
            //
            for index in 0...399
            {
                //
                // Check File exists here
                //
                if GameName.shared.level == 0
                {
                    name = "e"
                    sname = name + String(index) + ".txt"
                }
                else
                {
                    if GameName.shared.level == 1
                    {
                        name = "m"
                        sname = name + String(index) + ".txt"
                    }
                    else
                    {
                        if GameName.shared.level == 2
                        {
                            name = "h"
                            sname = name + String(index) + ".txt"
                        }
                    }
                }
            //    print("carl status file sname = \(sname)")
                if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
                {
                    let file = documentsDirectory.appendingPathComponent(sname)
                    //   print("File= \(file)")
                    do
                    {
                        //  print("File = \(file)")
                        let fileExists = try file.checkResourceIsReachable()
                        if fileExists
                        {
                      
                            let text = try String(contentsOf: file, encoding: .utf8)
                            ret = (text as NSString).integerValue
                        //    print("carl found file fileExists ret =  \(ret)  \(sname)")
                            if ret == 1
                            {
                                if GameName.shared.level == 0
                                {
                                    myArraySel.append(String("1"))
                                 //   print("carl add myArraySel ")
                                   // myArraySeleasy.append(String("1"))
                                }
                                else
                                {
                                    if GameName.shared.level == 1
                                    {
                                        myArraySel.append(String("1"))
                                      //  myArraySelhard.append(String("1"))
                                    }
                                    else
                                    {
                                        myArraySel.append(String("1"))
                                      //  myArraySelvery.append(String("1"))
                                    }
                                }
                            }
                            else
                            {
                                if ret == 2
                                {
                                    if GameName.shared.level == 0
                                    {
                                        myArraySel.append(String("2"))
                                     //   myArraySeleasy.append(String("2"))
                                    }
                                    else
                                    {
                                        if GameName.shared.level == 1
                                        {
                                            myArraySel.append(String("2"))
                                         //   myArraySelhard.append(String("2"))
                                        }
                                        else
                                        {
                                            myArraySel.append(String("2"))
                                          //  myArraySelvery.append(String("2"))
                                        }
                                    }
                                }
                                else
                                {
                                    if ret == 3
                                    {
                                        if GameName.shared.level == 0
                                        {
                                            myArraySel.append(String("3"))
                                          //  myArraySeleasy.append(String("3"))
                                        }
                                        else
                                        {
                                            if GameName.shared.level == 1
                                            {
                                                myArraySel.append(String("3"))
                                              //  myArraySelhard.append(String("3"))
                                            }
                                            else
                                            {
                                                myArraySel.append(String("3"))
                                              //  myArraySelvery.append(String("3"))
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    catch
                    {
                 
                        if GameName.shared.level == 0
                        {
                            myArraySel.append(String("0"))
                         //   myArraySeleasy.append(String("0"))
                        }
                        else
                        {
                            if GameName.shared.level == 1
                            {
                                myArraySel.append(String("0"))
                              //  myArraySelhard.append(String("0"))
                            }
                            else
                            {
                                myArraySel.append(String("0"))
                                // myArraySelvery.append(String("0"))
                            }
                        }
                    }
                }
            }  // for index in 1...400
        }
      
    }  // end of Load
    func setTitle(title:String) -> UIView  {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 8, width: 0, height: 0))

        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.text = title
        titleLabel.sizeToFit()

        let titleView = UIView(frame: CGRect(x: 0, y: 8, width:40, height:40))
               
        titleView.addSubview(titleLabel)
        return titleView
    }
    func  fetch_data()
    {
        myArraySel = []
        for index in 0...399
        {
           
            name = "h"
            sname = name + String(index) + ".txt"
             
        //    print("carl status file sname = \(sname)")
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
            {
                let file = documentsDirectory.appendingPathComponent(sname)
                //   print("File= \(file)")
                do
                {
                  
                    let fileExists = try file.checkResourceIsReachable()
                    if fileExists
                    {
                        let text = try String(contentsOf: file, encoding: .utf8)
                        ret = (text as NSString).integerValue
                    
                        if ret == 1
                        {
                            myArraySel.append(String("1"))
                        }
                        else
                        {
                            if ret == 2
                            {
                               myArraySel.append(String("2"))
                            }
                            else
                            {
                                if ret == 3
                                {
                                   myArraySel.append(String("3"))
                                }
                            }
                        }
                    }
                }
                catch
                {
                    myArraySel.append(String("0"))
                }
            }
        }  // for index in 1...400
    }
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
          return myArray.count
      
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GamesTableViewCell
        cell.MyLabel.textColor = .systemBlue
        cell.MyLabel.font = .systemFont(ofSize: 20)
        cell.MyLabel?.text = myArray[indexPath.row]
        idx = myArraySel[indexPath.row]
    //    print("carl in cell fun \(idx)   count \(indexPath.row)")
        if idx  == "0"
        {
            cell.MyImage.image = UIImage(named: "clear")
        }
        else
        {
            if  idx == "1"
            {
                cell.MyImage.image = UIImage(named: "imag1")
              //  print("idx = \(idx)")
            }
            else
            {
                if  idx == "2"
                {
                    cell.MyImage.image = UIImage(named: "imag2")
                }
                else
                {
                    if ( idx == "3" )
                    {
                        cell.MyImage.image = UIImage(named: "imag3")
                    }
                }
            }
          
        }
        let x:CGFloat = 0.0
        let y:CGFloat = 0.0
        let z:CGFloat = 1.0
        var rotation = CATransform3DMakeRotation(CGFloat(90*M_PI/180), x, y, z)
        rotation.m34 = 1 / -500
        cell.contentView.layer.transform = rotation
        cell.contentView.layer.anchorPoint = CGPoint(x:0, y:0)
        UIView.beginAnimations("rotation", context: nil)
        UIView.setAnimationDuration(1)
        cell.contentView.layer.transform = CATransform3DIdentity
        UIView.commitAnimations()
        
        return (cell)
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
      
        GameName.shared.hnum = indexPath.row
   
     // table.reloadData()
   
    }
}
