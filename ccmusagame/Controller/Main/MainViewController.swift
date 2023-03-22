//
//  MainViewController.swift
//  ccmusagame
//
//  Created by Carl Hsieh on 5/21/19.
//  Copyright © 2019 Carl Hsieh. All rights reserved.
//

import UIKit

class GameName: NSObject
{
    @IBAction func more_menu(_ sender: UIBarButtonItem)
    {
    }
    
    static let shared: GameName = GameName()
    var ename = "easy"
    var cename = "ceasy"
    var yename = "yeasy"
    
    var hname = "hard"
    var chname = "chard"
    var yhname = "yhard"
    
    var mname = "med"
    var cmname = "cmed"
    var ymname = "ymed"
    
    var cname = "data"
    var item = "item"
    var item1 = "item1"
    var item2 = "item2"
    var item3 = "item3"
 
    var num = 0
    var hnum = 0
    var mnum = 0
    
    var err = 0
    var over = 0
    var btnenable = false
    var anscount = 0 // 答對的數量
    var level = 0
    var ChooseLevel = 1
    var YandNlevel = 1
    var OrgLevel = 0
    var OrgMove = 0
    var Pagelevel = 0
    var minuties: Int  = 0
    var seconds: Int   = 0
    var fractions: Int = 0
    var ErrString = "您好棒啊！答對了"
    var width = 0
    var okans = 0
    var results = 0
    var error = 0
    var ok = 0
    var GameKind = 0
    var currentQuestion = 0
    var correctAnswers  = 0
    var numberOfQuestions = 10
    var item2count = 0;    // 空格數量
    var item2loop = 0
    var isLastQuestion = false
    var isTrue = true
    var isOk = true
    var skip = 0
    var current = 0
    var didselect = 0
    var saveArrayidx = 0
    var savefileidx = 0
    var saveerror = 0
    var myArray:[String] = []
    var myArrayInf:[String] = []
    var myArrayYandN:[String] = []
    var myArrayInfYandN:[String] = []
        
    var bibles = [Bible]()
}
struct State {
  let questions: [Question]
  let numberOfQuestions: Int
  var currentQuestion: Int
  var correctAnswers: Int
  
  init(questions: [Question]) {
    self.questions = questions
    numberOfQuestions = 9 // questions.count
    currentQuestion = 0
    correctAnswers = 0
  }
  
  var isLastQuestion: Bool {
      print("carl numberOfQuestions == current  = \(GameName.shared.numberOfQuestions)  \(GameName.shared.currentQuestion)")
    //  print("Carl GameName.shared.currentQuestion = \(GameName.shared.currentQuestion)")
    return(  GameName.shared.currentQuestion == GameName.shared.numberOfQuestions)
   // return currentQuestion == numberOfQuestions
  }
  
  var question: Question {
      GameName.shared.currentQuestion -= 1
    return questions[currentQuestion]
  }
}
struct Question {
  let title: String
  let isTrue: Bool
}
struct Answer {
    let text: String
    let correct: Bool  // true / false
}
/*
("耶穌出生在拿撒勒城。", true),
("含、閃和雅弗是挪亞的三個兒子。", true),
("摩西殺死一個埃及人後逃往米甸。", true),
("在大馬士革的婚禮上，耶穌把水變成了酒。", false),
("上帝派約拿去尼尼微。", true), */
var questions = [("耶穌出生在拿撒勒城。", true),
                 ("含、閃和雅弗是挪亞的三個兒子。", true),
                 ("摩西殺死一個埃及人後逃往米甸。", true),
                 ("在大馬士革的婚禮上，耶穌把水變成了酒。", false),
                 ("上帝派約拿去尼尼微。", true)
].map(Question.init)
//
//  JSON Information
//
struct Bible: Decodable
{
    enum kind: String, Decodable
    {
        case scene
        case sticker
    }
    let Num:String
    let Title: String
    let kind: kind
    let isTrue: Bool
    let Answer: String?
    let Select: String
    let Verse: String?
    let VerseNo: String?
}



class MainViewController: UIViewController {

    @IBOutlet weak var LoadGif: UIImageView!

    @IBAction func startgame(_ sender: Any)
    {
       
    }
    
    @IBOutlet var playgame: UIButton!
  
    let backgroundImageView = UIImageView()
   
 
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        let hmGif = UIImage.gifImageWithName("ezgif11123")
       
        let imageView = UIImageView(image: hmGif)
        imageView.frame = CGRect(x: 20.0, y: 150.0, width: self.view.frame.size.width - 40, height: 150.0)
        view.addSubview(imageView)
        setBackground()

    }
    
    private func setBackground()
    {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.image = UIImage(named: "Homepage")
        view.sendSubviewToBack(backgroundImageView)
      
        
    }
}


