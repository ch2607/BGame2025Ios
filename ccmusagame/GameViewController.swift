//
//  EasyGameViewController.swift
//  GameApp
//
//  Created by Carl Hsieh on 3/11/19.
//  Copyright © 2019 Carl Hsieh. All rights reserved.
//

import UIKit

class GameName: NSObject {
    static let shared: GameName = GameName()
    var ename = "easy"
    var hname = "hard"
    var mname = "med"
    var cname = "data"
    var item = "item"
    var item1 = "item1"
    var item2 = "item2"
    var item3 = "item3"
    var num = 1
    var hnum = 1
    var mnum = 1
    var err = 0
    var over = 0
    var btnenable = false
    var cnt = 0
    var level = 1
    var minuties: Int  = 0
    var seconds: Int   = 0
    var fractions: Int = 0
}

class GameViewController: UIViewController ,  UICollectionViewDataSource, UICollectionViewDelegate
{
    
    
    @IBOutlet weak var TimeLabel: UILabel!
    /*
    @IBAction func goback(_ sender: Any)
    {
        GameName.shared.btnenable = true
        // save data here
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
            
            
            try GameName.shared.item.appendLineToURL(fileURL: url as URL)
            try GameName.shared.item1.appendLineToURL(fileURL: url as URL)
            try GameName.shared.item2.appendLineToURL(fileURL: url as URL)
            try GameName.shared.item3.appendLineToURL(fileURL: url as URL)
            try String(GameName.shared.err).appendLineToURL(fileURL: url as URL)
            try String(GameName.shared.cnt).appendLineToURL(fileURL: url as URL)
            try String(contentsOf: url as URL, encoding: String.Encoding.utf8)
            
        }
        catch {
            print("Could not write to file")
        }
        self.dismiss(animated: false, completion: nil)
        self.presentingViewController?.dismiss(animated: false, completion: nil)
       // let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameHome") as! ViewController
       // self.present(vc, animated: true, completion: nil)
    }  */
    
    
    var timer = Timer()
    var minuties: Int  = 0
    var seconds: Int   = 0
    var fractions: Int = 0
    
    var gamedInt = 10
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
    
    var mYourImageViewOutlet: UIImageView?
    var AImage: UIImage = UIImage(named: "sudoku")!
    var QImage: UIImage = UIImage(named: "sudoku")!
    var CImage: UIImage = UIImage(named: "cross")!
    var NImage: UIImage = UIImage(named: "backg")!
    var ans:[Int] = []
    var indexrow : Int = 0
   
    @IBOutlet weak var BibleEview: UICollectionView!
    @IBOutlet weak var BibleAview: UICollectionView!
    @IBOutlet weak var BibleQview: UICollectionView!
    
   
    
    var saveidx = 0
    var saveans = 0
    var err = 0
    var cnt = 0
    var okans = 0
    var loop = 0
      var images = [#imageLiteral(resourceName: "backg"), #imageLiteral(resourceName: "backg"), #imageLiteral(resourceName: "backg"), #imageLiteral(resourceName: "backg"), #imageLiteral(resourceName: "backg"), #imageLiteral(resourceName: "backg"),#imageLiteral(resourceName: "backg")]
    var selbtn = 0;
    
   
    let filer: Character = " "
    
    var  fname = ""
 
    var  item: Array<Character> = Array()
    var  item1: Array<Character> = Array()
    var  item2: Array<Character> = Array()
    var  item3: Array<Character> = Array()
    var  item4: Array<Character> = Array()
    /// Curent game state
    var state = State(questions: questions)
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
      
        TimeLabel.text = "00:00.00"
        if GameName.shared.btnenable  == true
        {
            let file = "data.txt"
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            {
                let fractions = GameName.shared.fractions
                let seconds = GameName.shared.seconds
                let minuties = GameName.shared.minuties
                let fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
                let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
                let minutiesString = minuties > 9 ? "\(minuties)" : "0\(minuties)"
                
                watchString = "\(minutiesString):\(secondsString).\(fractionsString)"
                TimeLabel.text = watchString
                
                let fileURL = dir.appendingPathComponent(file)
                print("Path: \(fileURL)")
                
                do
                {
                    let text = try String(contentsOf: fileURL, encoding: .utf8)
                    let lines = text.split(separator: "\n")
                    
                    for line in lines
                    {
                        if loop == 0
                        {
                            item = Array(line)
                            //    print("1. item = \(item)")
                            loop = 1
                            bible = String(line)
                            GameName.shared.item = bible
                        }
                        else
                        {
                            if loop == 1
                            {
                                item1 = Array(line)
                                //    print("item1= \(item1)")
                                loop = 2
                                bible1 = String(line)
                                GameName.shared.item1 = bible1
                            }
                            else
                            {
                                if loop == 2
                                {
                                    item2 = Array(line)
                                    // print("item2 = \(item2)")
                                    loop = 3
                                    bible2 = String(line)
                                    GameName.shared.item2 = bible2
                                }
                                else
                                {
                                    if loop == 3
                                    {
                                        item3 = Array(line)
                                        //   print("item3 = \(item3)")
                                        loop = 4
                                        bible3 = String(line)
                                        GameName.shared.item3 = bible3
                                    }
                                    else
                                    {
                                        if loop == 4
                                        {
                                            loop = 5
                                            err = (line as NSString).integerValue
                                            GameName.shared.err = err
                                        }
                                        else
                                        {
                                            if loop == 5
                                            {
                                                cnt = (line as NSString).integerValue
                                                GameName.shared.cnt = cnt
                                            }
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                }
                catch
                {
                    /* error handling here */
                    
                }
            }
        }
        else
        {
           
            if GameName.shared.level == 1   // 容易
            {
                 print("1 num = \(GameName.shared.num)")
                if GameName.shared.num == 401
                {
                    GameName.shared.num = 1  // reset num
                }
                fname = GameName.shared.ename + String(GameName.shared.num)
                // GameName.shared.num = GameName.shared.num + 1
            }
            else
            {
                if GameName.shared.level == 2    // 較難
                {
                     print("1 mnum = \(GameName.shared.mnum)")
                    if GameName.shared.mnum == 401
                    {
                        GameName.shared.mnum = 1  // reset num
                    }
                    fname = GameName.shared.mname + String(GameName.shared.mnum)
                  //  GameName.shared.num = GameName.shared.mnum + 1
                }
                else
                {
               
                    if GameName.shared.level == 3   // 更難
                    {
                         print("1 hnum = \(GameName.shared.hnum)")
                        if GameName.shared.hnum == 401
                        {
                            GameName.shared.hnum = 1  // reset num
                        }
                        fname = GameName.shared.hname + String(GameName.shared.hnum)
                       // GameName.shared.num = GameName.shared.hnum + 1
                    }
                }
            }
        
            print("name \(fname)")
            if let filepath = Bundle.main.path(forResource: fname, ofType: "txt")
            {
                do
                {
                    let contents  = try String(contentsOfFile: filepath)
                    let lines = contents.split(separator: "\r\n")
            
                    for line in lines
                    {
                        if loop == 0
                        {
                            item1 = Array(line)
                            loop = 1
                            bible1 = String(line)
                            GameName.shared.item1 = bible1
                           //  print("item1\(item1)")
                        }
                        else
                        {
                            if loop == 1
                            {
                                item  = Array(line)
                                loop = 2
                                bible = String(line)
                                GameName.shared.item = bible
                               // print("item\(item)")
                            }
                            else
                            {
                                if loop == 2
                                {
                                    item2 = Array(line)
                                    loop = 3
                                    bible2 = String(line)
                                    GameName.shared.item2 = bible2
                                    //  print("item2 \(item2)")
                                }
                                else
                                {
                                    if loop == 3
                                    {
                                        item3 = Array(line)
                                        loop = 4
                                        bible3 = String(line)
                                        GameName.shared.item3 = bible3
                                
                                        //  print("item3 \(item3)")
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
        }
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
        
        //Creating the chevron (back-arrow)
        //let img = makeBackChevron(size: CGSize(width: 20.0, height: 20.0), colour: nil)! //UIColor.red
        
        //Creating the chevron (back-arrow) to look like Apple's..
        let imgback = makeBackChevron(thickness: 3.0, size: CGSize(width: 22.0, height: 44.0), colour: nil)! //UIColor.red
        
        //Creating the bar button.. Note: Add your own target and action..
        let barButton = UIBarButtonItem(image: imgback, style: .done, target: nil, action:  #selector(self.backAction(_:)))
        
        //Set the left bar button item to be the one we created
        //Then set the items to be part of the navigation bar we created..
        item.leftBarButtonItems = [barButton]
        navigationBar.setItems([item], animated: true)
      //  let layout = UICollectionViewFlowLayout()
     //   layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
       //  layout.itemSize = CGSize(width: 111, height: 111)
       // var integerArray = [Int]()
        for _ in 1 ... item2.count
        {
            ans.append(0)
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.startGameTimer), userInfo: nil, repeats: true)
         if GameName.shared.btnenable  == false
         {
            if GameName.shared.level == 1
            {
                GameName.shared.num = GameName.shared.num + 1
              //  print("2 num = \(GameName.shared.num)")
            }
            else
            {
                if GameName.shared.level == 2
                {
                    GameName.shared.mnum = GameName.shared.mnum + 1
                 //  print("2 mnum = \(GameName.shared.mnum)")
                }
                else
                {
                    if GameName.shared.level == 3
                    {
                        GameName.shared.hnum = GameName.shared.hnum + 1
                      // print("2 hnum = \(GameName.shared.hnum)")
                    }
                }
            }
        }
        
      //  print("1. width = \(view.frame.size.width)")
        let width = view.frame.size.width / 11
       //  print("2. width = \(width)")
        let layout = BibleQview.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSize(width: width, height: width)
        
         let alayout = BibleAview.collectionViewLayout as! UICollectionViewFlowLayout
         alayout.itemSize = CGSize(width: width, height: width)
       //  print("itemSize = \(layout.itemSize)")
    }
    
    func goToQuestion(at position: Int) {
      state.currentQuestion = position
     //  print("carl \(state.question.title)")
      lblQuestion.text = state.question.title
     // navigationItem.title = "SnappyQuiz1 \(position)/\(state.numberOfQuestions)"
      
      let progress = Double(position) / Double(state.numberOfQuestions)
      updateProgress(to: progress)
      startCountdown()
    }
    func startCountdown() {
      lblTimer.text = "00:10"
      
      timer?.invalidate()
      timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
        guard let self = self else { return }
        
        let currentSeconds = Int((self.lblTimer.text ?? "0").replacingOccurrences(of: ":", with: "")) ?? 1
        
        guard currentSeconds > 1 else {
          timer.invalidate()
          self.goToNextQuestion()
          return
        }
        
        self.lblTimer.text = "00:0\(currentSeconds - 1)"
      }
        func goToNextQuestion() {
          guard !state.isLastQuestion else {
            // This is the last question
            let alert = UIAlertController(title: "Good job!",
                                          message: "You got \(state.correctAnswers) out of \(state.numberOfQuestions) right.",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Start Over",
                                          style: .default,
                                          handler: { [weak self] _ in self?.startGame() }))
            
            present(alert, animated: true, completion: nil)
            return
          }
          
          goToQuestion(at: state.currentQuestion + 1)
        }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == BibleQview
        {
            return(item1.count)
        }
        else
        {
            if collectionView == BibleAview
            {
            
               return(item2.count)
            }
            else
            {
                return images.count
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        if collectionView == BibleEview
        {
            if (err == 0)
            {
                let cell:ErrCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ErrCell", for: indexPath) as! ErrCollectionViewCell
                cell.MyImage.image = images[indexPath.row]
                return(cell)
            }
            else
            {
                let cell:ErrCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ErrCell", for: indexPath) as! ErrCollectionViewCell
                cell.MyImage.image = images[indexPath.row]
                return(cell)
            }
        }
        else
        {
            if (collectionView == BibleAview)   // 答案
            {
                let cell:AnsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnsCell", for: indexPath) as! AnsCollectionViewCell
               
                if GameName.shared.level == 1   // 容易
                {
                  
                    if ans[indexPath.row] == 0
                    {
                       
                        if item2[indexPath.row] == filer
                        {
                           cell.MyImage.image = NImage
                            cell.MyAns.text?  = String("")
                        }
                        else
                        {
                            cell.MyImage.image = AImage
                            cell.MyAns.text? = String(item2[indexPath.row])
                        }
                    }
                    else
                    {
                       
                        cell.MyImage.image = NImage
                        cell.MyAns.text? = String(item2[indexPath.row])
                    }
                }
                else
                {
                    if GameName.shared.level == 2   // 較難
                    {
                        if (okans == 1)
                        {
                            if indexPath.row == 1
                            {
                                if item2[indexPath.row] == filer
                                {
                                    if selbtn == 0
                                    {
                                        if  ans[indexPath.row] ==  1
                                        {
                                            cell.MyImage.image =  NImage
                                        }
                                        else
                                        {
                                            cell.MyImage.image =  NImage
                                        }
                                    }
                                    else
                                    {
                                        cell.MyImage.image = NImage
                                    }
                                    cell.MyAns.text? = String("")
                                }
                                else
                                {
                                    cell.MyImage.image =  AImage
                                    cell.MyAns.text? = String("")
                                }
                            }
                            else
                            {
                                if indexPath.row == 2
                                {
                                    if item2[indexPath.row] == filer
                                    {
                                        
                                        if  ans[indexPath.row] ==  1
                                        {
                                            cell.MyImage.image =  NImage
                                        }
                                        else
                                        {
                                            cell.MyImage.image =  NImage
                                        }
                                        cell.MyAns.text? = String("")
                                    }
                                    else
                                    {
                                        
                                        cell.MyImage.image = AImage
                                        cell.MyAns.text? = String(item2[indexPath.row])
                                        if  ans[indexPath.row] ==  1
                                        {
                                            cell.MyImage.image =  NImage
                                        }
                                    }
                                }
                                else
                                {
                                    if indexPath.row == 3
                                    {
                                        if item2[indexPath.row] == filer
                                        {
                                            
                                            if selbtn == 0
                                            {
                                                
                                                if  ans[indexPath.row] ==  1
                                                {
                                                    
                                                    cell.MyImage.image =  NImage
                                                }
                                                else
                                                {
                                                    
                                                    cell.MyImage.image =  NImage
                                                }
                                            }
                                            else
                                            {
                                                
                                                cell.MyImage.image = AImage
                                            }
                                            
                                            cell.MyAns.text? = String("")
                                        }
                                        else
                                        {
                                            
                                            cell.MyAns.text? = String("")
                                            cell.MyImage.image = AImage
                                        }
                                    }
                                    else
                                    {
                                        if indexPath.row == 4
                                        {
                                            if item2[indexPath.row] == filer
                                            {
                                                if  ans[indexPath.row] ==  1
                                                {
                                                    cell.MyImage.image =  NImage
                                                }
                                                else
                                                {
                                                    cell.MyImage.image =  NImage
                                                }
                                                cell.MyAns.text? = String("")
                                            }
                                            else
                                            {
                                                
                                                cell.MyImage.image = AImage
                                                cell.MyAns.text? = String(item2[indexPath.row])
                                                if  ans[indexPath.row] ==  1
                                                {
                                                    cell.MyImage.image =  NImage
                                                }
                                            }
                                        }
                                        else
                                        {
                                            if indexPath.row == 5
                                            {
                                                if item2[indexPath.row] == filer
                                                {
                                                    if selbtn == 0
                                                    {
                                                        if  ans[indexPath.row] ==  1
                                                        {
                                                            cell.MyImage.image =  NImage
                                                        }
                                                        else
                                                        {
                                                            cell.MyImage.image =  NImage
                                                        }
                                                        
                                                    }
                                                    else
                                                    {
                                                        cell.MyImage.image = NImage
                                                    }
                                                    cell.MyAns.text? = String("")
                                                }
                                                else
                                                {
                                                    cell.MyAns.text? = String("")
                                                    cell.MyImage.image = AImage
                                                }
                                            }
                                            else
                                            {
                                                if indexPath.row == 6
                                                {
                                                    if item2[indexPath.row] == filer
                                                    {
                                                        if  ans[indexPath.row] ==  1
                                                        {
                                                            cell.MyImage.image =  NImage
                                                        }
                                                        else
                                                        {
                                                            cell.MyImage.image =  NImage
                                                        }
                                                        cell.MyAns.text? = String("")
                                                    }
                                                    else
                                                    {
                                                        
                                                        cell.MyImage.image = AImage
                                                        cell.MyAns.text? = String(item2[indexPath.row])
                                                        if  ans[indexPath.row] ==  1
                                                        {
                                                            cell.MyImage.image =  NImage
                                                        }
                                                    }
                                                }
                                                else
                                                {
                                                    if indexPath.row == 7
                                                    {
                                                        if item2[indexPath.row] == filer
                                                        {
                                                            if selbtn == 0
                                                            {
                                                                if  ans[indexPath.row] ==  1
                                                                {
                                                                    cell.MyImage.image =  NImage
                                                                }
                                                                else
                                                                {
                                                                    cell.MyImage.image =  NImage
                                                                }
                                                                
                                                            }
                                                            else
                                                            {
                                                                cell.MyImage.image = NImage
                                                            }
                                                            cell.MyAns.text? = String("")
                                                        }
                                                        else
                                                        {
                                                            cell.MyAns.text? = String("")
                                                            cell.MyImage.image = AImage
                                                        }
                                                    }
                                                    else
                                                    {
                                                        if item2[indexPath.row] == filer
                                                        {
                                                            cell.MyImage.image =  NImage
                                                            cell.MyAns.text? = String("")
                                                        }
                                                        else
                                                        {
                                                            //   print("item2 = \(item2[indexPath.row])")
                                                            cell.MyImage.image = AImage
                                                            cell.MyAns.text? = String(item2[indexPath.row])
                                                            if  ans[indexPath.row] ==  1
                                                            {
                                                                cell.MyImage.image =  NImage
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        else
                        {
                            
                            if ans[indexPath.row] == 0
                            {
                               //  print("text = \(item2[indexPath.row])")
                                cell.MyImage.image = AImage
                                cell.MyAns.text? = String(item2[indexPath.row])
                            }
                            else
                            {
                                cell.MyImage.image = AImage
                                cell.MyAns.text? = String(item2[indexPath.row])
                            }
                           //return(cell)
                        }
                    }
                    else
                    {
                        if GameName.shared.level == 3   // 更難
                        {
                            if (okans == 1)
                            {
                                if selbtn == 0
                                {
                                    if  ans[indexPath.row] ==  1
                                    {
                                        cell.MyImage.image =  NImage
                                    }
                                    else
                                    {
                                        cell.MyImage.image =  AImage
                                    }
                                }
                                else
                                {
                                    cell.MyImage.image = NImage
                                }
                                cell.MyAns.text? = String("")
                                
                            }
                            else
                            {
                                cell.MyImage.image = AImage
                                cell.MyAns.text? = String(item2[indexPath.row])
                            }
                        }
                    }
                }
                return(cell)
            }
            else
            {
                let cell:QnsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "QnsCell", for: indexPath) as! QnsCollectionViewCell
                if GameName.shared.level == 1
                {
                    cell.MyQns.text? = String(item[indexPath.row])
                    cell.MyImage.image = QImage
                }
                else
                {
                    if GameName.shared.level == 2  // 較難
                    {
                        cell.MyQns.text? = String(item[indexPath.row])
                        cell.MyImage.image = QImage
                        if okans == 0
                        {
                            if indexPath.row == (item.count - 1)
                            {
                                createAlert(title: "遊戲開始", message: "開始、記住下面答案\n\n準備好了、請按OK")
                            }
                        }
                    }
                    else
                    {
                        if GameName.shared.level == 3  // 更難
                        {
                          
                            cell.MyQns.text? = String(item[indexPath.row])
                            cell.MyImage.image = QImage
                            if okans == 0
                            {
                                if indexPath.row == (item.count - 1)
                                {
                                    createAlert(title: "遊戲開始", message: "開始、記住下面答案\n\n準備好了、請按OK")
                                }
                            }
                        }
                    }
                }
                return(cell)
            }
        }
    
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        if collectionView == BibleQview
        {
           selbtn = 1;
           prevCell.layer.borderWidth = 0
           let cell = collectionView.cellForItem(at: indexPath)
           cell!.layer.borderWidth = 2.0
           cell!.layer.borderColor = UIColor.yellow.cgColor
           prevCell = cell!
           
        
            if item[indexPath.row] ==  filer
            {
               cell!.layer.borderWidth = 2.0
             
                saveidx = indexPath.row
                GameName.shared.item = bible
            }
            else
            {
                //  createAlert(title: "Carl Hsieh", message: "This is a test")
                self.showToast(message: "觸摸空格間....")
                
            }
        }
        else
        {
            
            if collectionView == BibleAview
            {
                
                if ( item1[saveidx] == item2[indexPath.row])
                {
                 
                    item[saveidx] = item2[indexPath.row]
                    GameName.shared.item = String(item)
                    cnt = cnt + 1
                    GameName.shared.cnt = cnt
                    prevCell.layer.borderWidth = 0
                    ans[indexPath.row] = 1
                    item2[indexPath.row] = filer
                    GameName.shared.item2 = String(item2)
                    BibleAview.reloadData()
                    BibleQview.reloadData()
                    selbtn = 0
                  
                }
                else
                {
                    if selbtn == 0
                    {
                        /*
                        let toastLabel = UILabel()
                        
                        toastLabel.lineBreakMode = .byWordWrapping
                        toastLabel.numberOfLines = 0
                        toastLabel.text = "請首先選擇空間格在選擇答案...."
                        toastLabel.sizeToFit()
                        //MARK Resize the Label Frame
                        toastLabel.frame = CGRect(x: toastLabel.frame.origin.x, y: toastLabel.frame.origin.y, width: toastLabel.frame.size.width + 40, height: toastLabel.frame.size.height + 40)
                        self.view.addSubview(toastLabel)  */
                       self.showToast(message: "請首先選擇空間格....")
                        
                    }
                    else
                    {
                        images[err] = CImage
                        err = err + 1
                        GameName.shared.err = err
                        BibleEview.reloadData()
                        if GameName.shared.level == 1
                        {
                            if err == 4
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
                                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EndGame") as! EndGameViewController
                                self.present(vc, animated: true, completion: nil)
                            }
                        }
                        else
                        {
                            if GameName.shared.level == 2
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
                                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EndGame") as! EndGameViewController
                                    self.present(vc, animated: true, completion: nil)
                                }
                            }
                            else
                            {
                                if GameName.shared.level == 3
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
                                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EndGame") as! EndGameViewController
                                        self.present(vc, animated: true, completion: nil)
                                    }
                                }
                            }
                        }
                    }
                }
                
                if ( cnt == item2.count)
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
                  //  let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Result") as! WViewController
                //    self.present(vc, animated: true, completion: nil)
                    let vc1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Back") as! UINavigationController
                    self.present(vc1, animated: true, completion: nil)
                }
            }
 
        }
    }
    func makeBackChevron(thickness: CGFloat, size: CGSize, colour: UIColor? = nil) -> UIImage? {
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
    @IBAction func backAction(_ sender: UIButton) {
      
        GameName.shared.btnenable = true
      //  let savebtn = GameName.shared.btnenable
     //   let UserDefaults = Foundation.UserDefaults.standard
       // UserDefaults.set(savebtn, forKey: "Key")
        // save data here
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
            
            
            try GameName.shared.item.appendLineToURL(fileURL: url as URL)
            try GameName.shared.item1.appendLineToURL(fileURL: url as URL)
            try GameName.shared.item2.appendLineToURL(fileURL: url as URL)
            try GameName.shared.item3.appendLineToURL(fileURL: url as URL)
            try String(GameName.shared.err).appendLineToURL(fileURL: url as URL)
            try String(GameName.shared.cnt).appendLineToURL(fileURL: url as URL)
            try String(contentsOf: url as URL, encoding: String.Encoding.utf8)
            
        }
        catch {
            print("Could not write to file")
        }
         print("ret selbtn = \(GameName.shared.btnenable)")
        self.dismiss(animated: false, completion: nil)
        self.presentingViewController?.dismiss(animated: false, completion: nil)
    }
    
    
    func createAlert(title:String, message:String)
    {
        let alert = UIAlertController(title: title, message:message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:
            { (action) in
                self.okans = 1
                self.BibleAview.reloadData()
                alert.dismiss(animated: true, completion: nil)
                
        }))
        
        
        
        self.present(alert, animated: true, completion: nil)
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

extension UIViewController
{
    
    func showToast(message : String)
    {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
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
