//
//  ViewController.swift
//  instagram
//
//  Created by Bishal Gautam on 1/14/16.
//  Copyright © 2016 Bishal Gautam. All rights reserved.
//

import UIKit
import AFNetworking 

class PhotoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var photos: [NSDictionary]?
    

    override func viewDidLoad() {
       
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                          NSLog("response: \(responseDictionary)")
                            self.photos = responseDictionary["data"] as? [NSDictionary]
                            self.tableView.reloadData()
                    }
                }
        });
        task.resume()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     func numberOfSectionsInTableView(tableView: UITableView) -> Int // Default is 1 if not implemented 
     {
        if let photos = photos {
            return photos.count
        }else {
            return 0
            
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        /*let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier("Header View")! as UITableViewHeaderFooterView
        header.textLabel.text = photo["user"]
        return header*/
        
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        profileView.layer.borderWidth = 1;
        
        // Use the section number to get the right URL
        
        let photo = photos![section]
        let profileURL = photo["user"]!["profile_picture"] as! String
        let username = photo["user"]!["username"] as! String
        let imageURL = NSURL(string: profileURL)
       
        
        profileView.setImageWithURL(imageURL!)
        
        headerView.addSubview(profileView)
        
        // Add a UILabel for the username here
       /* let usernameLabel = UILabel(frame: CGRect(x: 0, y: 0, width:20, height: 20))
        usernameLabel.clipsToBounds = true
        usernameLabel.layer.cornerRadius = 15;
        usernameLabel.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        usernameLabel.layer.borderWidth = 1;*/
        
       let usernamelabel = UILabel(frame: CGRectMake(0, 0, 200, 21))
        //usernamelabel.backgroundColor = UIColor(white: 1, alpha: 0.9)
        usernamelabel.center = CGPointMake(160, 284)
        usernamelabel.textAlignment = NSTextAlignment.Center
        usernamelabel.clipsToBounds = true
        usernamelabel.text = username
        headerView.addSubview(usernamelabel)
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
       // tableView.rowHeight = 320
        
        return 1
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FeedCell", forIndexPath: indexPath) as! FeedCell
        let photo = photos![indexPath.section]

        let baseURL = photo["images"]!["standard_resolution"]!!["url"] as! String
        let imageUrl = NSURL(string:
            baseURL         )
        let user = photo["user"]!["username"]as! String
        
        cell.myLabel.text = user
        
        cell.posterLabel.setImageWithURL(imageUrl!)
      //  print("row\(indexPath.row)")
        return cell
        
        
        
    }
}

