//
//  GameChooseViewController.swift
//  ccmusagame
//
//  Created by Carl Hsieh on 12/25/22.
//  Copyright © 2022 Carl Hsieh. All rights reserved.
//

import UIKit

class GameChooseViewController: UIViewController {

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
    var itm0 = "CellId"
    var itm1 = "CellId"
    var itm2 = "easy"
    var itm3 = "easy"
    var itm4 = " "
    var itm5 = ""
    var itm6 = ""
    var itm7 = ""
    var itm8 = ""
    var itm9 = ""
    var watchString = ""
    var colViewQ: UICollectionView!
    var colViewA: UICollectionView!
    var imageViewImage: UIImage?
//    var AImage: UIImage = UIImage(named: "sudoku")!
//    var QImage: UIImage = UIImage(named: "sudoku")!

  
    var crossView: UIImageView!
    var answer:String?
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
    
  //  var xx: Character = ""
    var selbtn = 0;
    let filer: Character = " "
    var  fname = ""
    var  seldata  = ""
    var  item: Array<Character> = Array()
    var  item1: Array<Character> = Array()
    var  item2: Array<Character> = Array()
    var  item3: Array<Character> = Array()
    var  item4: Array<Character> = Array()
    
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
        lbl.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        lbl.textAlignment = .center
        lbl.textColor = .white
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
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        lbl.backgroundColor = UIColor.clear
        lbl.numberOfLines = 0
    
        view.addSubview(lbl)
        
        return lbl
    }()
    
    lazy var lblMessage: UILabel = {
      let lbl = UILabel(frame: .zero)
      lbl.numberOfLines = 0
      lbl.backgroundColor = UIColor.clear
      lbl.textAlignment = .left
      lbl.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
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
      lbl.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
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
      lbl.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
      lbl.alpha = 0
      // self.navigationController?.view.addSubview(lbl)
    
       view.addSubview(lbl)
      return lbl
    }()
    
    
    lazy var lblansQuestion: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        lbl.backgroundColor = UIColor.clear
        lbl.numberOfLines = 0
        lbl.text = "請選擇下面正確答案"
      //  lbl.layer.cornerRadius = 8
        lbl.layer.borderColor = UIColor.black.cgColor
       // lbl.layer.borderWidth = 2
        
        view.addSubview(lbl)
        
        return lbl
    }()
   
    lazy var allbtn: UIButton =
    {
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 12
        btn.backgroundColor = .red
        btn.setTitle("👎False", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 22, weight: .semibold)
      
        return btn
    }()
    
    
    let TimeLabel: UILabel =       // Title
    {
        let lbl = UILabel()
        
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
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
        collection.layer.cornerRadius = 12
    
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
        backgroundImageView.image = UIImage(named: "Yandnbg")
        self.ansCollection.register(UINib(nibName: "ChooseCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        ansCollection.register(CustomeCell.self, forCellWithReuseIdentifier: "ChooseCell")
        ansCollection.delegate = self as UICollectionViewDelegate
        ansCollection.dataSource = self as UICollectionViewDataSource
        view.addSubview(ansCollection)
        
        view.addSubview(lblTimer)
        view.addSubview(lblText)
        ansCollection.delegate = self as UICollectionViewDelegate
        ansCollection.dataSource = self as UICollectionViewDataSource
        self.ansCollection.register(UINib(nibName: "ChooseCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        view.addSubview(ansCollection)
        
       
        setupCollectionLevelChoose()
       
        
        if GameName.shared.ChooseLevel == 1   // 容易
        {
            // print(" no = \(GameName.shared.num)")
            fname = GameName.shared.cename + String(GameName.shared.num )
          //  print("carl fname 1 xx = \(fname)")
            
        }
        else
        {
            if GameName.shared.ChooseLevel == 2    // 較難
            {
                fname = GameName.shared.mname + String(GameName.shared.mnum )
            //    print("carl fname 2 xx = \(fname)")
                
            }
            else
            {
                
                if GameName.shared.ChooseLevel == 3   // 更難
                {
                    fname = GameName.shared.hname + String(GameName.shared.hnum )
                }
            }
        }
       
      
      //  let fname = GameName.shared.cename + String(GameName.shared.num )
        print("carl fname json file =  \(fname)")
        guard let path = Bundle.main.path(forResource: fname, ofType: "json") else {
            print("carl \(fname) not found ")
            return }
        let url = URL(fileURLWithPath: path)
       print("carl path =\(path)")
        do
        {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            //  print("carl json = \(json)")
            let decoder = JSONDecoder()
            GameName.shared.bibles = try decoder.decode([Bible].self, from: data)
     //       if GameName.shared.ChooseLevel == 1
     //       {
                let components = GameName.shared.bibles[0].Select.components(separatedBy: " ")
                ansString = components
        print("carl read json  file ansSting  = \(ansString[0]) = \(ansString[1]) = \(ansString[2])")
            answer = GameName.shared.bibles[0].Answer
          //  print("carl  answer = \(String(describing: answer))")
            seldata =  answer ?? ""
       //     print("carl  read json file answer = \( seldata)")
            
     //       }
            lblQuestion.text = GameName.shared.bibles[0].Title
            txtProgress.text =  "問答題共計: \(GameName.shared.currentQuestion+1)/\(GameName.shared.numberOfQuestions+1)"
            //
            // ??????
            //
            GameName.shared.over = 1
            startGame()
        }
        catch
        {
            print("carl do fatal error =  \(error)")
        }
        
        
    }  // viewDidLoad
    
 
   
    func setupCollectionLevelChoose()
    {
        //
        // Display Title Text Here
        //
      
       // navigationItem.title = "Carl Hieh"
        lblText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30.0).isActive = true
        lblText.heightAnchor.constraint(equalToConstant: 25).isActive = true
        lblText.widthAnchor.constraint(equalToConstant: 200).isActive = true
        lblText.translatesAutoresizingMaskIntoConstraints = false
        lblText.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
     
    //    view.addSubview(viewProgress)
        viewProgress.translatesAutoresizingMaskIntoConstraints = false
      //  viewProgress.topAnchor.constraint(equalTo: lblText.topAnchor,constant: 20 ).isActive = true
        viewProgress.topAnchor.constraint(equalTo: lblText.bottomAnchor, constant: 10).isActive = true
        viewProgress.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        viewProgress.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        viewProgress.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        viewProgress.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        NSLayoutConstraint.activate([
          viewProgress.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
          viewProgress.heightAnchor.constraint(equalToConstant: 32),
          viewProgress.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])

        
        view.addSubview( txtProgress)
        txtProgress.translatesAutoresizingMaskIntoConstraints = false
        txtProgress.topAnchor.constraint(equalTo: viewProgress.bottomAnchor,constant: 10).isActive = true
        txtProgress.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        txtProgress.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        txtProgress.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        txtProgress.heightAnchor.constraint(equalToConstant: 60).isActive = true
        txtProgress.translatesAutoresizingMaskIntoConstraints = false
        updateProgress(to: 0)
     
        
        //
        // Timer Here
        //
        lblTimer.translatesAutoresizingMaskIntoConstraints = false
        lblTimer.topAnchor.constraint(equalTo: txtProgress.bottomAnchor, constant: 20).isActive = true
        lblTimer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45).isActive = true
        lblTimer.heightAnchor.constraint(equalToConstant: 45).isActive = true
        lblTimer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       
        
        view.addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: lblTimer.bottomAnchor, constant: 30).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 208).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 400).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Chooseq")
       
        imageView.backgroundColor = .clear
      
       
        //
        // Display answer question here
        //
        
        lblQuestion.translatesAutoresizingMaskIntoConstraints = false
        lblQuestion.topAnchor.constraint(equalTo: lblTimer.bottomAnchor, constant: 70).isActive = true
        lblQuestion.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        lblQuestion.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        lblQuestion.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        lblQuestion.heightAnchor.constraint(equalToConstant: 60).isActive = true
        lblQuestion.translatesAutoresizingMaskIntoConstraints = false
        lblQuestion.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 125).isActive = true
       // lblQuestion.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 38).isActive = true
     
         //
         //
        // lblQuestion.text = bible1
         GameName.shared.width = Int(((view.frame.width - 10) / 12 ))
        /*
        lblansQuestion.translatesAutoresizingMaskIntoConstraints = false
         lblansQuestion.topAnchor.constraint(equalTo: lblQuestion.bottomAnchor, constant: 90).isActive = true
        lblansQuestion.leadingAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        lblansQuestion.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        lblansQuestion.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 36).isActive = true
        lblansQuestion.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        lblansQuestion.heightAnchor.constraint(equalToConstant: 80).isActive = true
      */
        //
        // Display Answer here
        //
        // qnsCollection.heightAnchor.constraint(equalToConstant: 350  ).isActive = true   // 可以27答案
      //  qnsCollection.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        ansCollection.translatesAutoresizingMaskIntoConstraints = false
        ansCollection.topAnchor.constraint(equalTo:  lblQuestion.bottomAnchor,constant: 200).isActive = true
        ansCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        ansCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        ansCollection.heightAnchor.constraint(equalToConstant: 80 ).isActive = true   // 可以27答案
        ansCollection.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        lblMessage.translatesAutoresizingMaskIntoConstraints = false
        lblMessage.topAnchor.constraint(equalTo: ansCollection.bottomAnchor, constant: 10).isActive = true
      
        lblMessage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 16).isActive =  true
      
        lblMessage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive =  true
        
        lblverse.translatesAutoresizingMaskIntoConstraints = false
        lblverse.topAnchor.constraint(equalTo: lblMessage.bottomAnchor, constant: 20).isActive = true
     
        lblverse.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 16).isActive =  true
     
        lblverse.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive =  true
        
        lblverseNo.translatesAutoresizingMaskIntoConstraints = false
        lblverseNo.topAnchor.constraint(equalTo: lblverse.bottomAnchor, constant: 20).isActive = true
      
        lblverseNo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 16).isActive =  true
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
    func startGame() {
        
     //   print("carl startGame")
        if GameName.shared.over == 0
        {
            let fname: String?
            
            if GameName.shared.ChooseLevel == 1
            {
                 fname = GameName.shared.cename + String(GameName.shared.num )
            }
            else
            {
                if GameName.shared.ChooseLevel == 2
                {
                    fname = GameName.shared.cmname + String(GameName.shared.mnum )
                }
                else
                {
                    fname = GameName.shared.chname + String(GameName.shared.hnum )
                }
            }
     //      print("carl fname =\(fname)")
            guard let path = Bundle.main.path(forResource: fname, ofType: "json") else { return }
            let url = URL(fileURLWithPath: path)
     
            do
            {
                let data = try Data(contentsOf: url)
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                
                let decoder = JSONDecoder()
                GameName.shared.bibles = try decoder.decode([Bible].self, from: data)
           //     if GameName.shared.level == 1
            //   {
                    let components = GameName.shared.bibles[0].Select.components(separatedBy: " ")
                    ansString = components
                     print("carl ansSting  = \(ansString[0]) = \(ansString[1]) = \(ansString[2])")
                    
            //    }
                
            }
            catch
            {
              //  print("carl Contents could not be loaded. \(fname)")
                print(error)
            }
        }
        GameName.shared.numberOfQuestions = 10 //GameName.shared.bibles.count
        state = State(questions:questions)
        /*
        if GameName.shared.bibles[0].isTrue == 1
        {
            GameName.shared.isTrue = true
        }
        else
        {
            GameName.shared.isTrue = false
        }  */
       // GameName.shared.isTrue = GameName.shared.bibles[0].isTrue
        GameName.shared.over = 1
      
        goToQuestionChoose(at: 0)
      
    }
    
    func startCountdown() {
      lblTimer.text = "00:10"
      
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
            self.goToNextQuestionChoose()
            return
        }
        self.lblTimer.text = "00:0\(currentSeconds - 1)"
          
      }
    }
   
  
    func updateProgress(to progress: Double) {
      if let constraint = progressConstraint {
        constraint.isActive = false
      }
       // print("Carl progress = \(progress)")
      progressConstraint = viewProgress.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: CGFloat(progress))
      progressConstraint.isActive = true
    }
  
    func TimeoutshowMessage()
    {
        lblMessage.text =  "正確答案!"
        lblMessage.textColor =  .red
    
      //  print("carl currentquestion = \(GameName.shared.currentQuestion)")
        lblverse.text = GameName.shared.bibles[GameName.shared.currentQuestion].Verse
        lblverse.textColor =  .black
 
        lblverseNo.text = GameName.shared.bibles[GameName.shared.currentQuestion].VerseNo
        lblverseNo.textColor = .black
    
        timerx?.invalidate()
        /*
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
                self.goToNextQuestionChoose()
            })
        })  */
        
      
    }
 
    func  showAnsMessage(at isCorrect: Int)
    {
    
        let Correct  = Bool(truncating: isCorrect as NSNumber)
    
        var selvalue = true
   
        if Correct == GameName.shared.bibles[GameName.shared.currentQuestion].isTrue
        {
            selvalue = true
        }
        else
        {
            selvalue = false
        }
        lblMessage.text = selvalue ? "正確答案! " : "你答错了!"
   //     lblMessage.textColor = isCorrect ? .black : .red
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
    
        DisplayAnsMessage(at:selvalue)
        timerx?.invalidate()
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 12
        btn.backgroundColor = .green
  
  
    }
    func DisplayAnsMessage(at flag :Bool)
    {
        var message = String()
        let helloString = "\n\n"

         message  = "\n\(lblMessage.text!)\(helloString)  \(lblverse.text!)\(helloString)\(lblverseNo.text!)"
   
  
        let alert = UIAlertController(title: "看結果",
                                      message: message,
                                      preferredStyle: .actionSheet)
  
       alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
     
        alert.setValue(NSAttributedString(string: alert.message!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20,weight: UIFont.Weight.medium),NSAttributedString.Key.foregroundColor :UIColor.black]), forKey: "attributedMessage")
       
        alert.addAction(UIAlertAction(title: "知道了",
                                      style: .cancel,
                                      handler: { _ in print("Cancel tap")
           
                                    self.goToNextQuestionChoose()
        
        }))
      
        /* 3. Show
        if let popoverController = alert.popoverPresentationController {
          popoverController.sourceView = self.view
          popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        }  */
      
        present(alert, animated: true, completion: nil)
        
                           
    }
    /*
    func showAnsMessage(at flag : Int)
    {
        if flag == 0  {
            lblMessage.text =  " 👍🎉😄 您好棒啊！答對了👍🎉😄 \n\n 正確答案!\n"
        }
        else
        {
            lblMessage.text =  "👎☠️😢 對不起、你答错了!👎☠️😢! \n \n正確答案!\n"
        }
        lblMessage.textColor =  .red
    
      //  print("carl currentquestion = \(GameName.shared.currentQuestion)")
        lblverse.text = GameName.shared.bibles[GameName.shared.currentQuestion].Verse
        lblverse.textColor =  .black
    
        lblverseNo.text = GameName.shared.bibles[GameName.shared.currentQuestion].VerseNo
        lblverseNo.textColor = .black
    
        timerx?.invalidate()
        /*
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
                    self.goToNextQuestionChoose()
                })
            })
        */
    }  */
    func goToNextQuestionChoose()
    {
        guard !GameName.shared.isLastQuestion
        else
        {
         
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
        GameName.shared.currentQuestion = pos
     //   print("Carl position = \(pos)")
        ansCollection.reloadData()
        goToQuestionChoose(at: pos)
     // goToQuestion(at: state.currentQuestion + 1)
    }
    func goToQuestionChoose(at position: Int)
    {
    
        GameName.shared.currentQuestion = position
 //       print("Carl currentQuestion = \(GameName.shared.currentQuestion)")
   
        if position == GameName.shared.numberOfQuestions
        {
             GameName.shared.isLastQuestion =  true
             goToNextQuestionChoose()
        }
        else
        {
            
             lblQuestion.text = GameName.shared.bibles[position].Title
             txtProgress.text =  "問答題共計: \(GameName.shared.currentQuestion+1)/\(GameName.shared.numberOfQuestions)"
             let progress = Double(position) / Double(10)
       
             updateProgress(to: progress)
      
            if !GameName.shared.isLastQuestion
            {
                   startCountdown()
            }
        }
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
            GameName.shared.myArray[GameName.shared.saveArrayidx+1 ] = "1"
            GameName.shared.myArrayInf[GameName.shared.saveArrayidx ] = "1"
        }
        else
        {
          
            if GameName.shared.error > 3
            {
                image = UIImage(named: "cry")
                GameName.shared.myArrayInf[GameName.shared.saveArrayidx] = "3"
            }
            else
            {
                image = UIImage(named: "cry")
                GameName.shared.myArray[GameName.shared.saveArrayidx+1 ] = "1"
                GameName.shared.myArrayInf[GameName.shared.saveArrayidx] = "2"
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
        if let popoverController = actionSheet.popoverPresentationController {
          popoverController.sourceView = self.view
          popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        }
        self.navigationController?.popViewController(animated: true)
        actionSheet.dismiss(animated: true, completion: nil)}))
    self.present(actionSheet, animated: true, completion: nil)
}

func GameOverSaveData()
{
       
            var sname = ""
            let name = "ce"
            
            sname = name + String(GameName.shared.num) + ".txt"
           print("Carl sname save = \(sname) error \(GameName.shared.error) ok \(GameName.shared.ok)")
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
    
    func goBack()
    {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChooseEnd") as! GameChooseViewController
        self.present(vc, animated: true, completion: nil)
    }
   
}
extension GameChooseViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
            if collectionView == ansCollection
            {
                let components = GameName.shared.bibles[GameName.shared.currentQuestion].Select.components(separatedBy: " ")
                ansString = components
          
            //        GameName.shared.cnt = 1
                    return  ansString.count
            
            }
            else
            {
                return images.count
            }
      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
       
        let cell = ansCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ChooseCell
        
       
        let components = GameName.shared.bibles[GameName.shared.currentQuestion].Select.components(separatedBy: " ")
        ansString = components
  
        cell.lblData.text = ansString[indexPath.row]
        cell.lblData.textColor =  .white
        cell.lblData.font = UIFont.boldSystemFont(ofSize: 20)
        cell.lblData.layer.cornerRadius = 12
        cell.lblData.layer.borderColor = UIColor.clear.cgColor
        cell.lblData.layer.borderWidth = 10
        cell.lblData.backgroundColor = UIColor.blue
   
   //     print("carl  data = \(cell.lblData.text) index = \(indexPath.row) next = \(GameName.shared.currentQuestion)")
        
        return(cell)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
   
  
        let components = GameName.shared.bibles[GameName.shared.currentQuestion].Select.components(separatedBy: " ")
        ansString = components
       
        let astring = ansString[indexPath.row]
       
        let width  =  Int(astring.widthWithConstrainedHeight(height:  30, font: UIFont.systemFont(ofSize: 17)))
  //      print("Carl width = \(width)")
        return CGSize(width: width+30, height: 60)
     
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0.5, left: 0.5, bottom: 0.5, right: 0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        prevCell.layer.borderWidth = 0
        let cell = collectionView.cellForItem(at: indexPath)
      
        cell!.layer.borderWidth = 6.0
        cell!.layer.cornerRadius = 10
   
        cell!.layer.borderColor = UIColor.blue.cgColor
   
        if collectionView == ansCollection
        {
            bible2 = ansString[indexPath.row]
            answer = GameName.shared.bibles[GameName.shared.currentQuestion].Answer
            
            seldata =  answer ?? ""
            //    print("carl  answer = \(seldata)    \(ansString[indexPath.row] ) \(indexPath.row)")
            
            if(ansString[indexPath.row].caseInsensitiveCompare(seldata) == .orderedSame)
            {
                GameName.shared.ErrString = "您好棒啊！答對了"
                GameName.shared.ok += 1
                // print("carl ok = \(GameName.shared.ok)")
                showAnsMessage(at: 0)
             //   print("carl 1200")
            }
            else
            {
                GameName.shared.ErrString = "您答錯了"
                GameName.shared.error += 1
                //   print("carl error = \(GameName.shared.error)")
                showAnsMessage(at: 1)
                
            }
          //  print("carl 1210")
           ansCollection.reloadData()
        }
    }
  
    @IBAction func backAction(_ sender: UIButton)
    {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameHome") as! MainViewController
        self.present(vc, animated: true, completion: nil)
    }
    
  
   
} // end the of extension



extension String
{
    func widthWithConstrainedHeight(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.width
    }
   
}


extension UIAlertController {
    
    //Set background color of UIAlertController
    func setBackgroundColor(color: UIColor) {
        if let bgView = self.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
        }
    }
    
    //Set title font and title color
    func setTitlet(font: UIFont?, color: UIColor?) {
        guard let title = self.title else { return }
        let attributeString = NSMutableAttributedString(string: title)//1
        if let titleFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : titleFont],//2
                                          range: NSMakeRange(0, title.count))
        }
        
        if let titleColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],//3
                                          range: NSMakeRange(0, title.count))
        }
        self.setValue(attributeString, forKey: "attributedTitle")//4
    }
    
    //Set message font and message color
    func setMessage(font: UIFont?, color: UIColor?) {
        guard let message = self.message else { return }
        let attributeString = NSMutableAttributedString(string: message)
        if let messageFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : messageFont],
                                          range: NSMakeRange(0, message.count))
        }
        
        if let messageColorColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : messageColorColor],
                                          range: NSMakeRange(0, message.count))
        }
        self.setValue(attributeString, forKey: "attributedMessage")
    }
    
    //Set tint color of UIAlertController
    func setTint(color: UIColor) {
        self.view.tintColor = color
    }
}
