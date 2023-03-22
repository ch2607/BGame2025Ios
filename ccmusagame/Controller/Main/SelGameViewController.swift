//
//  SelGameViewController.swift
//  ccmusagame
//
//  Created by Carl Hsieh on 8/22/22.
//  Copyright © 2022 Carl Hsieh. All rights reserved.
//

import UIKit

class SelGameViewController: UIViewController {

    let backgroundImageView = UIImageView()
    /*
    let Collection: UICollectionView =
    {
        let BibleAview = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: BibleAview)
        collection.backgroundColor = UIColor.white
        collection.translatesAutoresizingMaskIntoConstraints = false
       
        return collection
    }()  */
    lazy var  lblText: UILabel =       // Title
    {
        let lbl = UILabel(frame: .zero)
        lbl.numberOfLines = 0
        lbl.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        lbl.textAlignment = .center
        lbl.textColor = .red
        lbl.font = UIFont.systemFont(ofSize: 48, weight: .semibold)
        lbl.alpha = 0
   
        
        return lbl
        
    }()
    let TimeLabel: UILabel =       // Title
    {
        let textViewLab = UILabel()
        
        textViewLab.font = UIFont.boldSystemFont(ofSize: 18)
        textViewLab.translatesAutoresizingMaskIntoConstraints = false
        textViewLab.textColor = .brown
    //    textViewLab.text = "Carl Hsieh"
        return textViewLab
        
    }()
    let Collection: UICollectionView =
    {
        let BibleQview = UICollectionViewFlowLayout()
        let layout = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: BibleQview)
        layout.backgroundColor = UIColor.clear
        layout.translatesAutoresizingMaskIntoConstraints = false
        
        return layout
    }()
    
    let ansCollection: UICollectionView =
    {
        let BibleAview = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: BibleAview)
        collection.backgroundColor = UIColor.clear
        collection.translatesAutoresizingMaskIntoConstraints = false
       
        return collection
    }()
    
//    let largeFont = UIFont.systemFont(ofSize: 60)
 //   let configuration = UIImage.SymbolConfiguration(font: largeFont)

    let dataSource: [String] = ["ABC", "DEF", "GHI", "JKL"]
    
    var myArray1:[Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var myArray2:[Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    var myArrayErr1:[Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var myArrayErr2:[Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var myArrayOK1:[Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var myArrayOK2:[Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    var fname = ""
    var name = ""
    var sname = ""
    var count = 0
    var err = 0
    var ok = 0
    var chkerr = 0
    var chkok = 0
    var loop = 0
    override func viewDidLoad()
    {
        
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
     //   navigationController?.navigationBar.
        
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    //    backgroundImageView.image = UIImage(named: "note1")
        
        
        Collection.delegate = self as UICollectionViewDelegate
        Collection.dataSource = self as UICollectionViewDataSource
        Collection.register(SelCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(Collection)
        view.addSubview(TimeLabel)
        setupCollection()
        
        let navigationBar = UINavigationBar()
        self.view.addSubview(navigationBar)
        NSLayoutConstraint.activate([
            navigationBar.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            navigationBar.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            navigationBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        ])
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        let item = UINavigationItem(title: " ")
       
        //Creating the chevron (back-arrow) to look like Apple's..
        let img = makeBackChevron(thickness: 3.0, size: CGSize(width: 22.0, height: 44.0), colour: nil)! //UIColor.red
        
        //Creating the bar button.. Note: Add your own target and action..
        let barButton = UIBarButtonItem(image: img, style: .done, target: nil, action:  #selector(self.backAction(_:)))
        
        //Set the left bar button item to be the one we created
        //Then set the items to be part of the navigation bar we created..
         item.leftBarButtonItems = [barButton]
        navigationBar.setItems([item], animated: true)
        for index in 0...20
        {
            //
            // Check File exists here
            //
            if GameName.shared.level == 1
            {
                name = "e"
                sname = name + String(index) + ".txt"
            }
            else
            {
                if GameName.shared.level == 2
                {
                    name = "m"
                    sname = name + String(index) + ".txt"
                }
               
            }
            
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
            {
                let file = documentsDirectory.appendingPathComponent(sname)
             //   print("Carl File= \(file) level = \(GameName.shared.level)")
                do
                {
                  //  print("File = \(file)")
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
                               print("Carl chkerr = \(chkerr) \(file)")
                               if GameName.shared.level == 1
                               {
                                   myArrayErr1[index] = chkerr
                               }
                               else
                               {
                                   myArrayErr2[index] = chkerr
                               }
                               loop = 1
                           }
                           else
                           {
                              if loop == 1
                              {
                                  chkok = (line as NSString).integerValue
                                  print("Carl chkok= \(chkok) \(file)")
                                  if chkok > 0
                                  {
                                      if GameName.shared.level == 1
                                      {
                                          myArray1[index] = 1
                                      }
                                      else
                                      {
                                          myArray2[index] = 1
                                      }
                                  }
                                  if GameName.shared.level == 1
                                  {
                                      myArrayOK1[index] = chkok
                                  }
                                  else
                                  {
                                      myArrayOK2[index] = chkok
                                  }
                                
                              }
                           }
                        }
                    }
                   
                }
                catch
                {
                    //
                    // open file error reset all 0
                    //
                    if GameName.shared.level == 1
                    {
                        if index == 0
                        {
                            myArray1[index] = 1
                        }
                        else
                        {
                            myArray1[index] = 0
                        }
                    }
                    else
                    {
                        if GameName.shared.level == 2
                        {
                            if index == 0
                            {
                                myArray2[index] = 1
                            }
                            else
                            {
                                myArray2[index] = 0
                            }
                        }
                    }
                    
                }
                 
            }
        }
      
       
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
    func setupCollection()
    {
        
        TimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 70).isActive = true
        TimeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        //   TextView1.widthAnchor.constraint(equalToConstant: 40).isActive = true
        //    TextView1.heightAnchor.constraint(equalToConstant: 40).isActive = true
        TimeLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        GameName.shared.width = Int(((view.frame.width ) / 4 ))
        print("width = \( GameName.shared.width)")
        Collection.topAnchor.constraint(equalTo: TimeLabel.bottomAnchor).isActive = true
        Collection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        Collection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
       
        Collection.heightAnchor.constraint(equalToConstant: 700).isActive = true
         
        
    }
    @IBAction func backAction(_ sender: UIButton)
    {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameHome") as! MainViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
extension SelGameViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        return 20 //dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let largeFont = UIFont.systemFont(ofSize: 60)
        let modFont = UIFont.systemFont(ofSize: 40)
        let configuration1 = UIImage.SymbolConfiguration(font: largeFont) // <1>
        let configuration2 = UIImage.SymbolConfiguration(font: modFont) // <1>

        let cell = Collection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SelCollectionViewCell
      //  print(" carl section = \(indexPath.section)")
        if indexPath.row < 19
        {
            //  print("Carl index = \(indexPath.row )")
            
            if GameName.shared.level == 1
            {
               if myArray1[indexPath.row] == 1
               {
               
               //   cell.imagestar1.image = UIImage(systemName: "star.fill", withConfiguration: configuration1)
                   cell.imagestar1.image = UIImage(systemName: "notepad", withConfiguration: configuration1)
                   cell.imagestar2.image = UIImage(systemName: "star")
                   cell.imagestar3.image = UIImage(systemName: "star")
                   cell.imageView.image = UIImage(named: "slot")
                   cell.imageView.image = UIImage(systemName: "01.square.fill", withConfiguration: configuration1)
                }
                else
                {
                    if myArray1[indexPath.row] == 0
                    {
                        //  cell.imageView.image = UIImage(named: "sudoku")
                        cell.imageView.image = UIImage(systemName: "lock.rectangle", withConfiguration: configuration2)
                        
                    }
                }
                
            }
            else
            {
                if GameName.shared.level == 2
                {
                    if myArray2[indexPath.row] == 1
                    {
                    
                        cell.imagestar1.image = UIImage(systemName: "star.fill", withConfiguration: configuration1)
                        cell.imagestar2.image = UIImage(systemName: "star")
                        cell.imagestar3.image = UIImage(systemName: "star")
                        cell.imageView.image = UIImage(named: "slot")
                        cell.imageView.image = UIImage(systemName: "01.square.fill", withConfiguration: configuration1)
                     }
                     else
                     {
                         if myArray2[indexPath.row] == 0
                         {
                             //  cell.imageView.image = UIImage(named: "sudoku")
                             cell.imageView.image = UIImage(systemName: "lock.rectangle", withConfiguration: configuration2)
                             
                         }
                     }
                     
                }
               
            }
            
        }
     
        return(cell)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
     //  print("Carl size \(view.frame.width)")
       return CGSize(width: (view.frame.width ) / 5, height: (view.frame.width - 10) / 5
       )
      // return CGSize(width: 120, height: 82)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
       // print("Carl UIEdgeInsets")
        return UIEdgeInsets(top: 0.5, left: 0.5, bottom: 0.5, right: 0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print("carl select = \(indexPath.row)")
        if GameName.shared.level == 1
        {
            GameName.shared.level = 1
            GameName.shared.ename = "easy"
            GameName.shared.num = indexPath.row + 1
            if myArray1[indexPath.row] == 1
            {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameLevel") as! GameChooseViewController
                 self.present(vc, animated: true, completion: nil)
            }
        }
        else
        {
            GameName.shared.level = 2
            GameName.shared.mname = "med"
            GameName.shared.mnum = indexPath.row + 1
            print("Carl indexpath.row = \(indexPath.row)")
            if myArray2[indexPath.row] == 1
            {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameLevel") as! GameChooseViewController
                self.present(vc, animated: true, completion: nil)
            }
       }
    }
    
}
