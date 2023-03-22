//
//  YandNVeryHardViewController.swift
//  ccmusagame
//
//  Created by Carl Hsieh on 12/17/22.
//  Copyright © 2022 Carl Hsieh. All rights reserved.
//

import UIKit

class YandNVeryHardViewController: UIViewController {

    let backgroundImageView = UIImageView()
   
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
    let TextLabel: UILabel =       // Title
    {
        let textViewLab = UILabel()
        
        textViewLab.font = UIFont.boldSystemFont(ofSize: 25)
        textViewLab.translatesAutoresizingMaskIntoConstraints = false
        textViewLab.textColor = .brown
       // textViewLab.text = "是非題--更難"
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
    
   
    
//    let largeFont = UIFont.systemFont(ofSize: 60)
 //   let configuration = UIImage.SymbolConfiguration(font: largeFont)

    let dataSource: [String] = ["ABC", "DEF", "GHI", "JKL"]
    
    var myArray1:[Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var myArray2:[Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var myArray3:[Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    var myArrayErr1:[Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var myArrayErr2:[Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var myArrayErr3:[Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    var myArrayOK1:[Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var myArrayOK2:[Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var myArrayOK3:[Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
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
        GameName.shared.YandNlevel = 3

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
        backgroundImageView.image = UIImage(named: "nbg")
        
        Collection.delegate = self as UICollectionViewDelegate
        Collection.dataSource = self as UICollectionViewDataSource
        Collection.register(SelCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(Collection)
        view.addSubview(TextLabel)
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
            name = "yh"
            sname = name + String(index) + ".txt"
            
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
                               myArrayErr3[index] = chkerr
                               loop = 1
                           }
                           else
                           {
                              if loop == 1
                              {
                                  chkok = (line as NSString).integerValue
                                  if chkok > 0
                                  {
                                      myArray3[index] = 1
                                      myArrayOK3[index] = chkok
                                  }
                              }
                           }
                        }
                    }
                   
                }
                catch
                {
                   
                    if index == 0
                    {
                        myArray3[index] = 1
                    }
                    else
                    {
                        myArray3[index] = 0
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
        
        TextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 70).isActive = true
        TextLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        //   TextView1.widthAnchor.constraint(equalToConstant: 40).isActive = true
        //    TextView1.heightAnchor.constraint(equalToConstant: 40).isActive = true
        TextLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        GameName.shared.width = Int(((view.frame.width ) / 4 ))
        print("width = \( GameName.shared.width)")
        Collection.topAnchor.constraint(equalTo: TextLabel.bottomAnchor).isActive = true
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
extension YandNVeryHardViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
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
          
               if myArray3[indexPath.row] == 1
               {
               
                   switch indexPath.row
                   {
                   case 0:
                       cell.imageView.image = UIImage(systemName: "01.square.fill")
                       cell.imagestar2.image = UIImage(named: "imag1")
                       break
                   case 1:
                       cell.imageView.image = UIImage(systemName: "02.square.fill")
                       cell.imagestar2.image = UIImage(named: "imag2")
                       break
                   case 2:
                       cell.imageView.image = UIImage(systemName: "03.square.fill")
                       break
                   case 3:
                       cell.imageView.image = UIImage(systemName: "04.square.fill")
                       break
                   case 4:
                       cell.imageView.image = UIImage(systemName: "05.square.fill")
                       break
                   case 5:
                       cell.imageView.image = UIImage(systemName: "06.square.fill")
                       break
                   case 6:
                       cell.imageView.image = UIImage(systemName: "07.square.fill")
                       break
                   case 7:
                       cell.imageView.image = UIImage(systemName: "08.square.fill")
                       break
                   case 8:
                       cell.imageView.image = UIImage(systemName: "09.square.fill")
                       break
                   case 9:
                       cell.imageView.image = UIImage(systemName: "10.square.fill")
                       break
                   case 10:
                       cell.imageView.image = UIImage(systemName: "11.square.fill")
                       break
                   case 11:
                       cell.imageView.image = UIImage(systemName: "12.square.fill")
                       break
                   case 12:
                       cell.imageView.image = UIImage(systemName: "13.square.fill")
                       break
                   case 13:
                       cell.imageView.image = UIImage(systemName: "14.square.fill")
                       break
                   case 14:
                       cell.imageView.image = UIImage(systemName: "15.square.fill")
                       break
                   case 15:
                       cell.imageView.image = UIImage(systemName: "16.square.fill")
                       break
                   case 16:
                       cell.imageView.image = UIImage(systemName: "17.square.fill")
                       break
                   case 17:
                       cell.imageView.image = UIImage(systemName: "18.square.fill")
                       break
                   case 18:
                       cell.imageView.image = UIImage(systemName: "19.square.fill")
                       break
                   default:
                       break
                   }
                }
                else
                {
                    if myArray3[indexPath.row] == 0
                    {
                         cell.imageView.image = UIImage(named: "yhstop")
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
       
        GameName.shared.YandNlevel = 3
        GameName.shared.hname = "yhard"
        GameName.shared.mnum = indexPath.row + 1
    //    print("Carl indexpath.row = \(indexPath.row)")
        if myArray3[indexPath.row] == 1
        {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "YandN") as! GameYandNViewController
            self.present(vc, animated: true, completion: nil)
        }
        
        
    }
    
}
