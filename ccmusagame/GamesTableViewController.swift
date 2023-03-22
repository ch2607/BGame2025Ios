//
//  GamesTableViewController.swift
//  ccmusagame
//
//  Created by Carl Hsieh on 5/27/19.
//  Copyright © 2019 Carl Hsieh. All rights reserved.
//

import UIKit

class GamesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    
    var fname = ""
    
    var myArray:[String] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        fname = GameName.shared.ename
        if let filepath = Bundle.main.path(forResource: fname, ofType: "txt")
        {
            do
            {
                let contents  = try String(contentsOfFile: filepath)
                let lines = contents.split(separator: "\r\n")
                print(" lines =\(lines)")
                for line in lines
                {
                    myArray.append(String(line))
                    
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
    
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return myArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GamesTableViewCell
        
        cell.MyLabel?.text = myArray[indexPath.row] as? String
        
        return (cell)
    }
    
    
   
}
