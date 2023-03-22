//
//  GameYandNViewController.swift
//  ccmusagame
//
//  Created by Carl Hsieh on 12/25/22.
//  Copyright © 2022 Carl Hsieh. All rights reserved.
//

import UIKit

class GameYandNViewController: UIViewController {

       var timer = Timer()
        let backgroundImageView = UIImageView()
        var timero = Timer()
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
        var colViewQ: UICollectionView!
        var colViewA: UICollectionView!
        var imageViewImage: UIImage?
        var AImage: UIImage = UIImage(named: "sudoku")!
        var QImage: UIImage = UIImage(named: "sudoku")!
    //    var CImage: UIImage = UIImage(named: "cross")!
      
        var crossView: UIImageView!
  
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
  
        var  ansString: Array<String> = []
        var  level2Str: Array<String> = []
        var  qnsString: Array<String> = [" "]
        
        /// Progress bar constraint
        var  progressConstraint: NSLayoutConstraint!
        /// Current question countdown timer
        var  timerx: Timer?
        
        /// Curent game state
        var state = State(questions: questions)
        
      
       // var myButton: UIButton!
        lazy var viewProgress: UIView = {
          let v = UIView(frame: .zero)
          v.backgroundColor = .clear
          view.addSubview(v)
          return v
        }()
        
        lazy var txtProgress: UILabel = {
            let lbl = UILabel(frame: .zero)
            lbl.textAlignment = .center
            lbl.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
            lbl.backgroundColor = UIColor.clear
            lbl.numberOfLines = 0
            lbl.textColor = .white
            view.addSubview(lbl)
          return lbl
        }()
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
        lazy var  lblFiler1: UILabel =       // Title
        {
            let lbl = UILabel(frame: .zero)
            lbl.numberOfLines = 0
           
            lbl.textAlignment = .center
            lbl.textColor = .red
            lbl.font = UIFont.systemFont(ofSize: 48, weight: .semibold)
            lbl.alpha = 0
       
            return lbl
            
        }()
        lazy var  lblFiler2: UILabel =       // Title
        {
            let lbl = UILabel(frame: .zero)
            lbl.numberOfLines = 0
           
            lbl.textAlignment = .center
            lbl.textColor = .red
            lbl.font = UIFont.systemFont(ofSize: 48, weight: .semibold)
            lbl.alpha = 0
       
            return lbl
            
        }()
        lazy var lblTimer: UILabel = {
          let lbl = UILabel(frame: .zero)
          lbl.layer.cornerRadius = 8
          lbl.layer.borderColor = UIColor.white.cgColor
          lbl.layer.borderWidth = 2
          lbl.textAlignment = .center
          lbl.font = UIFont.systemFont(ofSize: 20, weight: .light)
            lbl.backgroundColor = UIColor.clear
          lbl.text = "00:30"
            lbl.textColor = .white
          view.addSubview(lbl)
          
          return lbl
        }()
        
        
        lazy var lblQuestion: UILabel = {
            let lbl = UILabel(frame: .zero)
            lbl.textAlignment = .left
            lbl.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            lbl.backgroundColor = UIColor.clear
            lbl.numberOfLines = 0
            lbl.textColor = UIColor.black
            view.addSubview(lbl)
            
            return lbl
        }()
        
        lazy var lblMessage: UILabel = {
          let lbl = UILabel(frame: .zero)
          lbl.numberOfLines = 0
          lbl.backgroundColor = UIColor.clear
          lbl.textAlignment = .left
          lbl.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
          lbl.alpha = 0
          // self.navigationController?.view.addSubview(lbl)
        
           view.addSubview(lbl)
          return lbl
        }()
        lazy var lblverse: UILabel = {
          let lbl = UILabel(frame: .zero)
          lbl.numberOfLines = 0
         // lbl.text = "Verse "
          lbl.backgroundColor = UIColor.clear
          lbl.textAlignment = .left
          lbl.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
          lbl.alpha = 0
          // self.navigationController?.view.addSubview(lbl)
        
           view.addSubview(lbl)
          return lbl
        }()
        lazy var lblverseNo: UILabel = {
          let lbl = UILabel(frame: .zero)
          lbl.numberOfLines = 0
         //   lbl.text = "Verse No"
          lbl.backgroundColor = UIColor.clear
          lbl.textAlignment = .left
          lbl.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
          lbl.alpha = 0
          // self.navigationController?.view.addSubview(lbl)
        
           view.addSubview(lbl)
          return lbl
        }()
        
   
        lazy var btnTrue: UIButton =
       {
           let btn = UIButton(type: .custom)
          btn.layer.cornerRadius = 12
          btn.backgroundColor = .green
          btn.setTitle("👍True", for: .normal)
          btn.setTitleColor(.black, for: .normal)
          btn.titleLabel?.font = .systemFont(ofSize: 25, weight: .semibold)
     //     btn.showsTouchWhenHighlighted = true
         btn.addTarget(self, action: #selector(handleAnswer(_:)), for: .touchUpInside)
       
            view.addSubview(btn)
          return btn
        }()
        
        lazy var btnFalse: UIButton = {
           
          let btn = UIButton(type: .custom)
          btn.layer.cornerRadius = 12
          btn.backgroundColor = .red
          btn.setTitle("👎False", for: .normal)
          btn.setTitleColor(.black, for: .normal)
          btn.titleLabel?.font = .systemFont(ofSize: 25, weight: .semibold)
       //   btn.showsTouchWhenHighlighted = true
          btn.addTarget(self, action: #selector(handleAnswer(_:)), for: .touchUpInside)
          view.addSubview(btn)
          return btn
        }()
      
        
        lazy var svButtons2: UIStackView = {
          
          let stackView = UIStackView(arrangedSubviews: [btnFalse, btnTrue])
          stackView.alignment = .center
          stackView.spacing = 16
          stackView.axis = .horizontal
          stackView.distribution = .fillEqually
          
          view.addSubview(stackView)
          
          return stackView
        }()
        
        
        let TimeLabel: UILabel =       // Title
        {
            let lbl = UILabel()
            
            lbl.font = UIFont.boldSystemFont(ofSize: 18)
            lbl.translatesAutoresizingMaskIntoConstraints = false
            lbl.textColor = .brown
            lbl.layer.cornerRadius = 8
            lbl.layer.borderColor = UIColor.red.cgColor
            lbl.layer.borderWidth = 2
            lbl.textAlignment = .center
            lbl.font = UIFont.systemFont(ofSize: 20, weight: .light)
              lbl.backgroundColor = UIColor.white
            return lbl
            
        }()
        let qnsCollection: UICollectionView =
        {
            let BibleQview = UICollectionViewFlowLayout()
            let layout = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: BibleQview)
            layout.backgroundColor = UIColor.clear
            //font = UIFont.boldSystemFont(ofSize: 18)
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
        
        
        let imageView: UIImageView = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.contentMode = .scaleAspectFill
            image.clipsToBounds = true
            return image
        }()

        
        override  func viewDidLoad()
        {
            super.viewDidLoad()
            navigationItem.largeTitleDisplayMode = .always
            navigationController?.navigationBar.prefersLargeTitles = true
            
            view.addSubview(backgroundImageView)
            backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
            backgroundImageView.backgroundColor = .white
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
      //      backgroundImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
       //     backgroundImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
            
            backgroundImageView.image = UIImage(named: "Yandnbg")
           
            self.ansCollection.register(UINib(nibName: "YandNCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
            ansCollection.register(YandNCell.self, forCellWithReuseIdentifier: "YandNCell")
            ansCollection.delegate = self as UICollectionViewDelegate
            ansCollection.dataSource = self as UICollectionViewDataSource
            view.addSubview(ansCollection)
            
            
            setupCollectionLevelyandn()
            if GameName.shared.YandNlevel == 1   // 容易
            {
                fname = GameName.shared.yename + String(GameName.shared.num )
                print("carl file number  =\(GameName.shared.num)")
            }
            else
            {
                if GameName.shared.YandNlevel == 2    // 較難
                {
                    fname = GameName.shared.mname + String(GameName.shared.mnum )
                    print("carl fname 2 xx = \(fname)")
                    
                }
                else
                {
                    if GameName.shared.YandNlevel == 3   // 更難
                    {
                        fname = GameName.shared.yhname + String(GameName.shared.hnum )
                    }
                }
            }
           
        //    let fname = GameName.shared.ymname + String(GameName.shared.num )
            print("carl fname json file xx =\(fname)")
            guard let path = Bundle.main.path(forResource: fname, ofType: "json") else { return }
            let url = URL(fileURLWithPath: path)
          //  print("carl path =\(path)")
            var loopcnt = 0
            do
            {
                let data = try Data(contentsOf: url)
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
           
                let decoder = JSONDecoder()
                GameName.shared.bibles = try decoder.decode([Bible].self, from: data)
               
                let components = GameName.shared.bibles[loopcnt].Select.components(separatedBy: " ")
                ansString = components
         //       print("carl loopcnt  = \(loopcnt)")
                lblQuestion.text = GameName.shared.bibles[0].Title
                txtProgress.text =  "問答題共計: \(GameName.shared.currentQuestion+1)/\(GameName.shared.numberOfQuestions)"
                //
                // ??????
                //
                loopcnt += 1
                GameName.shared.over = 1
          
                startGame()
                
            }
            catch
            {
                print("carl Contents could not be loaded. \(error)")
            }
           
          
        }  // viewDidLoad
        
       
      
        func setupCollectionLevelyandn()
        {
           
            //
            // Title Here
            //
            view.addSubview(lblText)
          
            lblText.translatesAutoresizingMaskIntoConstraints = false
            lblText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 5).isActive = true
            lblText.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor,constant: 10).isActive = true
            lblText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            lblText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
           
            lblText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
     
       //     view.addSubview(viewProgress)
            viewProgress.translatesAutoresizingMaskIntoConstraints = false
            viewProgress.topAnchor.constraint(equalTo: lblText.topAnchor, constant: 5).isActive = true
            viewProgress.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            viewProgress.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
            viewProgress.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
            viewProgress.heightAnchor.constraint(equalToConstant: 30).isActive = true
           
            NSLayoutConstraint.activate([
             
              viewProgress.topAnchor.constraint(equalTo: lblText.topAnchor),
              viewProgress.heightAnchor.constraint(equalToConstant: 32),
              viewProgress.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            ])
         //   updateProgress(to: 0)
            
            txtProgress.translatesAutoresizingMaskIntoConstraints = false
            
            txtProgress.topAnchor.constraint(equalTo: viewProgress.bottomAnchor,constant: 5).isActive = true
            txtProgress.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            txtProgress.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
            txtProgress.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
            txtProgress.heightAnchor.constraint(equalToConstant: 60).isActive = true
            txtProgress.translatesAutoresizingMaskIntoConstraints = false
          
            
            //
            // Timer Here
            //
            lblTimer.translatesAutoresizingMaskIntoConstraints = false
            lblTimer.topAnchor.constraint(equalTo:  txtProgress.bottomAnchor, constant: 5).isActive = true
            lblTimer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45).isActive = true
            lblTimer.heightAnchor.constraint(equalToConstant: 30).isActive = true
            lblTimer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
           
            view.addSubview(imageView)
            
            imageView.topAnchor.constraint(equalTo: lblTimer.bottomAnchor, constant: 10).isActive = true
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 208).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 400).isActive = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: "Chooseq")
            imageView.backgroundColor = .clear
          
            //
            // Question Here
            //
            
            lblQuestion.translatesAutoresizingMaskIntoConstraints = false
            lblQuestion.topAnchor.constraint(equalTo: lblTimer.bottomAnchor, constant: 60).isActive = true
         //   lblQuestion.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            lblQuestion.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
            lblQuestion.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
            lblQuestion.heightAnchor.constraint(equalToConstant: 100).isActive = true
            lblQuestion.translatesAutoresizingMaskIntoConstraints = false
            lblQuestion.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 120).isActive = true
           // lblQuestion.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 38).isActive = true
           
            
            view.addSubview(txtProgress)
            //
            // Button Here
            //
            
            svButtons2.translatesAutoresizingMaskIntoConstraints = false
            svButtons2.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40).isActive = true
        
            svButtons2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            svButtons2.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 16).isActive = true
            svButtons2.trailingAnchor.constraint(equalTo: lblQuestion.trailingAnchor, constant: -16).isActive = true
            svButtons2.heightAnchor.constraint(equalToConstant: 40).isActive = true
            svButtons2.translatesAutoresizingMaskIntoConstraints = false
            lblMessage.translatesAutoresizingMaskIntoConstraints = false
            
            lblMessage.topAnchor.constraint(equalTo: svButtons2.bottomAnchor, constant: 10).isActive = true
          //  lblMessage.bottomAnchor.constraint(equalTo: lblQuestion.bottomAnchor, constant: 20).isActive = true
            lblMessage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 16).isActive =  true
           // lblMessage.heightAnchor.constraint(equalToConstant: 300).isActive = true
            lblMessage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive =  true
            
            lblverse.translatesAutoresizingMaskIntoConstraints = false
            lblverse.topAnchor.constraint(equalTo: lblMessage.bottomAnchor, constant: 20).isActive = true
          //  lblMessage.bottomAnchor.constraint(equalTo: lblQuestion.bottomAnchor, constant: 20).isActive = true
            lblverse.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 16).isActive =  true
          //  lblverse.heightAnchor.constraint(equalToConstant: 80).isActive = true
            lblverse.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive =  true
            
            lblverseNo.translatesAutoresizingMaskIntoConstraints = false
            lblverseNo.topAnchor.constraint(equalTo: lblverse.bottomAnchor, constant: 20).isActive = true
          //  lblMessage.bottomAnchor.constraint(equalTo: lblQuestion.bottomAnchor, constant: 20).isActive = true
            lblverseNo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 16).isActive =  true
          //  lblverseNo.heightAnchor.constraint(equalToConstant: 80).isActive = true
            lblverseNo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive =  true
           
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
       //
       //  start Timer here
       //
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
            if GameName.shared.level == 3
            {
                TimeLabel.text = watchString
            }
            
            
        }
        func startGame()
        {
            
            print("carl startGame")
            if GameName.shared.over == 0
            {
                let fname: String?
                
                if GameName.shared.YandNlevel == 1
                {
                   fname = GameName.shared.yename + String(GameName.shared.num )
                }
                else
                {
                    if GameName.shared.YandNlevel == 2
                    {
                        
                        fname = GameName.shared.mname + String(GameName.shared.mnum )
                    }
                    else
                    {
                        fname = GameName.shared.yhname + String(GameName.shared.mnum )
                       
                    }
                }
           //    print("carl fname 576 =\(fname)")
                guard let path = Bundle.main.path(forResource: fname, ofType: "json") else { return }
                let url = URL(fileURLWithPath: path)
         
                do
                {
                    let data = try Data(contentsOf: url)
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    
                    let decoder = JSONDecoder()
                    GameName.shared.bibles = try decoder.decode([Bible].self, from: data)
                    if GameName.shared.level == 1
                    {
                        let components = GameName.shared.bibles[0].Select.components(separatedBy: " ")
                        ansString = components
                        //  print("carl ansSting = \(ansString[0])")
                        
                    }
                    
                }
                catch
                {
                   // print("carl Contents could not be loaded. \(fname)")
                    print(error)
                }
            }
            GameName.shared.numberOfQuestions = 10 //GameName.shared.bibles.count
            state = State(questions:questions)
            /*
            if GameName.shared.bibles[GameName.shared.currentQuestion].isTrue == false
            {
               print("carl cfh 952 0 true")
                GameName.shared.isTrue = true
            }
            else
            {
              print("carl cfh 957  0 false")
                GameName.shared.isTrue = false
            }  */
            GameName.shared.isTrue = GameName.shared.bibles[GameName.shared.currentQuestion].isTrue
            GameName.shared.over = 1
            goToQuestionYandN(at: 0)
         
        }
        func GameOverAlert(title:String, message:String)
        {
        
            let  actionSheet:UIAlertController
            let image:UIImage?
        
            actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
            let margin:CGFloat = 10.0
            let rect = CGRect(x: margin, y: margin, width: actionSheet.view.bounds.size.width - margin * 4.0, height: 120)
            let customView = UIView(frame: rect)
            actionSheet.view.addSubview(customView)
            if GameName.shared.ok == 10
            {
                image = UIImage(named: "awesome")
                GameName.shared.myArrayYandN[GameName.shared.saveArrayidx+1 ] = "1"
                GameName.shared.myArrayInfYandN[GameName.shared.saveArrayidx ] = "1"
            }
            else
            {
              
                if GameName.shared.error > 3
                {
                    image = UIImage(named: "Bad")
                    GameName.shared.myArrayInfYandN[GameName.shared.saveArrayidx] = "3"
                }
                else
                {
                    image = UIImage(named: "Bad")
                    GameName.shared.myArrayYandN[GameName.shared.saveArrayidx+1 ] = "1"
                    GameName.shared.myArrayInfYandN[GameName.shared.saveArrayidx] = "2"
                }
            }
        
        
        // Change font and color of title
        actionSheet.setTitlet(font: UIFont.boldSystemFont(ofSize: 26), color: UIColor.blue)
        
        // Change font and color of message
        actionSheet.setMessage(font: UIFont(name: "AvenirNextCondensed-HeavyItalic", size: 20), color: UIColor.blue)
        
        // Change background color of UIAlertController
   //     actionSheet.setBackgroundColor(color: UIColor.white)
        let action = UIAlertAction(title: title, style: .default, handler: nil)
        
        if let icon = image?.imageWithSize(scaledToSize: CGSize(width: 300, height: 300))
        {
            action.setValue(icon.withRenderingMode(.alwaysOriginal), forKey: "image")
            
        }
        actionSheet.addAction(action)
        actionSheet.addAction(UIAlertAction(title: "知道了", style: UIAlertAction.Style.default, handler:
                                                { (action) in
            self.navigationController?.popViewController(animated: true)
            actionSheet.dismiss(animated: true, completion: nil)}))
        self.present(actionSheet, animated: true, completion: nil)
    }
      
        func startCountdown() {
          lblTimer.text = "00:30"
          
          timerx?.invalidate()
          timerx = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
              [weak self] timer in
            guard let self = self else { return }
            
            let currentSeconds = Int((self.lblTimer.text ?? "0").replacingOccurrences(of: ":", with: "")) ?? 1
         //   print("carl  1186 startCountdown \(currentSeconds)")
            guard currentSeconds > 1 else
            {
               timer.invalidate()
               
               self.TimeoutshowMessage()
               self.goToNextQuestionYandN()
          
               return
            }
            self.lblTimer.text = "00:0\(currentSeconds - 1)"
          
              
          }
        }
    func GameOverSaveData()
    {
       
            var sname = ""
            let name = "ye"
            
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
            
     
        
        //
        // reset here
        //
        
        GameName.shared.btnenable = false
        GameName.shared.error = 0
        GameName.shared.ok = 0
      
    
    }
    
      
        func updateProgress(to progress: Double)
        {
            
            if let constraint = progressConstraint
            {
                print("Carl progress false = \(progress)")
                constraint.isActive = false
            }
            progressConstraint = viewProgress.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: CGFloat(progress))
            progressConstraint.isActive = true
            print("Carl progress true = \(progress)")
        }
        
        func showMessage(isCorrect: Bool)
        {
            print("Carl showMessage isCorrect = \(isCorrect)")
            if isCorrect == true
            {
                if  GameName.shared.bibles[GameName.shared.currentQuestion].isTrue == true
                {
                 //   print("cfh o cnt = \(GameName.shared.currentQuestion) isTrue = \(GameName.shared.bibles[GameName.shared.currentQuestion].isTrue)")
                    GameName.shared.ok += 1
               
                }
                else
                {
                 //   print("cfh f cnt = \(GameName.shared.currentQuestion) isTrue = \(GameName.shared.bibles[GameName.shared.currentQuestion].isTrue)")
                    GameName.shared.error += 1
                  //  print("cfh 1105 err = \( GameName.shared.error)")
                }
               
            }
            else
            {
                if isCorrect == false
                {
                    if  GameName.shared.bibles[GameName.shared.currentQuestion].isTrue == false
                    {
                        GameName.shared.ok += 1
                      //  print("cfh 1116 ok = \( GameName.shared.ok)")
                    }
                    else
                    {
                        GameName.shared.error += 1
                     //   print("cfh 1121 err = \( GameName.shared.error)")
                    }
                }
               
               
            }
            let Correct  = Bool(truncating: isCorrect as NSNumber)
         //   let ret = Bool(truncating: GameName.shared.bibles[GameName.shared.currentQuestion].isTrue as NSNumber)
          //  if isCorrect == ret
         //  {
          //      print("CFH ret = \( GameName.shared.bibles[GameName.shared.currentQuestion].isTrue) isCorrect = \(isCorrect)")
          //  }
            var selvalue = true
            print("carl CFH Correct  =  \(Correct) isTure = \(GameName.shared.bibles[GameName.shared.currentQuestion].isTrue)")
            if Correct == GameName.shared.bibles[GameName.shared.currentQuestion].isTrue
            {
                selvalue = true
            }
            else
            {
                selvalue = false
            }
            lblMessage.text = selvalue ? "正確答案! " : "你答错了!"
            lblMessage.textColor = isCorrect ? .black : .red
            lblMessage.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            lblMessage.alpha = 0
            lblverse.text = GameName.shared.bibles[GameName.shared.currentQuestion].Verse
            lblverse.textColor =  .black
            lblverse.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            lblverse.alpha = 0
            lblverseNo.text = GameName.shared.bibles[GameName.shared.currentQuestion].VerseNo
            lblverseNo.textColor = .black
           // lblverseNo.font = UIFont(coder: 20)
            lblverseNo.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            lblverseNo.alpha = 0
            print("carl selvale \(selvalue)")
            DisplayAnsMessage(at:selvalue)
            timerx?.invalidate()
            let btn = UIButton(type: .custom)
            btn.layer.cornerRadius = 12
            btn.backgroundColor = .green
            //
            //   MARK Add
            //
       
          
        }
        func TimeoutshowMessage()
        {
            lblMessage.text =  "正確答案!"
            lblMessage.textColor =  .red
        //    lblMessage.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        //    lblMessage.alpha = 0
            print("carl currentquestion 924  = \(GameName.shared.currentQuestion)")
            lblverse.text = GameName.shared.bibles[GameName.shared.currentQuestion].Verse
            lblverse.textColor =  .black
        //    lblverse.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        //    lblverse.alpha = 0
            lblverseNo.text = GameName.shared.bibles[GameName.shared.currentQuestion].VerseNo
            lblverseNo.textColor = .black
         //   lblverseNo.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
         //   lblverseNo.alpha = 0
            print("carl 980 true")
            DisplayAnsMessage(at:true)
            timerx?.invalidate()
            /*
            if GameName.shared.GameKind == 0
            {
                UIView.animate(withDuration: 0.7,
                               delay: 0.0,
                               usingSpringWithDamping: 0.4,
                               initialSpringVelocity: 0.8,
                               options: .curveEaseIn,
                               animations: {
                    self.lblMessage.alpha = 1
                    self.lblMessage.transform = .identity
                    self.lblverse.alpha = 1
                    self.lblverse.transform = .identity
                    self.lblverseNo.alpha = 1
                    self.lblverseNo.transform = .identity
                },
                               completion: { _ in
                    UIView.animate(withDuration: 9,
                                   delay: 0.35,
                                   animations: {
                        self.lblMessage.alpha = 0
                        self.lblverseNo.alpha = 0
                        self.lblverse.alpha = 0
                    },
                                   completion: { _ in
                        self.goToNextQuestionYandN()
                    })
                })
            }
            else
            {
                //
                //
                // MARK Add
                UIView.animate(withDuration: 0.7,
                               delay: 0.0,
                               usingSpringWithDamping: 0.4,
                               initialSpringVelocity: 0.8,
                               options: .curveEaseIn,
                               animations: {
                    self.lblMessage.alpha = 1
                    self.lblMessage.transform = .identity
                    self.lblverse.alpha = 1
                    self.lblverse.transform = .identity
                    self.lblverseNo.alpha = 1
                    self.lblverseNo.transform = .identity
                },
                               completion: { _ in
                    UIView.animate(withDuration: 9,
                                   delay: 0.35,
                                   animations: {
                        self.lblMessage.alpha = 0
                        self.lblverseNo.alpha = 0
                        self.lblverse.alpha = 0
                    },
                                   completion: { _ in
                        self.goToNextQuestionYandN()
                    })
                })  */
        //   }
          
        }
    func DisplayAnsMessage(at flag :Bool)
    {
        var message = String()
        let helloString = "\n\n"
        print("Carl isTrue \(flag)")
         message  = "\(lblMessage.text!)\(helloString)  \(lblverse.text!)\(helloString)\(lblverseNo.text!)"
   
    
        let alert = UIAlertController(title: "看結果",
                                      message: message,
                                      preferredStyle: .actionSheet)
  
       alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
  
        alert.setValue(NSAttributedString(string: alert.message!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20,weight: UIFont.Weight.medium),NSAttributedString.Key.foregroundColor :UIColor.black]), forKey: "attributedMessage")
 
        alert.addAction(UIAlertAction(title: "知道了",
                                      style: .cancel,
                                      handler: { _ in print("Cancel tap")
                                    self.goToNextQuestionYandN()
        }))

        // 3. Show
       
        present(alert, animated: true, completion: nil)
        
       
                                          
    }
  
        
        func goToNextQuestionYandN()
        {
            guard !GameName.shared.isLastQuestion
            else
            {
               // This is the last question
               // GameName.shared.isLastQuestion = false
                let text: String
                
                if GameName.shared.ok  == 10
                {
                    text = String("恭喜您全部答對!")
                }
                else
                {
                    text = String("錯誤")  + String(GameName.shared.error) + "次"
                }
               
                GameOverAlert(title: "遊戲結束", message:text)
                GameOverSaveData()
                GameName.shared.btnenable = false
                GameName.shared.currentQuestion = 0
                GameName.shared.isLastQuestion = false
                GameName.shared.error = 0
                GameName.shared.ok = 0
                return
              
            }
            let pos =  GameName.shared.currentQuestion + 1
            print("Carl position = \(pos)")
            goToQuestionYandN(at: pos)
         // goToQuestion(at: state.currentQuestion + 1)
        }
        func goToQuestionYandN(at position: Int)
        {
           print("Carl goToQuestion position = \( position)")
          
            GameName.shared.currentQuestion = position
        //    print("carl total num = \(GameName.shared.numberOfQuestions) ")
            if position == GameName.shared.numberOfQuestions
            {
              //  print("carl isLastQuestion = \(GameName.shared.isLastQuestion)")
                GameName.shared.isLastQuestion =  true
                goToNextQuestionYandN()
            }
            else
            {
               
                lblQuestion.text = GameName.shared.bibles[position].Title
                txtProgress.text =  "是非題共計: \(GameName.shared.currentQuestion+1)/\(GameName.shared.numberOfQuestions)"
                let progress = Double(position) / Double(10)
            //    print("Carl goToQuestion() progress = \(progress) \(position) ")
                updateProgress(to: progress)
          
                if !GameName.shared.isLastQuestion
                {
                    startCountdown()
                }
            }
        }
  
        
    }
    extension GameYandNViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
    {
        
     
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
        {
          //  print("carl currentQuestion 1097 \(GameName.shared.currentQuestion)")
            if collectionView == ansCollection
            {
             //   print("carl count xxx = \(ansString.count)")
                GameName.shared.anscount = 1
                return ansString.count
            }
            else
            {
                return images.count
            }
            
        }
            
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
        {
            //
            // remove all code  here
            //
      
                
                let cell = ansCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ChooseCell
                
                cell.lblData.text = ansString[indexPath.row]
                cell.lblData.layer.cornerRadius = 8
                cell.lblData.layer.borderColor = UIColor.black.cgColor
                cell.lblData.layer.borderWidth = 2
                //  ansCollection.reloadData()
                
                //    print("carl data = \(cell.lblData.text)")
                
                return(cell)
                
         }
           
   
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            if GameName.shared.YandNlevel == 1
            {
                let astring = ansString[indexPath.row]
                
                let width  =  Int(astring.widthWithConstrainedHeight(height:  30, font: UIFont.systemFont(ofSize: 17)))
                return CGSize(width: width, height: 30)
            }
            else
            {
                return CGSize(width: (view.frame.width - 10) / 10, height: (view.frame.width - 10) / 10)
            }
               
        }
            
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
        {
            return UIEdgeInsets(top: 0.5, left: 0.5, bottom: 0.5, right: 0.5)
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
        {
               
        }
    
    } // end the of extension

    extension UIViewController
    {
        
        func showToast(message : String, type : String)
        {
             if type == "0"
             {
                let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))  // 150  - 75
                toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                toastLabel.textColor = UIColor.white
                toastLabel.textAlignment = .center;
                toastLabel.font = UIFont(name: "Montserrat-Light", size: 20.0)
                toastLabel.text = message
                toastLabel.alpha = 1.0
                toastLabel.layer.cornerRadius = 10;
                toastLabel.clipsToBounds  =  true
                self.view.addSubview(toastLabel)
                UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations:
                    {
                        toastLabel.alpha = 0.0
                }, completion: {(isCompleted) in
                    toastLabel.removeFromSuperview()
                })
             }
             else
             {
              
                let toastLabel = UILabel(frame: CGRect(x:self.view.frame.size.width/2 - 120 , y: view.frame.height / 2, width: 250, height: 35))
                toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                toastLabel.textColor = UIColor.white
                toastLabel.textAlignment = .center;
                toastLabel.font = UIFont(name: "Montserrat-Light", size: 30.0)
                toastLabel.text = message
                toastLabel.alpha = 1.0
                toastLabel.layer.cornerRadius = 10;
                toastLabel.clipsToBounds  =  true
                self.view.addSubview(toastLabel)
                UIView.animate(withDuration: 6.0, delay: 0.1, options: .curveEaseOut, animations:
                    {
                        toastLabel.alpha = 0.0
                }, completion: {(isCompleted) in
                    toastLabel.removeFromSuperview()
                })
             }
        }
      
        
    }



    extension GameYandNViewController
    {
        
        @objc func handleAnswer(_ sender: UIButton) {
            
            let userSelection = sender == btnTrue
            print("carl isTrue \(GameName.shared.isTrue) user \(userSelection)")
           // let isCorrect = GameName.shared.isTrue == userSelection
            if GameName.shared.isTrue == userSelection
            {
                let  isCorrect =  GameName.shared.isTrue
                showMessage(isCorrect: isCorrect)
            }
            else
            {
                let  isCorrect =  userSelection
                showMessage(isCorrect: isCorrect)
            }
            /*
            /*
            if GameName.shared.isTrue == true
            {
                GameName.shared.isOk = true
            }
            else
            {
                GameName.shared.isOk = false
            }
         //   var isCorrect = GameName.shared.isTrue == userSelection
            var isCorrect = GameName.shared.isOk == userSelection  */
           //  var isCorrect = state.question.isTrue == userSelection
            print("carl xx is  \(GameName.shared.bibles[GameName.shared.currentQuestion].isTrue) isCorrect \(isCorrect)")
          
            if isCorrect {
                state.correctAnswers += 1
                GameName.shared.correctAnswers += 1
            }
         
          //  var ans = true
          var  ans = (GameName.shared.bibles[GameName.shared.currentQuestion].isTrue)  // != true
            if ans == isCorrect
            {
                isCorrect = false
            }
            else
            {
                if GameName.shared.bibles[GameName.shared.currentQuestion].isTrue == true
                {
                    isCorrect = true
                }
                else
                {
                    isCorrect = false
                }
                
            }  */
       //    print("Carl isCorrect \(isCorrect)")
       //     showMessage(isCorrect: isCorrect)
        }
    }

       
