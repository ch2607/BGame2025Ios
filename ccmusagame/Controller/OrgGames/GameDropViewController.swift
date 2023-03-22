//
//  GameDropViewController.swift
//  ccmusagame
//
//  Created by Carl Hsieh on 2/18/23.
//  Copyright © 2023 Carl Hsieh. All rights reserved.
//

import UIKit

class GameDropViewController: UIViewController {

    let backgroundImageView = UIImageView()
    
     var sIndexPath = IndexPath()
     var  item1: Array<Character> = Array()
     var  item2: Array<Character> = Array()
     var  item3: Array<Character> = Array()
     var  item: Array<Character> = Array()
     var anscounts  = 0  // 答對的數量
     var ans:[Int] = []
     var idx = -1;
     var err = 0
     var select = 0
     let filer: Character = " "
     var  fname = ""
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
    var loop = 0
    var AImage: UIImage = UIImage(named: "sudoku")!
    var QImage: UIImage = UIImage(named: "sudoku")!
//   var CImage: UIImage = UIImage(named: "cross")!
    var crossView: UIImageView!
  
    let TimeLabel: UILabel =       // Title
    {
        let textViewLab = UILabel()
        
        textViewLab.font = UIFont.boldSystemFont(ofSize: 18)
        textViewLab.translatesAutoresizingMaskIntoConstraints = false
        textViewLab.textColor = .brown
       
        return textViewLab
        
    }()
    let ansCollection: UICollectionView =
    {
        let BibleAview = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: BibleAview)
        collection.backgroundColor = UIColor.clear
        collection.translatesAutoresizingMaskIntoConstraints = false
       
        return collection
    }()
    let qnsCollection: UICollectionView =
    {
        let BibleQview = UICollectionViewFlowLayout()
        let layout = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: BibleQview)
        layout.backgroundColor = UIColor.clear
        layout.translatesAutoresizingMaskIntoConstraints = false
        
        return layout
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
        view.addSubview(btn)
        return btn
    }()
    lazy var TextTimes: UILabel =    // Time
    {
        var watchString = ""
        let fractions = GameName.shared.fractions
        let seconds = GameName.shared.seconds
        let minuties = GameName.shared.minuties
        let fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutiesString = minuties > 9 ? "\(minuties)" : "0\(minuties)"
        
        watchString = "遊戲時間: \(minutiesString):\(secondsString).\(fractionsString)"
        
        let textViewTime = UILabel()
        textViewTime.font = UIFont.boldSystemFont(ofSize: 18)
        textViewTime.translatesAutoresizingMaskIntoConstraints = false
        textViewTime.text = watchString
        return textViewTime
    }()
    lazy var ErrLabel: UILabel = {
        let label = UILabel()
      
        label.font = .systemFont(ofSize: 18)
        label.textColor = .red
        label.numberOfLines = 0
       
           // label.text = GameName.shared.isOk
            if GameName.shared.error > 0
            {
                label.text = String("錯誤")  + String(GameName.shared.error) + "次"
            }
            else
            {
                if GameName.shared.OrgMove == 0
                {
                      label.text = String("請記住它!")
                }
                else
                {
                   label.text = String("恭喜您全部答對!")
                }
            }
      
       
        return label
    }()
   
     override func viewDidLoad() {
         super.viewDidLoad()
        self.navigationItem.titleView = setTitle(title:"是非題")
         initView()
         fname = GameName.shared.hname + String(GameName.shared.hnum )
    
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
                            //      print("Carl item2 \(bible2)")
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
         for _ in 1 ... item2.count
         {
             ans.append(0)
         }
         
         timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startGameTimer), userInfo: nil, repeats: true)
         GameName.shared.hnum = GameName.shared.hnum
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
    
     func SaveDataToFIle()
     {
        
        var sname = ""
        let name = "h"
             
        if GameName.shared.error == 0
        {
            GameName.shared.results = 1
        }
         else
         {
             if GameName.shared.over  == 1
             {
                 GameName.shared.results = 3
             }
             else
             {
                 GameName.shared.results = 2
             }
         }
             
         sname = name + String(GameName.shared.hnum) + ".txt"
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
         do {
             
             let dir: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last! as URL
             let url = dir.appendingPathComponent(sname)
             try String(GameName.shared.results).appendLineToURL(fileURL: url as URL)
             try String(contentsOf: url as URL, encoding: String.Encoding.utf8)
             
         }
         catch {
             print("Could not write to file")
         }
         
     }
    
    @objc func presentSkipController() {
        GameName.shared.skip = 1
        //
        //  MARK DEL action sheet here
        //
        var message = String()
        let helloString = "\n\n"
        
    
        message  = "\(GameName.shared.item1)\(helloString)\(helloString)\(GameName.shared.item3)"
        let alert = UIAlertController(title: "看結果",
                                      message: message,
                                      preferredStyle: .actionSheet)
        
        alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
        
        alert.setValue(NSAttributedString(string: alert.message!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20,weight: UIFont.Weight.medium),NSAttributedString.Key.foregroundColor :UIColor.black]), forKey: "attributedMessage")
        
        alert.addAction(UIAlertAction(title: "知道了",
                                      style: .cancel,
                                      handler: { _ in print("Cancel tap")
            self.navigationController?.popViewController(animated: true)
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        // 3. Show
        present(alert, animated: true, completion: nil)
       
    }
    func GameOverImg(title:String, message:String)
        {
        
            let  actionSheet:UIAlertController
            let image:UIImage?
        
            actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
            let margin:CGFloat = 10.0
            let rect = CGRect(x: margin, y: margin, width: actionSheet.view.bounds.size.width - margin * 4.0, height: 120)
            let customView = UIView(frame: rect)
            actionSheet.view.addSubview(customView)
            if GameName.shared.error == 0
            {
                image = UIImage(named: "willdone")
            }
            else
            {
                image = UIImage(named: "oops")
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
        /*    if let popoverController = actionSheet.popoverPresentationController {
              popoverController.sourceView = self.view
              popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            }    */
            self.navigationController?.popViewController(animated: true)
            actionSheet.dismiss(animated: true, completion: nil)}))
        self.present(actionSheet, animated: true, completion: nil)
    }
    @objc func presentModalController() {
      
     
        var message = String()
     //   let  actionSheet:UIAlertController
    //    let image:UIImage?
//        let margin:CGFloat = 10.0
        let helloString = "\n\n"
        SaveDataToFIle()
        if resbtn.isEnabled == true
        {
           
           message  = "\(TextTimes.text!) \(helloString) \(ErrLabel.text!) \(helloString) \(GameName.shared.item1)  \(helloString) \(GameName.shared.item3)"
           print("Carl msg \(message)") //message = "This is a test"
            GameOverImg(title: "遊戲結束", message:message)
       
        }
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
    /*
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
    }  */

     func initView()
    {
         
         super.viewDidLoad()
         view.addSubview(backgroundImageView)
         backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
         backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
         backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
         backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
         backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
         backgroundImageView.image = UIImage(named: "Choosebg")
         view.sendSubviewToBack(backgroundImageView)
         view.addSubview(qnsCollection)
         ansCollection.delegate = self as UICollectionViewDelegate
         ansCollection.dataSource = self as UICollectionViewDataSource
         ansCollection.register(CustomeCell.self, forCellWithReuseIdentifier: "Cell")
         
         view.addSubview(ansCollection)
         ansCollection.delegate = self
         ansCollection.dataSource = self
         ansCollection.register(CustomeCell.self, forCellWithReuseIdentifier: "Cell")
         ansCollection.dragDelegate = self
         ansCollection.dropDelegate = self
        
         qnsCollection.delegate = self
         qnsCollection.dataSource = self
         qnsCollection.register(CustomeCellqns.self, forCellWithReuseIdentifier: "Cell")
         qnsCollection.dragDelegate = self
         qnsCollection.dropDelegate = self
         view.addSubview(TimeLabel)
         GameName.shared.width = Int(((view.frame.width - 10) / 9 ))
         view.addSubview(TimeLabel)
         TimeLabel.translatesAutoresizingMaskIntoConstraints = false
         TimeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 150).isActive = true
        TimeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
       //  TimeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 200).isActive = true
         TimeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0).isActive = true
        TimeLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        TimeLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
     
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
 }


 // MARK: - UICollectionViewDataSource Methods
 extension GameDropViewController: UICollectionViewDataSource {

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         if collectionView == ansCollection
         {
             return item2.count
         }
         else
         {
             return item.count
         }
     }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
     {
         if collectionView == ansCollection
         {
             return ansCollectionView(collectionView, cellForItemAt: indexPath)
         }
         else
         {
             return qnsCollectionView(collectionView, cellForItemAt: indexPath)
         }
     }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
         return CGSize(width: (view.frame.width - 10) / 10, height: (view.frame.width - 10) / 10)
        
     }
     private func ansCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
         let cell = ansCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomeCell
         
         if item2[indexPath.row] == filer
         {
             cell.textLabel.text?  = String("")
             cell.imageView.image = UIImage(named: "clear")
         }
         else
         {
            cell.imageView.image = UIImage(named: "slot")
            cell.textLabel.text = String(item2[indexPath.row])
         }
         return cell
     }

     private func qnsCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = qnsCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomeCellqns
  
         idx = indexPath.row
         if item[indexPath.row] == filer
         {
             if anscounts == 0 && select == 0
             {
                 GameName.shared.item2count += 1
              }
             cell.textLabel.text =  String(item[indexPath.row])
             cell.imageView.image = UIImage(named: "slot")
             
         }
         else
         {
           
             cell.textLabel.text =  String(item[indexPath.row])
             cell.imageView.image = UIImage(named: "sudoku")
        
         }
       
         return cell
     }
 }


 // MARK: - UICollectionViewDelegateFlowLayout Methods
 extension GameDropViewController: UICollectionViewDelegateFlowLayout {

     // To put inset to the collectionView
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return UIEdgeInsets(top: 0.5, left: 0.5, bottom: 0.5, right: 0.5)
     
     }
 }


 // MARK: - UICollectionViewDragDelegate Methods
 extension GameDropViewController: UICollectionViewDragDelegate {

     // Get dragItem from the indexpath
     func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
         let itemName = String(item2[indexPath.row])
         let itemProvider = NSItemProvider(object: itemName as NSString)
         let dragItem = UIDragItem(itemProvider: itemProvider)
         //
         //  user select enter here
         //
         select = 1
         sIndexPath = indexPath
    //     print("carl count \(GameName.shared.item2count)")
         return [dragItem]
     }

     // To only select needed view as preview instead of whole cell
     func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
         if collectionView == ansCollection
         {
        //     let cell = ansCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomeCell
             
             let previewParameters = UIDragPreviewParameters()
        
             return previewParameters
         }
         return nil
     }
 }


 // MARK: - UICollectionViewDropDelegate Methods
 extension GameDropViewController: UICollectionViewDropDelegate {

     // Get the position of the dragged data over the collection view changed
     func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
         if collectionView == qnsCollection, let indexPath = destinationIndexPath {
              collectionView.reloadData()
         }
         return UICollectionViewDropProposal(operation: .copy)
     }

     // Update collectionView after ending the drop operation
     func collectionView(_ collectionView: UICollectionView, dropSessionDidEnd session: UIDropSession) {
  
         collectionView.reloadData()
     }

     // Called when the user initiates the drop operation
     func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {

         var destinationIndexPath: IndexPath
      
         if let indexPath = coordinator.destinationIndexPath
         {
             destinationIndexPath = indexPath
      
         }
         else
         {
             let row = collectionView.numberOfItems(inSection: 0)
             destinationIndexPath = IndexPath(item: row - 1, section: 0)
          
         }

         if collectionView == qnsCollection
         {
            
                 switch coordinator.proposal.operation
                 {
                 case .move:
                     
                     break
                     
                 case .copy:
                     copyItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
                    
                 default:
                     return
                 }
         }
        
     }

     // Actual logic which perform after drop the view
    private func copyItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
             collectionView.performBatchUpdates {
                 for (_, itm) in coordinator.items.enumerated()
                 {
                    //  print("carl item \(item)")
                     if collectionView === qnsCollection
                     {
                   
                         if item2[sIndexPath.row] == item1[destinationIndexPath.row]
                         {
                             item[destinationIndexPath.row] = item2[sIndexPath.row]
                             item2[sIndexPath.row] = filer
                             ansCollection.reloadData()
                             qnsCollection.reloadData()
                             anscounts = anscounts + 1
                             print("carl anscounts \(anscounts) \(GameName.shared.item2count)")
                             if  anscounts == GameName.shared.item2count
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
                                 select = 0
                                 anscounts = 0
                                 GameName.shared.item2count = 0
                                 print("carl gameover")
                             }
                            
                         }
                         else
                         {
                             self.showToast(message: "選擇錯誤!注意只能錯四個字", type: "1")
                             err = err + 1
                         }
                         if err == 4
                         {
                            GameName.shared.over = 1
                             GameName.shared.item = bible
                             GameName.shared.item1 = bible1
                             GameName.shared.item2 = bible2
                             GameName.shared.item3 = bible3
                             GameName.shared.error = err
                             GameName.shared.fractions = fractions
                             GameName.shared.seconds = seconds
                             GameName.shared.minuties = minuties
                             select = 0
                             anscounts = 0
                             GameName.shared.item2count = 0
                           
                             var message = String()
                             let helloString = "\n"
                             SaveDataToFIle()
                    
                             message  = "\(TextTimes.text!) \(helloString) \(ErrLabel.text!) \(helloString) \(GameName.shared.item1)  \(helloString) \(GameName.shared.item3)"
                             GameOverImg(title: "遊戲結束", message:message)
                            
                         }   // err = 4
                        
                     }  // qnsCollection
                 }  // item
             }
         }
}
extension UIImage {

    func imageWithSize(scaledToSize newSize: CGSize) -> UIImage {

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

}
