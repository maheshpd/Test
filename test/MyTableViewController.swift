//
//  MyTableViewController.swift
//  test
//
//  Created by Mahesh Prasad on 22/09/18.
//  Copyright © 2018 Mahesh Prasad. All rights reserved.
//

import UIKit

fileprivate let kDataUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
class MyTableViewController: UITableViewController {
    var navTitle: String?
    var records: [Record] = []
    
    var refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 10.0, *){
            tableView.refreshControl = refresh
        }else {
            tableView.addSubview(refresh)
        }
        
        refresh.addTarget(self,action: #selector(refreshData), for: .valueChanged)
        
        loadJson()
    }
    
    @objc func refreshData(sender: UIRefreshControl){
        loadJson()
        sender.endRefreshing()
    }
    func updateData() {
        DispatchQueue.main.async {
            self.navigationItem.title = self.navTitle
            self.tableView.reloadData()
        }
    }
    
    func loadJson() {
        var task: URLSessionDataTask
        guard let url = URL(string: kDataUrl) else {
            print("Bad URL")
            return
        }
        
        let session = URLSession(configuration: .default)
        
        task = session.dataTask(with: url) {
            Data,response,Error in
            guard let data = Data, Error == nil else
            {return}
            
            if let value = String(data:data,encoding: .ascii) {
                if let jsonData = value.data(using: .utf8) {
                    
                    do{
                        let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
                        
                        self.navTitle = json["title"] as? String ?? ""
                        let recordsArray = json["rows"] as? [Dictionary<String,Any>] ?? []
                        self.records.removeAll()
                        
                        for record in recordsArray {
                            let title = record["title"] as? String ?? ""
                            let description = record["description"] as? String ?? ""
                            let imageHref = record["imageHref"] as? String ?? ""
                            
                            self.records.append(Record(title: title,description: description, imageHref: imageHref, image: nil))
                        }
                        self.records.sort {$0.title < $1.title}
                        self.updateData()
                        print(self.records)
                    }catch{
                        print("Unable to Parse JSON")
                    }
                    
                }
            }
            
            
        }
        task.resume()
    }
    func loadImage(imageUrl: String, index: Int){
        var task: URLSessionDataTask
        guard let url = URL(string: imageUrl) else {
            print("Bad URL")
            return
        }
        
        let session = URLSession(configuration: .default)
        
        task = session.dataTask(with: url) {
            Data,response,Error in
            guard let data = Data, Error == nil else
            {return}
            self.records[index].image = UIImage(data: data)
            self.updateData()
        }
        task.resume()
    }
}
