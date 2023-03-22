//
//  EasyViewController.swift
//  ccmusagame
//
//  Created by Carl Hsieh on 12/14/22.
//  Copyright © 2022 Carl Hsieh. All rights reserved.
//

import UIKit

class ChooseViewController: UIViewController {
    
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
        // textViewLab.text = "容易"
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
    
    let qnsCollection: UICollectionView =
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
    
 
    var myArrayBG:[String] = []  // CollectionView Backgroung image
    var myArrayNum:[String] = [] // Display Number
    var pCell = UICollectionViewCell()
    var fname = ""
    var name = ""
    var sname = ""
    var count = 0

    var err = 0
    var ok = 0
    var chkerr = 0
    var chkok = 0
    var loop = 0
    var idx = ""
    var unlock = 0
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        loop = 0
        ReadDataFromFile()
        Collection.reloadData()
    //    print("carl viewWillAppear ")
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.titleView = setTitle(title:"選擇題")
        loop = 0
        reloadData()
  
    }
   
    func reloadData()
    {
        GameName.shared.ChooseLevel = 1
        
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.image = UIImage(named: "Choosebg")
        Collection.delegate = self as UICollectionViewDelegate
        Collection.dataSource = self as UICollectionViewDataSource
        Collection.register(SelCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(Collection)
        view.addSubview(TextLabel)
        setupCollection()
        loop = 0
        ReadDataFromFile()
      
    }
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
    func ReadDataFromFile()
    {
     //   GameName.shared.myArray = []
        GameName.shared.myArrayInf = []
        myArrayBG = []
        myArrayNum = []
        var n = 0
       
       
        for index in 0...30
        {
            name = "ce"
            sname = name + String(index) + ".txt"
       
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
            {
           //     print("carl read file \(sname)")
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
                          //      print("Carl read befor \(sname) chkok = \(chkok)  error  \(chkerr ) inf \(GameName.shared.myArrayInf[index])")
                                if loop == 1
                                {
                                    chkok = (line as NSString).integerValue
                                  
                                    if chkerr > 3
                                    {
                                        GameName.shared.myArrayInf.append(String("3"))
                                    }
                                    else
                                    {
                                        if chkok == 10
                                        {
                                            GameName.shared.myArrayInf.append(String("1"))
                                        }
                                        else
                                        {
                                            GameName.shared.myArrayInf.append(String("2"))
                                        }
                                    }
                                    GameName.shared.myArray.append(String("1"))
                                    GameName.shared.savefileidx = index
                                    GameName.shared.saveerror =  chkerr
                                    myArrayBG.append(String("1"))
                                    loop = 0
                                    chkok = 0
                                    chkerr = 0
                                    print("Carl read after \(sname) chkok = \(chkok)  error  \(chkerr ) inf \(GameName.shared.myArrayInf[index])")
                             
                                }
                            }
                        }
                    }
                }
                catch
                {
                   // print("carl file not found \(sname)")
                    let documentDirectoryUrl = try! FileManager.default.url(
                        for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                    let file = documentDirectoryUrl.appendingPathComponent(sname)
                    if index == 0
                    {
                        GameName.shared.myArray.append(String("1"))  // Unlock
                    }
                    else
                    {
                        n =  index - 1
                        if  n != 0
                        {
                            //
                            //  index is 2 or 3 4 5 6 .........
                            //
                            if  n == GameName.shared.savefileidx
                            {
                                if GameName.shared.saveerror > 3
                                {
                                    GameName.shared.myArray.append(String("0"))
                                }
                                else
                                {
                                    GameName.shared.myArray.append(String("1"))
                                }
                            }
                            else
                            {
                                GameName.shared.myArray.append(String("0"))
                            }
                        }
                        else
                        {
                            //
                            // index is 1
                            //
                            GameName.shared.myArray.append(String("0"))
                        }
                        
                    }
                
                      GameName.shared.myArrayInf.append(String("0"))
                    myArrayBG.append(String("1"))
              
                }  // catch
            }
          
           
        } // index
    }
    func setupCollection()
    {
        
        TextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 70).isActive = true
        TextLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        //   TextView1.widthAnchor.constraint(equalToConstant: 40).isActive = true
        //    TextView1.heightAnchor.constraint(equalToConstant: 40).isActive = true
        TextLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        GameName.shared.width = Int(((view.frame.width ) / 4 ))
     //  print("carl width = \( GameName.shared.width)")
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
extension ChooseViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
      
        return 30 // GameName.shared.myArray1.count // 32 //dataSource.count
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
      //  let largeFont = UIFont.systemFont(ofSize: 60)
      //  let modFont = UIFont.systemFont(ofSize: 40)

        let cell = Collection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SelCollectionViewCell
        pCell = cell
         //   print("carl easy reload")
        cell.imagestar1.image  = UIImage(named:"clear")
        cell.imagestar2.image = UIImage(named: "clear")
        cell.imagestar3.image = UIImage(named: "clear")
        cell.layer.backgroundColor = UIColor.clear.cgColor //
        if indexPath.row <  30 // GameName.shared.myArray1.count-1
            {
               print("carl ind \(indexPath.row) lock \(GameName.shared.myArray[indexPath.row]) inf \(GameName.shared.myArrayInf[indexPath.row])")
               switch indexPath.row
                {
                    
                case 0:
                    SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num01")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
                    GameName.shared.ok = 0
                    GameName.shared.error = 0
                    break
                case 1:
                
                    SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num02")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
                   GameName.shared.ok = 0
                   GameName.shared.error = 0
                    break
                case 2:
                  
                    SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num03")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
           
                    break
                case 3:
                 
                    SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num04")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
            
                    break
                case 4:
                  
                    SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num05")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
            
                    break
                case 5:
                    SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num06")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
                   
              
                    break
                case 6:
                    SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num07")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
            
                    break
                case 7:
                    SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
         
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num08")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
                    break
                case 8:
                    SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
                  
             
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num09")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
                    break
                case 9:
                    SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
                  
              
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num10")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
                    break
                case 10:
                    SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num11")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
           
                    break
                case 11:
                    SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num12")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
             
                    break
                case 12:
                    SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
                  
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num13")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
                
                    break
                case 13:
                    SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
                   
              
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num14")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
                    break
                case 14:
                    SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
                  
            
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num15")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
                    break
                case 15:
                    SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
                    
       
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num16")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
                    break
                case 16:
                    SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
                  
          
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num17")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
                    break
                case 17:
                    SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
                  
             
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num18")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
                    break
                case 18:
                    SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
                  
            
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num19")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
                    break
                case 19:
                    SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num20")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
                    break
               case 20:
                   SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
        
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num21")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
                   break
               case 21:
                   SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
      
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num22")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
                   break
               case 22:
                   SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
         
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num23")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
                   break
               case 23:
                   SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
         
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num24")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
                   break
               case 24:
                   SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
         
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num25")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
                   break
               case 25:
                   SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
           
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num26")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
                   break
               case 26:
                   SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
      
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num27")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
                   
                   break
               case 27:
                   SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
        
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num28")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
               case 28:
                   SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
      
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num29")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
                   break
               case 29:
                   SetImage(ind: indexPath.row, _pressed: pCell as! SelCollectionViewCell)
                   if  GameName.shared.myArray[indexPath.row]  == "1"
                   {
                       cell.imagestar2.image = UIImage(named: "num30")
                   }
                   else
                   {
                       cell.imagestar2.image = UIImage(named: "Lock")
                   }
                   break
             
                default:
                    break
                }
                
        }
        return(cell)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
    //  print("Carl size \(view.frame.width)")
        return CGSize(width: (view.frame.width ) / 5, height: (view.frame.width - 10) / 5
     //  return CGSize(width: (view.frame.width )  / 5, height: (view.frame.width ) / 5
       )
     //  return CGSize(width: 120, height: 82)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
       
        print("Carl UIEdgeInsets")
        return UIEdgeInsets(top: 0.5, left: 0.5, bottom: 0.5, right: 0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        if collectionView ==   Collection
        {
        //    let cell = collectionView.cellForItem(at: indexPath)
         //   cell!.layer.borderWidth = 9.0
          //  cell!.layer.borderColor = UIColor.red.cgColor
         //   cell!.layer.backgroundColor = UIColor.gray.cgColor
          
            GameName.shared.ChooseLevel = 1
            GameName.shared.ename = "ceasy"
            GameName.shared.num = indexPath.row
         
            if  GameName.shared.myArray[indexPath.row] == "1"
            {
                print("carl func idx \(indexPath.row)")
                GameName.shared.saveArrayidx = indexPath.row  // MyArray 
                let controller = self.storyboard?.instantiateViewController(withIdentifier: "Choose") as! GameChooseViewController
                self.navigationController? .pushViewController(controller, animated:true)
               
            }
       
        }
     
    }
    func SetImage(ind: Int, _pressed: SelCollectionViewCell )
    {
      //  print("carl ind \(ind) lock \(GameName.shared.myArray[ind])")
        
        if GameName.shared.myArray[ind] == "1"
        {
           // _pressed.imagestar1.image = UIImage(named: "Lock")
        }
        else
        {
            _pressed.imagestar2.image = UIImage(named: "Lock")
        }
        if GameName.shared.myArrayInf[ind] == "0"
        {
            _pressed.imagestar1.image = UIImage(named:"clear")
        }
        else
        {
            if  GameName.shared.myArrayInf[ind] == "1"
            {
                _pressed.imagestar1.image = UIImage(named:"imag1")
            }
            else
            {
                if GameName.shared.myArrayInf[ind] == "2"
                {
                    _pressed.imagestar1.image = UIImage(named:"imag2")
                }
                else
                {
                    _pressed.imagestar1.image = UIImage(named:"imag3")
                }
            }
        }
        _pressed.imageView.image = UIImage(named: "Choose")
        
    }
}
