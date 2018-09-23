//
//  MyTableViewController + TableView.swift
//  test
//
//  Created by Mahesh Prasad on 22/09/18.
//  Copyright © 2018 Mahesh Prasad. All rights reserved.
//

import UIKit

extension MyTableViewController{
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "TheCell", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
    
    
}
