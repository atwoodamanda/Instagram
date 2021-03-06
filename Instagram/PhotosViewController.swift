//
//  PhotosViewController.swift
//  Instagram
//
//  Created by Amanda Atwood on 11/13/14.
//  Copyright (c) 2014 Amanda Atwood. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var photos: NSArray = []
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var clientId = "e7e020e80da344e5ae69fcb0bd539cfe"
        var url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        
        var request = NSURLRequest(URL: url)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            self.photos = responseDictionary["data"] as NSArray
            self.tableView.reloadData()
            
            println("response: \(self.photos)")
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    //func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      //  var cell = UITableViewCell()
       // cell.textLabel?.text = "This is row \(indexPath.row)"
        
       // return cell
   // }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell") as PhotoTableViewCell
        
        var photo = photos[indexPath.row] as NSDictionary
        var url = photo.valueForKeyPath("images.low_resolution.url") as String
        cell.urlLabel.text = url
        
        cell.photoView.setImageWithURL(NSURL(string: url))
        
        // Configure YourCustomCell using the outlets that you've defined.
        
        return cell
    }
    
}
