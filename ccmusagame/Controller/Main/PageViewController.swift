//
//  PageViewController.swift
//  ccmusagame
//
//  Created by Carl Hsieh on 3/20/23.
//  Copyright © 2023 Carl Hsieh. All rights reserved.
//

import UIKit


class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate{
    
    var pageControl = UIPageControl()
    let item = UINavigationItem(title: " ")
    
    // MARK: UIPageViewControllerDataSource
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.Page1(viewController: "Page 1"),
                self.Page2(viewController: "Page 2"),
                self.Page3(viewController: "Page 3"),
                self.Page4(viewController: "Page 4"),
                self.Page5(viewController: "Page 5")]
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
        
    
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageControl.frame = CGRect(x:10 , y: view.frame.size.height-100, width: view.frame.size.width-20, height: 70)
       
       
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
    
    func Page1(viewController: String) -> UIViewController
    {
       return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Page1") as! Page1ViewController
    }
    
    func Page2(viewController: String) -> UIViewController
    {
       return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Page2") as! Page2ViewController
    }
    
    func Page3(viewController: String) -> UIViewController
    {
       return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Page3") as! Page3ViewController
    }
    func Page4(viewController: String) -> UIViewController
    {
       return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Page4") as! Page4ViewController
    }
    func Page5(viewController: String) -> UIViewController
    {
       return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Page5") as! Page5ViewController
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
