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
        return records.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return records[section].title
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tagLabel = UILabel(frame: CGRect(x: 8, y: 60, width: 200, height: 30))
        tagLabel.font = .systemFont(ofSize: 12.0)
        tagLabel.lineBreakMode = .byWordWrapping
        tagLabel.numberOfLines = 0
        tagLabel.text = records[indexPath.section].description
        tagLabel.sizeToFit()
        
        var image = CGFloat(0.0)
        
        if records[indexPath.section].image != nil {
            image = (records[indexPath.section].image?.size.height)! > CGFloat(60.0) ? 60 : (records[indexPath.section].image?.size.height)!
        }
        
        return image > CGFloat(tagLabel.bounds.height + 6) ? image : tagLabel.bounds.height + 6
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TheCell", for: indexPath)
        
        cell.textLabel?.text = records[indexPath.section].description
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0
        cell.sizeToFit()
        
        if records[indexPath.section].image == nil && !records[indexPath.section].imageHref.isEmpty {
            
            loadImage(imageUrl: records[indexPath.section].imageHref, index: indexPath.section)
        }else{
            cell.imageView?.image = records[indexPath.section].image
        }
        
        return cell
    }
    
    
}
