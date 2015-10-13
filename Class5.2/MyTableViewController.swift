//
//  MyTableViewController.swift
//  Class5.2
//
//  Created by Elaine Fang on 10/7/15.
//  Copyright © 2015 Elaine Fang. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {

    
    var movieNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(movieNames)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieNames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        cell.textLabel?.text = movieNames[indexPath.row]
        
        return cell
    }


}
