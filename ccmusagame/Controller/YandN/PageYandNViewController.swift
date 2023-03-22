//
//  YandNViewController.swift
//  ccmusagame
//
//  Created by Carl Hsieh on 12/17/22.
//  Copyright © 2022 Carl Hsieh. All rights reserved.
//

import UIKit

class PageYandNViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate{
    
    var pageControl = UIPageControl()
    let item = UINavigationItem(title: " ")
    
    // MARK: UIPageViewControllerDataSource
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.YandNEasyPage(viewController: "Easy Page"),
                self.YandNHardPage(viewController: "Hard Page"),
                self.YandNVeryHardPage(viewController: "Very Hard Page")]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        self.dataSource = self
        self.delegate = self
        
        
        // This sets up the first view that will show up on our page control
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        configurePageControl()
        
        let navigationBar = UINavigationBar()
        self.view.addSubview(navigationBar)
        NSLayoutConstraint.activate([
            navigationBar.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            navigationBar.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            navigationBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        ])
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        //Creating a navigation bar item with title..
        //  let item = UINavigationItem(title: "填空題")
        
      //  let item = UINavigationItem(title: " ")
       /*
        if GameName.shared.YandNlevel == 3
        {
            item.title =  "填空題"
        }
        else
        {
            if GameName.shared.YandNlevel == 2
            {
                item.title =  "是非題"
            }
            else
            {
                item.title =  "問答題"
            }
        }  */
        
        //Creating the chevron (back-arrow) to look like Apple's..
        let img = makeBackChevron(thickness: 3.0, size: CGSize(width: 22.0, height: 44.0), colour: nil)! //UIColor.red
        
        //Creating the bar button.. Note: Add your own target and action..
        let barButton = UIBarButtonItem(image: img, style: .done, target: nil, action:  #selector(self.backAction(_:)))
        
        //Set the left bar button item to be the one we created
        //Then set the items to be part of the navigation bar we created..
         item.leftBarButtonItems = [barButton]
         navigationBar.setItems([item], animated: true)
 
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageControl.frame = CGRect(x:10 , y: view.frame.size.height-100, width: view.frame.size.width-20, height: 70)
        if pageControl.currentPage == 0
        {
            item.title = "是非題-容易"
        }
        else
        {
            if pageControl.currentPage == 1
            {
                item.title = "是非題-較難"
            }
            else
            {
                if pageControl.currentPage == 2
                {
                    item.title = "是非題-更難"
                }
            }
        }
       
    }
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = orderedViewControllers.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.gray
        self.pageControl.currentPageIndicatorTintColor = UIColor.systemRed
        self.view.addSubview(pageControl)
    }
    
    func YandNEasyPage(viewController: String) -> UIViewController
    {
        GameName.shared.YandNlevel = 1
      
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "YandNEasy") as! YandNEasyViewController
    }
    
    func YandNHardPage(viewController: String) -> UIViewController
    {
        GameName.shared.YandNlevel = 2
      
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "YandNHard") as! YandNHardViewController
    }
    
    func YandNVeryHardPage(viewController: String) -> UIViewController
    {
        GameName.shared.YandNlevel = 3
      
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "YandNVeryHard") as! YandNVeryHardViewController
    }
    
    
    
    
    // MARK: Delegate methords
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.firstIndex(of: pageContentViewController)!
      //  print("Carl 146 YandNlevel = \(GameName.shared.YandNlevel)")
    }
    
    // MARK: Data source functions.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
      
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
            // return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        print("Carl 155 YandNlevel = \(GameName.shared.YandNlevel)")
        return orderedViewControllers[previousIndex]
    }
   
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
     //   print("Carl 179 YandNlevel = \(GameName.shared.YandNlevel)")
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
          
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
       
        return orderedViewControllers[nextIndex]
    }
    @IBAction func backAction(_ sender: UIButton)
    {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameHome") as! MainViewController
        self.present(vc, animated: true, completion: nil)
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
   
}
