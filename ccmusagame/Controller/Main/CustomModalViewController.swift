//
//  CustomModalViewController.swift
//  ccmusagame
//
//  Created by Carl Hsieh on 8/12/22.
//  Copyright © 2022 Carl Hsieh. All rights reserved.
//



import UIKit

class CustomModalViewController: UIViewController {
    
    
 
  
    // define lazy views
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "看結果"
        label.font = .boldSystemFont(ofSize: 25)
        return label
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
    //
    // input data for results
    //
    lazy var notesLabel: UILabel = {
        let label = UILabel()
   //     if GameName.shared.OrgLevel == 1
   //     {
            label.text = GameName.shared.item1
  //      }
        /*
        else
        {
            if GameName.shared.level == 1
            {
                label.text = GameName.shared.item1
              //  label.text = GameName.shared.bibles[GameName.shared.currentQuestion].Verse
            }
            else
            {
                label.text = GameName.shared.item1
            }
        }  */
        label.font = .systemFont(ofSize: 18)
        label.textColor = .blue
        label.numberOfLines = 0
        return label
    }()
    
    lazy var noLabel: UILabel = {
        let label = UILabel()
  //      if GameName.shared.OrgLevel == 1
   //     {
            label.text = GameName.shared.item3
   //     }
        /*
        else
        {
            if GameName.shared.level == 2
            {
                label.text = GameName.shared.bibles[GameName.shared.currentQuestion].VerseNo
            }
            else
            {
                label.text = GameName.shared.item2
            }
        }  */
        label.font = .systemFont(ofSize: 20)
        label.textColor = .blue
        label.numberOfLines = 0
        return label
    }()
    lazy var ErrLabel: UILabel = {
        let label = UILabel()
      
        label.font = .systemFont(ofSize: 18)
        label.textColor = .red
        label.numberOfLines = 0
        if GameName.shared.OrgLevel == 1
        {
           // label.text = GameName.shared.isOk
            if GameName.shared.err > 0
            {
                label.text = String("錯誤")  + String(GameName.shared.err) + "次"
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
        }
        else
        {
            if GameName.shared.err > 0
            {
                label.text = String("錯誤")  + String(GameName.shared.err) + "次"
            }
        }
        return label
    }()
    
    lazy var contentStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [titleLabel ,TextTimes, ErrLabel, notesLabel, noLabel, retbtn, spacer])
        stackView.axis = .vertical
        stackView.spacing = 12.0
        return stackView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
    
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        
        return view
    }()
    
    let maxDimmedAlpha: CGFloat = 0.6
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        return view
    }()
    
    lazy var retbtn: UIButton =
    {
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 12
        btn.backgroundColor = .green
        btn.setTitle("知道了", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 22, weight: .semibold)
        btn.addTarget(self, action: #selector(showTransparent(_:)), for: .touchUpInside)
        return btn
    }()
   
    
    // Constants
    let defaultHeight: CGFloat = 400
    let dismissibleHeight: CGFloat = 200
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
    // keep current new height, initial is default height
    var currentContainerHeight: CGFloat = 300
    
    // Dynamic container constraint
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        // tap gesture on dimmed view to dismiss
      //  let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCloseAction))
      //  dimmedView.addGestureRecognizer(tapGesture)
        
      //  setupPanGesture()
    }

    @objc func handleCloseAction() {
        animateDismissView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
    }
    
    func setupView() {
        view.backgroundColor = .clear
    }
    
    func setupConstraints() {
        // Add subviews
        view.addSubview(dimmedView)
        view.addSubview(containerView)
       
        view.addSubview(retbtn)
    
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set static constraints
        NSLayoutConstraint.activate([
            // set dimmedView edges to superview
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // set container static constraint (trailing & leading)
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
           
            retbtn.heightAnchor.constraint(equalToConstant: 40),
            retbtn.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 250),
            retbtn.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 50),
            retbtn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            
            // content stackView
            contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
        ])
        
        // Set dynamic constraints
        // First, set container to default height
        // after panning, the height can expand
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        
        // By setting the height to default height, the container will be hide below the bottom anchor view
        // Later, will bring it up by set it to 0
        // set the constant to default height to bring it down again
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)
        // Activate constraints
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
    
    func setupPanGesture() {
        // add pan gesture recognizer to the view controller's view (the whole screen)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        // change to false to immediately listen on gesture movement
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }

    // MARK: Pan gesture handler
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
//        print("Pan gesture y offset: \(translation.y)")
    
        // Get drag direction
        let isDraggingDown = translation.y > 0
    //    print("Dragging direction: \(isDraggingDown ? "going down" : "going up")")
        
        // New height is based on value of dragging plus current container height
        let newHeight = currentContainerHeight - translation.y
        
        // Handle based on gesture state
        switch gesture.state {
        case .changed:
            // This state will occur when user is dragging
            if newHeight < maximumContainerHeight {
                // Keep updating the height constraint
                containerViewHeightConstraint?.constant = newHeight
                // refresh layout
                view.layoutIfNeeded()
            }
        case .ended:
            // This happens when user stop drag,
            // so we will get the last height of container
            
            // Condition 1: If new height is below min, dismiss controller
            if newHeight < dismissibleHeight {
                self.animateDismissView()
            }
            else if newHeight < defaultHeight {
                // Condition 2: If new height is below default, animate back to default
                animateContainerHeight(defaultHeight)
            }
            else if newHeight < maximumContainerHeight && isDraggingDown {
                // Condition 3: If new height is below max and going down, set to default height
                animateContainerHeight(defaultHeight)
            }
            else if newHeight > defaultHeight && !isDraggingDown {
                // Condition 4: If new height is below max and going up, set to max height at top
                animateContainerHeight(maximumContainerHeight)
            }
        default:
            break
        }
    }
    
    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            // Update container height
            self.containerViewHeightConstraint?.constant = height
            // Call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
        // Save current height
        currentContainerHeight = height
    }
    
    // MARK: Present and dismiss animation
    func animatePresentContainer() {
        // update bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
    
    func animateShowDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }
    
    func animateDismissView() {
        // hide blur view
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            // once done, dismiss without animation
            self.dismiss(animated: false)
        }
        // hide main view by updating bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func showTransparent(_ sender: UIButton)
    {
        if GameName.shared.skip  == 0
        {
            if GameName.shared.level ==  0  // easy level
            {
                var sname = ""
                let name = "e"
                //  print("err  =\(GameName.shared.err)", "over = \(GameName.shared.over)")
                if GameName.shared.err == 0
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
                
                sname = name + String(GameName.shared.num) + ".txt"
                print("carl Custom name  \(sname)")
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
            else
            {
                if GameName.shared.level ==  1  // middle level
                {
                    
                    var sname = ""
                    let name = "m"
                    
                    if GameName.shared.err == 0
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
                    
                    sname = name + String(GameName.shared.mnum) + ".txt"
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
                else
                {
                    if GameName.shared.level ==  2   // hard level
                    {
                        var sname = ""
                        let name = "h"
                        
                        if GameName.shared.err == 0
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
                }
            }
        }
        //
        // reset here
        //
        
        GameName.shared.btnenable = false
        GameName.shared.err = 0
        GameName.shared.over = 0
        GameName.shared.anscount = 0
      //  GameName.shared.level = 0
        GameName.shared.results = 0
        GameName.shared.skip = 0
        
     
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Games") as! UINavigationController
          self.present(vc, animated: true, completion: nil)
      /*
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageOrgViewController") as! PageOrgViewController
        self.present(vc, animated: true, completion: nil)  */
    }
    @objc func showNextQuestion(_ sender: UIButton)
    {
        print("Carl currentQuestion = \(GameName.shared.currentQuestion)")
        handleCloseAction()
      //  GameViewController().resetDisplay()
      //  GameViewController().goToQuestion(at: GameName.shared.currentQuestion+1)
    }

}
