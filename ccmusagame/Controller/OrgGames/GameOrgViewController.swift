//
//  GameViewController.swift
//  ccmusagame
//
//  Created by Carl Hsieh on 5/21/19.
//  Copyright © 2019 Carl Hsieh. All rights reserved.
//

import UIKit



class GameOrgViewController: UIViewController
{
  
    
    let backgroundImageView = UIImageView()
  
    
    var timer = Timer()
    var minuties: Int  = 0
    var seconds: Int   = 0
    var fractions: Int = 0
    var gameTimer = Timer()
    var prevCell = UICollectionViewCell()
    var bible = "CellId"
    var bible1 = "CellId"
    var bible2 = "easy"
    var bible3 = "easy"
    var watchString = ""
    var filename = "med"
    var colViewQ: UICollectionView!
    var colViewA: UICollectionView!
    var imageViewImage: UIImage?
   
    var AImage: UIImage = UIImage(named: "sudoku")!
    var QImage: UIImage = UIImage(named: "sudoku")!
    var CImage: UIImage = UIImage(named: "cross")!
    var crossView: UIImageView!
  
    var ans:[Int] = []
    var indexrow : Int = 0
    var currentAnimation = 0
    var saveidx = 0
    var err = 0
    var idx = -1;
    var cnt = 0
    var okans = 0
    var loop = 0
    var erridx = 0
    var images = [#imageLiteral(resourceName: "clear"), #imageLiteral(resourceName: "clear"), #imageLiteral(resourceName: "clear"), #imageLiteral(resourceName: "clear"),#imageLiteral(resourceName:  "clear"),#imageLiteral(resourceName: "clear") ,#imageLiteral(resourceName: "clear") ,#imageLiteral(resourceName: "clear"), #imageLiteral(resourceName: "clear")]
    
  
    var selbtn = 0;
    let filer: Character = " "
    var  fname = ""
    var fnm = ""
    var  item: Array<Character> = Array()
    var  item1: Array<Character> = Array()
    var  item2: Array<Character> = Array()  //  聖因喜心望滿樂平充你的靈力盼信能安們
    var  item3: Array<Character> = Array()
    var  item4: Array<Character> = Array()
    
    let TimeLabel: UILabel =       // Title
    {
        let textViewLab = UILabel()
        
        textViewLab.font = UIFont.boldSystemFont(ofSize: 18)
        textViewLab.translatesAutoresizingMaskIntoConstraints = false
        textViewLab.textColor = .brown
       
        return textViewLab
        
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
    
    let errCollection: UICollectionView =
    {
        let BibleEview = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: BibleEview)
        collection.backgroundColor = UIColor.clear
        collection.translatesAutoresizingMaskIntoConstraints = false
      
        return collection
    }()
    
    lazy var svButtons3: UIStackView =
    {
        let stackView = UIStackView(arrangedSubviews: [skipbtn, resbtn])
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        return stackView
    }()
    lazy var resbtn: UIButton =
    {
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 12
        btn.backgroundColor = .green
        btn.setTitle("看結果", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 22, weight: .semibold)
        btn.isEnabled = false
        btn.addTarget(self, action: #selector(presentModalController), for: .touchUpInside)
        view.addSubview(btn)
        return btn
    }()
    lazy var skipbtn: UIButton =
    {
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 12
        btn.backgroundColor = .green
        btn.setTitle("越過", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 22, weight: .semibold)
       
        btn.addTarget(self, action: #selector(presentSkipController), for: .touchUpInside)
       // addTarget(self, action: #selector(showTransparent(_:)), for: .touchUpInside)
        view.addSubview(btn)
        return btn
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
     //   backgroundImageView.image = UIImage(named: "BK-1")
        view.sendSubviewToBack(backgroundImageView)
    
        qnsCollection.delegate = self as UICollectionViewDelegate
        qnsCollection.dataSource = self as UICollectionViewDataSource
        qnsCollection.register(CustomeCellqns.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(qnsCollection)
        
        errCollection.delegate = self as UICollectionViewDelegate
        errCollection.dataSource = self as UICollectionViewDataSource
        errCollection.register(CustomeCell.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(errCollection)
        
        ansCollection.delegate = self as UICollectionViewDelegate
        ansCollection.dataSource = self as UICollectionViewDataSource
        ansCollection.register(CustomeCell.self, forCellWithReuseIdentifier: "Cell")
        
        view.addSubview(ansCollection)
        view.addSubview(TimeLabel)
        print("Carl in to Game is Level  \( GameName.shared.level )")
   //     GameName.shared.OrgLevel = 1
        
        setupCollectionlevel3()
       
        if GameName.shared.level == 0   // 容易
        {
         //   print("Carl  no = \(GameName.shared.num)")
            fname = GameName.shared.ename + String(GameName.shared.num )
               
        }
        else
        {
            if GameName.shared.level == 1    // 較難
            {
                fname = GameName.shared.mname + String(GameName.shared.mnum )
                
            }
            else
            {
                
                if GameName.shared.level == 2   // 更難
                {
                    fname = GameName.shared.hname + String(GameName.shared.hnum )
                }
            }
        }
        
        print("Carl level  read file \(fname )  \(GameName.shared.level )")
        if let filepath = Bundle.main.path(forResource: fname, ofType: "txt")
        {
            // print("Carl name \(filepath)")
            do
            {
                let contents  = try String(contentsOfFile: filepath)
                let lines = contents.split(separator: "\r\n")
                
                for line in lines
                {
                    if loop == 0
                    {
                        //
                        //  全部聖經經節   item1
                        //
                        item1 = Array(line)
                        loop = 1
                        /* bible1   "有施散的，卻更增添；有吝惜過度的，反致窮乏。好施捨的，必得豐裕；滋潤人的，必得滋潤。"    */
                        bible1 = String(line)
                        GameName.shared.item1 = bible1
                        //  print("item1\(item1)")
                    }
                    else
                    {
                        if loop == 1
                        {
                            //
                            // 有空格聖經經節 item`
                            //
                            item  = Array(line)
                            loop = 2
                            /* bible   "有施散的，卻更增添；有吝惜過度的，反致窮乏。好  的，必   ；滋潤人的，必得滋潤。"    */
                            bible = String(line)
                            GameName.shared.item = bible
                            // print("item\(item)")
                        }
                        else
                        {
                            if loop == 2
                            {
                                //
                                // 答案聖經經節 item2
                                //
                                item2 = Array(line)
                                loop = 3
                                bible2 = String(line)
                                GameName.shared.item2 = bible2
                                 print("Carl item2 \(bible2)")
                            }
                            else
                            {
                                if loop == 3
                                {
                                    //
                                    // 聖經經節 item3
                                    //
                                    item3 = Array(line)
                                    loop = 4
                                    bible3 = String(line)
                                    GameName.shared.item3 = bible3
                                    print("carl  \(bible3)")
                                }
                            }
                        }
                    }
                }
            }
            catch
            {
                print("Contents could not be loaded.")
            }
        }
        else
        {
            print("newTest.txt not found.")
        }
       /* 
       for num  in 0 ... 399
            {
             fnm =  "hard" + String(num)
        //    print("cfh =\(fnm)")
           
               if let filepath = Bundle.main.path(forResource: fnm, ofType: "txt")
               {
                   //  print("cfh \(fnm)")
                   do
                   {
                       let contents  = try String(contentsOfFile: filepath)
                       let lines = contents.split(separator: "\r\n")
                       
                       for line in lines
                       {
                           if loop == 0
                           {
                               //
                               //  全部聖經經節   item1
                               //
                               item1 = Array(line)
                               loop = 1
                               /* bible1   "有施散的，卻更增添；有吝惜過度的，反致窮乏。好施捨的，必得豐裕；滋潤人的，必得滋潤。"    */
                               bible1 = String(line)
                               GameName.shared.item1 = bible1
                               //  print("item1\(item1)")
                           }
                           else
                           {
                               if loop == 1
                               {
                                   //
                                   // 有空格聖經經節 item`
                                   //
                                   item  = Array(line)
                                   loop = 2
                                   /* bible   "有施散的，卻更增添；有吝惜過度的，反致窮乏。好  的，必   ；滋潤人的，必得滋潤。"    */
                                   bible = String(line)
                                   GameName.shared.item = bible
                                   // print("item\(item)")
                               }
                               else
                               {
                                   if loop == 2
                                   {
                                       //
                                       // 答案聖經經節 item2
                                       //
                                       item2 = Array(line)
                                       loop = 3
                                       bible2 = String(line)
                                       GameName.shared.item2 = bible2
                                       //   print("Carl item2 \(item2)")
                                   }
                                   else
                                   {
                                       if loop == 3
                                       {
                                           //
                                           // 聖經經節 item3
                                           //
                                           item3 = Array(line)
                                           loop = 4
                                           bible3 = String(line)
                                           GameName.shared.item3 = bible3
                                           print("cfh  \(num) \(bible3)")
                                       }
                                   }
                               }
                           }
                       }
                   }
                   catch
                   {
                       print("Contents could not be loaded.")
                   }
               }
               else
               {
                   print("newTest.txt not found.")
               }
              loop = 0
           
        }  // for
       */
        for _ in 1 ... item2.count
        {
            ans.append(0)
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameOrgViewController.startGameTimer), userInfo: nil, repeats: true)
        
    
        if GameName.shared.level == 0
        {
            GameName.shared.num = GameName.shared.num
            //  print("2 num = \(GameName.shared.num)")
        }
        else
        {
            if GameName.shared.level == 1
            {
                GameName.shared.mnum = GameName.shared.mnum
                //  print("2 mnum = \(GameName.shared.mnum)")
            }
            else
            {
                if GameName.shared.level == 2
                {
                    GameName.shared.hnum = GameName.shared.hnum
                    // print("2 hnum = \(GameName.shared.hnum)")
                }
            }
            
        }
        /*
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
        
      
        //Creating the chevron (back-arrow) to look like Apple's..
        let img = makeBackChevron(thickness: 3.0, size: CGSize(width: 22.0, height: 44.0), colour: nil)! //UIColor.red
        
        //Creating the bar button.. Note: Add your own target and action..
        let barButton = UIBarButtonItem(image: img, style: .done, target: nil, action:  #selector(self.backAction(_:)))
        
        //Set the left bar button item to be the one we created
        //Then set the items to be part of the navigation bar we created..
        item.leftBarButtonItems = [barButton]
        navigationBar.setItems([item], animated: true)
        
        print("carl width xxx \(GameName.shared.width)")  */
    }  // viewDidLoad
    @objc func presentSkipController() {
        GameName.shared.skip = 1
    //    let vc = CustomModalViewController()
     //   vc.modalPresentationStyle = .overCurrentContext
      //  self.present(vc, animated: false)
        
    }
    @objc func presentModalController() {
        //
        // check game over here ????
        //
      
      //  if ( cnt == item2.count)
     //   if resbtn.isEnabled == true
    //    {
         //   let vc = CustomModalViewController()
         //   vc.modalPresentationStyle = .overCurrentContext
         //   self.present(vc, animated: false)
   //     }
   //     else
    //    {
            //
            //  add error
            //
     //   }
    }
   
    func setupCollectionlevel3()
    {
         view.addSubview(TimeLabel)
         TimeLabel.translatesAutoresizingMaskIntoConstraints = false
         TimeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 150).isActive = true
        TimeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
       //  TimeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 200).isActive = true
         TimeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0).isActive = true
        TimeLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        TimeLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
     
       
        GameName.shared.width = Int(((view.frame.width - 10) / 9 ))
     //  print("carl width = \( GameName.shared.width)")
        qnsCollection.topAnchor.constraint(equalTo: TimeLabel.bottomAnchor,constant: 10).isActive = true
        qnsCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        qnsCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        qnsCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        qnsCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        qnsCollection.heightAnchor.constraint(equalToConstant: 350  ).isActive = true   // 可以27答案
        qnsCollection.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        if GameName.shared.width > 80
        {
            qnsCollection.heightAnchor.constraint(equalToConstant: 800).isActive = true
            
        }
        else
        {
            if GameName.shared.width > 30
            {
               qnsCollection.heightAnchor.constraint(equalToConstant: 900).isActive = true
               
            }
            else
            {
                  qnsCollection.heightAnchor.constraint(equalToConstant: 350 ).isActive = true
               
            }
        }
        
        ansCollection.topAnchor.constraint(equalTo:  qnsCollection.bottomAnchor,constant: 50).isActive = true
        ansCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        ansCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        ansCollection.heightAnchor.constraint(equalToConstant: 150  ).isActive = true   // 可以27答案
        ansCollection.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
      
        svButtons3.translatesAutoresizingMaskIntoConstraints = false
        svButtons3.topAnchor.constraint(equalTo: ansCollection.bottomAnchor, constant: 50).isActive = true
    
        svButtons3.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        svButtons3.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        svButtons3.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        svButtons3.heightAnchor.constraint(equalToConstant: 40).isActive = true
        svButtons3.translatesAutoresizingMaskIntoConstraints = false
        
        
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
    @objc func startGameTimer()
    {
        
        fractions  += 1
        if fractions == 100
        {
            seconds += 1
            fractions = 0
        }
        if seconds == 60
        {
            minuties += 1
            seconds = 0
        }
        let fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutiesString = minuties > 9 ? "\(minuties)" : "0\(minuties)"
        watchString = "\(minutiesString):\(secondsString).\(fractionsString)"
        TimeLabel.text = watchString
        
        
    }
}
extension GameOrgViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == qnsCollection
        {
           
            return item.count
        }
        else
        {
            if collectionView == ansCollection
            {
               
                return item2.count
            }
            else
            {
                   return images.count
            }
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
          //
          //
          //
          if (collectionView == ansCollection)   // 答案
          {
               //
               //  insert text here  ex:施豐使捨得裕備
               // 
                let cell = ansCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomeCell
                
                if GameName.shared.level == 0   // 容易
                {
                    if ans[indexPath.row] == 0
                    {
                            
                        if item2[indexPath.row] == filer
                        {
                           // cell.imageView.image = UIImage(named: "clear")
                            cell.textLabel.text?  = String("")
                        }
                        else
                        {
                           
                           cell.imageView.image = UIImage(named: "slot")
                           cell.textLabel.text = String(item2[indexPath.row])
                      
                        }
                    }
                    else
                    {
                      
                      
                      //  cell.imageView.image = UIImage(named: "clear")
                        cell.textLabel.text = String(item2[indexPath.row])
                    }
                }
                else
                {
                    if GameName.shared.level == 1   // 較難
                    {
                        if (okans == 1)
                        {
                             switch indexPath.row
                             {
                                case  0:
                                    if item2[indexPath.row] == filer
                                    {
                                        if  ans[indexPath.row] ==  1
                                        {
                                            cell.imageView.image =  UIImage(named: "clear")
                                        }
                                        else
                                        {
                                            cell.imageView.image =  UIImage(named: "clear")
                                        }
                                        cell.textLabel.text? = String("")
                                    }
                                    else
                                    {
                                        
                                        // cell.imageView.image = UIImage(named: "sudoku")
                                        cell.imageView.image = UIImage(named: "slot")
                                        cell.textLabel.text  = String(item2[indexPath.row])
                                        if  ans[indexPath.row] ==  1
                                        {
                                            //
                                            //  change to clear
                                            //
                                            cell.imageView.image =  UIImage(named: "clear")
                                        }
                                    }
                                    break
                                case 1:
                                
                                    if item2[indexPath.row] == filer
                                    {
                                        if selbtn == 0
                                        {
                                            if  ans[indexPath.row] ==  1
                                            {
                                                cell.imageView.image =  UIImage(named: "clear")
                                            }
                                            else
                                            {
                                                cell.imageView.image =  UIImage(named: "clear")
                                            }
                                        }
                                        else
                                        {
                                            cell.imageView.image = UIImage(named: "clear")
                                        }
                                        cell.textLabel.text? = String("")
                                    }
                                    else
                                    {
                                        cell.imageView.image = UIImage(named: "slot")
                                        cell.textLabel.text? = String("")
                                    //  cell.textLabel.text  = String(item2[indexPath.row])
                                    }
                                    break
                                case 2:
                                    if item2[indexPath.row] == filer
                                    {
                                    
                                        if  ans[indexPath.row] ==  1
                                        {
                                            cell.imageView.image =  UIImage(named: "clear")
                                        }
                                        else
                                        {
                                            cell.imageView.image =  UIImage(named: "clear")
                                        }
                                        cell.textLabel.text? = String("")
                                    }
                                    else
                                    {
                                        cell.imageView.image = UIImage(named: "slot")
                                        cell.textLabel.text  = String(item2[indexPath.row])
                                        if  ans[indexPath.row] ==  1
                                        {
                                            cell.imageView.image =  UIImage(named: "clear")
                                        }
                                    }
                                    break
                                
                                case  3:
                                    if item2[indexPath.row] == filer
                                    {
                                        if selbtn == 0
                                        {
                                            if  ans[indexPath.row] ==  1
                                            {
                                                cell.imageView.image =  UIImage(named: "clear")
                                            }
                                            else
                                            {
                                                cell.imageView.image =  UIImage(named: "clear")
                                            }
                                        }
                                        else
                                        {
                                            cell.imageView.image = UIImage(named: "clear")
                                        }
                                        cell.textLabel.text? = String("")
                                    }
                                    else
                                    {
                                        cell.imageView.image = UIImage(named: "slot")
                                        cell.textLabel.text? = String("")
                                        //  cell.textLabel.text  = String(item2[indexPath.row])
                                    }
                                    break
                                case 4:
                                    if item2[indexPath.row] == filer
                                    {
                                        
                                        if  ans[indexPath.row] ==  1
                                        {
                                            cell.imageView.image =  UIImage(named: "clear")
                                        }
                                        else
                                        {
                                            cell.imageView.image =  UIImage(named: "clear")
                                        }
                                        cell.textLabel.text? = String("")
                                    }
                                    else
                                    {
                                        cell.imageView.image = UIImage(named: "slot")
                                        cell.textLabel.text  = String(item2[indexPath.row])
                                        if  ans[indexPath.row] ==  1
                                        {
                                            cell.imageView.image =  UIImage(named: "clear")
                                        }
                                    }
                                    break
                                case 5:
                                    if item2[indexPath.row] == filer
                                    {
                                        if selbtn == 0
                                        {
                                            if  ans[indexPath.row] ==  1
                                            {
                                                cell.imageView.image =  UIImage(named: "clear")
                                            }
                                            else
                                            {
                                                cell.imageView.image =  UIImage(named: "clear")
                                            }
                                        
                                        }  //  selbtn == 0
                                        else
                                        {
                                            cell.imageView.image = UIImage(named: "clear")
                                        }
                                        cell.textLabel.text? = String("")
                                    }  //  item2[indexPath.row] == filer
                                    else
                                    {
                                        cell.textLabel.text? = String("")
                                        cell.imageView.image = UIImage(named: "slot")
                                    }
                                    break
                                case 6:
                                    if item2[indexPath.row] == filer
                                    {
                                        if  ans[indexPath.row] ==  1
                                        {
                                            cell.imageView.image =  UIImage(named: "clear")
                                        }
                                        else
                                        {
                                            cell.imageView.image =  UIImage(named: "clear")
                                        }
                                        cell.textLabel.text? = String("")
                                    }
                                    else
                                    {
                                        cell.imageView.image = UIImage(named: "slot")
                                        cell.textLabel.text = String(item2[indexPath.row])
                                        if  ans[indexPath.row] ==  1
                                        {
                                            cell.imageView.image =  UIImage(named: "clear")
                                        }
                                    }
                                    break
                                case 7:
                                    if item2[indexPath.row] == filer
                                    {
                                        if selbtn == 0
                                        {
                                            if  ans[indexPath.row] ==  1
                                            {
                                                cell.imageView.image =  UIImage(named: "clear")
                                            }
                                            else
                                            {
                                                cell.imageView.image =  UIImage(named: "clear")
                                            }
                                        
                                        }
                                        else
                                        {
                                            cell.imageView.image = UIImage(named: "clear")
                                        }
                                        cell.textLabel.text? = String("")
                                    }
                                    else
                                    {
                                        cell.textLabel.text? = String("")
                                        cell.imageView.image = UIImage(named: "slot")
                                        // cell.imageView.image = UIImage(named: "sudoku")
                                    }
                                    break
                                case  8:
                                    if item2[indexPath.row] == filer
                                    {
                                        
                                        if  ans[indexPath.row] ==  1
                                        {
                                            cell.imageView.image =  UIImage(named: "clear")
                                        }
                                        else
                                        {
                                            cell.imageView.image =  UIImage(named: "clear")
                                        }
                                        cell.textLabel.text? = String("")
                                    }
                                    else
                                    {
                                        cell.imageView.image = UIImage(named: "slot")
                                        cell.textLabel.text  = String(item2[indexPath.row])
                                        if  ans[indexPath.row] ==  1
                                        {
                                            cell.imageView.image =  UIImage(named: "clear")
                                        }
                                    }
                                    break
                                case  9:
                                    if item2[indexPath.row] == filer
                                    {
                                        if selbtn == 0
                                        {
                                            if  ans[indexPath.row] ==  1
                                            {
                                                cell.imageView.image =  UIImage(named: "clear")
                                            }
                                            else
                                            {
                                                cell.imageView.image =  UIImage(named: "clear")
                                            }
                                        
                                        }
                                        else
                                        {
                                            cell.imageView.image = UIImage(named: "clear")
                                        }
                                        cell.textLabel.text? = String("")
                                    }
                                    else
                                    {
                                        cell.textLabel.text? = String("")
                                        cell.imageView.image = UIImage(named: "slot")
                                        // cell.imageView.image = UIImage(named: "sudoku")
                                    }
                                break
                                
                             default:
                                print("Otherwise, do something else.")
                            }
                        }
                        else
                        {
                            if ans[indexPath.row] == 0
                            {
                               cell.imageView.image = UIImage(named: "slot")
                               cell.textLabel.text = String(item2[indexPath.row])
                            }
                            else
                            {
                                cell.imageView.image = UIImage(named: "slot")
                                cell.textLabel.text = String(item2[indexPath.row])
                            }
                              
                        }
                    }
                    else
                    {
                        if GameName.shared.level == 2   // 更難
                        {
                            
                            if (okans == 1)
                            {
                                
                                 switch indexPath.row {
                                   
                                    case 0:
                                        if item2[indexPath.row] == filer
                                        {
                                              cell.imageView.image = UIImage(named: "clear")
                                        }
                                        else
                                        {
                                            cell.imageView.image = UIImage(named: "slot")
                                            cell.textLabel.text? = String("")
                                           
                                        }
                                        break
                                    case 1:
                                        if item2[indexPath.row] == filer
                                        {
                                              cell.imageView.image = UIImage(named: "clear")
                                        }
                                        else
                                        {
                                            cell.imageView.image = UIImage(named: "slot")
                                            cell.textLabel.text? = String("")
                                           
                                        }
                                        break
                                    case 2:
                                        if item2[indexPath.row] == filer
                                        {
                                              cell.imageView.image = UIImage(named: "clear")
                                        }
                                        else
                                        {
                                            cell.imageView.image = UIImage(named: "slot")
                                            cell.textLabel.text? = String("")
                                           
                                        }
                                        break
                                    case 3:
                                        if item2[indexPath.row] == filer
                                        {
                                              cell.imageView.image = UIImage(named: "clear")
                                        }
                                        else
                                        {
                                            cell.imageView.image = UIImage(named: "slot")
                                            cell.textLabel.text? = String("")
                                           
                                        }
                                        break
                                    case 4:
                                        if item2[indexPath.row] == filer
                                        {
                                              cell.imageView.image = UIImage(named: "clear")
                                        }
                                        else
                                        {
                                            cell.imageView.image = UIImage(named: "slot")
                                            cell.textLabel.text? = String("")
                                           
                                        }
                                        break
                                    case 5:
                                        if item2[indexPath.row] == filer
                                        {
                                              cell.imageView.image = UIImage(named: "clear")
                                        }
                                        else
                                        {
                                            cell.imageView.image = UIImage(named: "slot")
                                            cell.textLabel.text? = String("")
                                           
                                        }
                                        break
                                    case 6:
                                        if item2[indexPath.row] == filer
                                        {
                                              cell.imageView.image = UIImage(named: "clear")
                                        }
                                        else
                                        {
                                            cell.imageView.image = UIImage(named: "slot")
                                            cell.textLabel.text? = String("")
                                           
                                        }
                                        break
                                    case 7:
                                        if item2[indexPath.row] == filer
                                        {
                                              cell.imageView.image = UIImage(named: "clear")
                                        }
                                        else
                                        {
                                            cell.imageView.image = UIImage(named: "slot")
                                            cell.textLabel.text? = String("")
                                            
                                        }
                                        break
                                    case 8:
                                        if item2[indexPath.row] == filer
                                        {
                                              cell.imageView.image = UIImage(named: "clear")
                                        }
                                        else
                                        {
                                            cell.imageView.image = UIImage(named: "slot")
                                            cell.textLabel.text? = String("")
                                            
                                        }
                                        break
                                    case 9:
                                        if item2[indexPath.row] == filer
                                        {
                                            cell.imageView.image = UIImage(named: "clear")
                                        }
                                        else
                                        {
                                            cell.imageView.image = UIImage(named: "slot")
                                            cell.textLabel.text? = String("")
                                          
                                        }
                                        break
                                    case 10:
                                        if item2[indexPath.row] == filer
                                        {
                                            cell.imageView.image = UIImage(named: "clear")
                                        }
                                        else
                                        {
                                            cell.imageView.image = UIImage(named: "slot")
                                            cell.textLabel.text? = String("")
                                           
                                        }
                                        break
                                    case 11:
                                        if item2[indexPath.row] == filer
                                        {
                                            cell.imageView.image = UIImage(named: "clear")
                                        }
                                        else
                                        {
                                            cell.imageView.image = UIImage(named: "slot")
                                            cell.textLabel.text? = String("")
                                          
                                        }
                                        break
                                    case 12:
                                        if item2[indexPath.row] == filer
                                        {
                                             cell.imageView.image = UIImage(named: "clear")
                                        }
                                        else
                                        {
                                            cell.imageView.image = UIImage(named: "slot")
                                            cell.textLabel.text? = String("")
                                           
                                        }
                                        break
                                    case 13:
                                        if item2[indexPath.row] == filer
                                        {
                                            cell.imageView.image = UIImage(named: "clear")
                                        }
                                        else
                                        {
                                            cell.imageView.image = UIImage(named: "slot")
                                            cell.textLabel.text? = String("")
                                           
                                        }
                                        break
                                    case 14:
                                        if item2[indexPath.row] == filer
                                        {
                                             cell.imageView.image = UIImage(named: "clear")
                                        }
                                        else
                                        {
                                            cell.imageView.image = UIImage(named: "slot")
                                            cell.textLabel.text? = String("")
                                           
                                        }
                                        break
                                    case 15:
                                        if item2[indexPath.row] == filer
                                        {
                                            cell.imageView.image = UIImage(named: "clear")
                                        }
                                        else
                                        {
                                            cell.imageView.image = UIImage(named: "slot")
                                            cell.textLabel.text? = String("")
                                           
                                        }
                                        break
                                    case 16:
                                        if item2[indexPath.row] == filer
                                        {
                                            cell.imageView.image = UIImage(named: "clear")
                                        }
                                        else
                                        {
                                            cell.imageView.image = UIImage(named: "slot")
                                            cell.textLabel.text? = String("")
                                          
                                        }
                                        break
                                    case 17:
                                        if item2[indexPath.row] == filer
                                        {
                                            cell.imageView.image = UIImage(named: "clear")
                                            
                                        }
                                        else
                                        {
                                            cell.imageView.image = UIImage(named: "slot")
                                            cell.textLabel.text? = String("")
                                           
                                        }
                                        break
                                    case 18:
                                        if item2[indexPath.row] == filer
                                        {
                                            cell.imageView.image = UIImage(named: "clear")
                                        }
                                        else
                                        {
                                            cell.imageView.image = UIImage(named: "slot")
                                            cell.textLabel.text? = String("")
                                           
                                        }
                                        break
                                    case 19:
                                        if item2[indexPath.row] == filer
                                        {
                                              cell.imageView.image = UIImage(named: "clear")
                                        }
                                        else
                                        {
                                            cell.imageView.image = UIImage(named: "slot")
                                            cell.textLabel.text? = String("")
                                           
                                        }
                                        break
                                    case 20:
                                        if item2[indexPath.row] == filer
                                        {
                                              cell.imageView.image = UIImage(named: "clear")
                                        }
                                        else
                                        {
                                            cell.imageView.image = UIImage(named: "slot")
                                            cell.textLabel.text? = String("")
                                        }
                                        break
                                 default:
                                        print("Otherwise, do something else.")
                                }
                               
                                    
                            }
                            else
                            {
                                cell.imageView.image = UIImage(named: "slot")
                                cell.textLabel.text = String(item2[indexPath.row])
                            }
                        }
                    }
                }
               
                return cell
               
            }
            else  // qnsCollection here
            {
                
                let cell = qnsCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomeCellqns
                
                if GameName.shared.level == 0
                {
                    if item[indexPath.row] == filer
                    {
                        
                        cell.textLabel.text =  String(item[indexPath.row])
                        cell.imageView.image = UIImage(named: "slot")
                        if cnt  == 0
                        {
                              GameName.shared.item2count += 1
                         //   print("Carl cnt = \(cnt) count = \(GameName.shared.item2count )")
                        }
                    }
                    else
                    {
                      
                        cell.textLabel.text =  String(item[indexPath.row])
                        cell.imageView.image = UIImage(named: "sudoku")
                       // cell.imageView.image = UIImage(named: "Easybtn")
                        if (indexPath.row == idx)
                        {
                            cell.transform = CGAffineTransform(scaleX: 10, y: 10)
                            UIView.animate(withDuration: 1) {
                                cell.transform = CGAffineTransform.identity
                            }
                        }
                    }
                }
                else
                {
                    if GameName.shared.level == 1  // 較難
                    {
                        if item[indexPath.row] == filer
                        {
                            cell.textLabel.text =  String(item[indexPath.row])
                            cell.imageView.image = UIImage(named: "slot")
                    //        print("carl level 2")
                       //     print("carl filer item2count = \(GameName.shared.item2count)")
                            if cnt  == 0
                            {
                                  GameName.shared.item2count += 1
                        //        print("Carl cnt = \(cnt) count = \(GameName.shared.item2count )")
                            }
                        }
                        else
                        {
                            cell.textLabel.text =  String(item[indexPath.row])
                            cell.imageView.image = UIImage(named: "sudoku")
                            if (indexPath.row == idx)
                            {
                                cell.transform = CGAffineTransform(scaleX: 10, y: 10)
                                UIView.animate(withDuration: 1) {
                                    cell.transform = CGAffineTransform.identity
                                }
                            }
                        }
                       
                    }
                    else
                    {
                        if GameName.shared.level == 2  // 更難
                        {
                            if item[indexPath.row] == filer
                            {
                                cell.textLabel.text =  String(item[indexPath.row])
                                cell.imageView.image = UIImage(named: "slot")
                                if cnt  == 0
                                {
                                      GameName.shared.item2count += 1
                              //      print("Carl cnt = \(cnt) count = \(GameName.shared.item2count )")
                                }
                            }
                            else
                            {
                                cell.textLabel.text =  String(item[indexPath.row])
                                cell.imageView.image = UIImage(named: "sudoku")
                                if (indexPath.row == idx)
                                {
                                    cell.transform = CGAffineTransform(scaleX: 10, y: 10)
                                    UIView.animate(withDuration: 1) {
                                        cell.transform = CGAffineTransform.identity
                                    }
                                }
                            }
                           
                        }
                    }
                }  // GameName.shared.level == 1
                return(cell)
            }  //   end qnsCollection
   
            
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
            return CGSize(width: (view.frame.width - 10) / 10, height: (view.frame.width - 10) / 10)
           
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
        {
            return UIEdgeInsets(top: 0.5, left: 0.5, bottom: 0.5, right: 0.5)
        }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
        {
            
            prevCell.layer.borderWidth = 0
            let cell = collectionView.cellForItem(at: indexPath)
            cell!.layer.borderWidth = 2.0
            cell!.layer.borderColor = UIColor.yellow.cgColor
            prevCell = cell!
            if collectionView == qnsCollection
            {
                idx = indexPath.row
                selbtn = 1;
                prevCell.layer.borderWidth = 0
                let cell = collectionView.cellForItem(at: indexPath)
                cell!.layer.borderWidth = 2.0
                cell!.layer.borderColor = UIColor.yellow.cgColor
                prevCell = cell!
               
                if item[indexPath.row] ==  filer
                {
                    cell!.layer.borderWidth = 4.0
                    
                    saveidx = indexPath.row
                    GameName.shared.item = bible
                }
                else
                {
                    self.showToast(message: "觸摸空格間..", type: "0")
                    cell!.layer.borderWidth = 0
                    selbtn = 0
                    
                }
            }
            else
            {
                if collectionView == ansCollection
                {
                    
                    //
                    //   item2 = 施豐使捨得裕備
                    //   item1 = 有施散的，卻更增添；有吝惜過度的，反致窮乏。好施捨的，必得豐裕；滋潤人的，必得滋潤
                    if ( item1[saveidx] == item2[indexPath.row])
                    {
                        
                        item[saveidx] = item2[indexPath.row]
                     
                        GameName.shared.item = String(item)
                        
                        cnt = cnt + 1
                   //     print("Carl start  cnt = \(cnt)")
                        GameName.shared.anscount = cnt
                        prevCell.layer.borderWidth = 0
                        ans[indexPath.row] = 1
                        item2[indexPath.row] = filer
                        GameName.shared.item2 = String(item2)
                        ansCollection.reloadData()
                        qnsCollection.reloadData()
                        selbtn = 0
                  
                        
                    }
                    else
                    {
                        if selbtn == 0
                        {
                            self.showToast(message: "請首先選擇空間格..", type: "0")
                        }
                        else
                        {
                            images[err] =  CImage
                            err = err + 1
                            GameName.shared.err = err
                            prevCell.layer.borderWidth = 0
                            errCollection.reloadData()
                            if (GameName.shared.level == 0 )
                            {
                                self.showToast(message: "選擇錯誤!注意只能錯四個字", type: "1")
                            }
                            else
                            {
                                if (GameName.shared.level == 1 )
                                {
                                    self.showToast(message: "選擇錯誤!注意只能錯六個字", type: "1")
                                }
                                else
                                {
                                    if (GameName.shared.level == 2 )
                                    {
                                        self.showToast(message: "選擇錯誤!注意只能錯八個字", type: "1")
                                    }
                                }
                                
                            }
                            GameName.shared.item = String(item)
                          //  print("item err = \(item)")
                          //  print("Game item err = \(GameName.shared.item )")
                            if GameName.shared.level == 0
                            {
                                if err == 4
                                {
                                    GameName.shared.OrgLevel = 1
                                    GameName.shared.over = 1
                                    GameName.shared.item = bible
                                    GameName.shared.item1 = bible1
                                    GameName.shared.item2 = bible2
                                    GameName.shared.item3 = bible3
                                    GameName.shared.err = err
                                    GameName.shared.fractions = fractions
                                    GameName.shared.seconds = seconds
                                    GameName.shared.minuties = minuties
                              //      let vc = CustomModalViewController()
                              //      vc.modalPresentationStyle = .overCurrentContext
                                  //  self.present(vc, animated: false)
                                }
                                else
                                {
                                    
                                }
                            }
                            else
                            {
                                if GameName.shared.level == 1
                                {
                                    if err == 6
                                    {
                                        GameName.shared.over = 1
                                        GameName.shared.item = bible
                                        GameName.shared.item1 = bible1
                                        GameName.shared.item2 = bible2
                                        GameName.shared.item3 = bible3
                                        GameName.shared.err = err
                                        GameName.shared.fractions = fractions
                                        GameName.shared.seconds = seconds
                                        GameName.shared.minuties = minuties
                                        GameName.shared.OrgLevel = 1
                                   //     let vc = CustomModalViewController()
                               //         vc.modalPresentationStyle = .overCurrentContext
                                 //       self.present(vc, animated: false)
                                        /*
                                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Back") as! UINavigationController
                                        self.present(vc, animated: true, completion: nil)  */
                                    }
                                }
                                else
                                {
                                    if GameName.shared.level == 2
                                    {
                                        if err == 8
                                        {
                                            GameName.shared.over = 1
                                            GameName.shared.item = bible
                                            GameName.shared.item1 = bible1
                                            GameName.shared.item2 = bible2
                                            GameName.shared.item3 = bible3
                                            GameName.shared.err = err
                                            GameName.shared.fractions = fractions
                                            GameName.shared.seconds = seconds
                                            GameName.shared.minuties = minuties
                                            GameName.shared.OrgLevel = 1
                                            /*
                                            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Back") as! UINavigationController
                                            self.present(vc, animated: true, completion: nil)
                                             */
                                   //         let vc = CustomModalViewController()
                                //           vc.modalPresentationStyle = .overCurrentContext
                                 //           self.present(vc, animated: false)
                                        }
                                    }
                                }
                            }
                        }
                     
                    }
             
               //     print("carl cnt =\(cnt ) count = \(GameName.shared.item2count))")
                    if ( cnt == GameName.shared.item2count)  // end of game
                    {
                        timer.invalidate()
                        GameName.shared.item = bible
                        GameName.shared.item1 = bible1
                        GameName.shared.item2 = bible2
                        GameName.shared.item3 = bible3
                        GameName.shared.err = err
                        GameName.shared.fractions = fractions
                        GameName.shared.seconds = seconds
                        GameName.shared.minuties = minuties
                        GameName.shared.OrgMove = 1
                        resbtn.isEnabled = true
                        //
                        //  reset  
                        //
                        GameName.shared.item2count = 0
                        cnt = 0
                        /*
                        let vc1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Back") as! UINavigationController
                        self.present(vc1, animated: true, completion: nil)  */
                    }
                    else
                    {
                        if (cnt > item2.count)
                        {
                            let vc1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Back") as! UINavigationController
                            self.present(vc1, animated: true, completion: nil)
                        }
                    }
                }
                
            }
    }
  
    @IBAction func backAction(_ sender: UIButton)
    {
        
        GameName.shared.btnenable = true
        
        let fileManger = FileManager.default
        let doumentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let filePath = doumentDirectoryPath.appendingPathComponent("data.txt")
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
            let url = dir.appendingPathComponent("data.txt")
            
      //     print("go back GameName cnt   = \(GameName.shared.cnt)")
           // print("go back item = \(item)")
           // GameName.shared.item = item
            try GameName.shared.item.appendLineToURL(fileURL: url as URL)
            try GameName.shared.item1.appendLineToURL(fileURL: url as URL)
            try GameName.shared.item2.appendLineToURL(fileURL: url as URL)
            try GameName.shared.item3.appendLineToURL(fileURL: url as URL)
            try String(GameName.shared.err).appendLineToURL(fileURL: url as URL)
            try String(GameName.shared.anscount).appendLineToURL(fileURL: url as URL)
            try String(GameName.shared.okans).appendLineToURL(fileURL: url as URL)
            try String(contentsOf: url as URL, encoding: String.Encoding.utf8)
            
        }
        catch {
            print("Could not write to file")
        }
      
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameHome") as! MainViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
     func createAlert(title:String, message:String)
     {
        let alert = UIAlertController(title: title, message:message, preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
 
        // change to desired number of seconds (in this case 5 seconds)
        let when = DispatchTime.now() + 10
        DispatchQueue.main.asyncAfter(deadline: when)
        {
            // your code with delay
            self.okans = 1
            GameName.shared.okans = self.okans
            self.ansCollection.reloadData()
            alert.dismiss(animated: true, completion: nil)
        }
    }
   
    
    
    func Level2Alert(title:String, message:String)
    {
       
        let alert = UIAlertController(title: title, message:message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:
            { (action) in
                self.okans = 1
                GameName.shared.okans = self.okans
                self.ansCollection.reloadData()
                alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
   
}

extension String
{
    func appendLineToURL(fileURL: URL) throws
    {
        try (self + "\n").appendToURL(fileURL: fileURL)
    }
    
    func appendToURL(fileURL: URL) throws
    {
        let data = self.data(using: String.Encoding.utf8)!
        try data.append(fileURL: fileURL)
    }
}

extension Data
{
    func append(fileURL: URL) throws
    {
        if let fileHandle = FileHandle(forWritingAtPath: fileURL.path)
        {
            defer
            {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(self)
        }
        else
        {
            try write(to: fileURL, options: .atomic)
        }
    }
}
