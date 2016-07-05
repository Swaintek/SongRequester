//
//  RequestsTableViewController.swift
//  SongRequester
//
//  Created by David Swaintek on 7/3/16.
//  Copyright © 2016 David Swaintek. All rights reserved.
//

import UIKit
import CloudKit


class RequestsTableViewController: UITableViewController {
    
    var requests = [CKRecord]()
    
    var refresh: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Pull to load requests")
        refresh.addTarget(self, action: #selector(RequestsTableViewController.loadData), forControlEvents: .ValueChanged)
        self.tableView.addSubview(refresh)
        loadData()
    }
    
    func loadData () {
        print("Inside loadData")
        requests = [CKRecord]()
        
        let publicData = CKContainer.defaultContainer().publicCloudDatabase
        
        let query = CKQuery(recordType: "Request", predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        publicData.performQuery(query, inZoneWithID: nil) { (results:[CKRecord]?, error:NSError?) -> Void in
            if let requests = results {
                self.requests = requests
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                    self.refresh.endRefreshing()
                })
                print("inside request builder")
                
            }
        }
        
    }

    
    @IBAction func sendRequest(sender: AnyObject) {
        
        let alert = UIAlertController(title: "New Request", message: "Enter a request", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
            textField.placeholder = "Please enter a song name"
        }
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
            textField.placeholder = "Please enter an artist name"
        }
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
            textField.placeholder = "How much would you like to tip?"
        }
        
        
        alert.addAction(UIAlertAction(title: "Send", style: .Default, handler: { (action: UIAlertAction) -> Void in
            
            let songField = alert.textFields![0]
            let artistField = alert.textFields![1]
            let tipField = alert.textFields![2]
            
            if songField.text != "" && artistField != "" && tipField != "" {
                let newRequest = CKRecord(recordType: "Request")
                newRequest["song"] = songField.text
                newRequest["artist"] = artistField.text
                newRequest["tip"] = tipField.text
                
                let publicData = CKContainer.defaultContainer().publicCloudDatabase
                publicData.saveRecord(newRequest, completionHandler: { (record: CKRecord?, error: NSError?) -> Void in
                    if error == nil {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.tableView.beginUpdates()
                            self.requests.insert(newRequest, atIndex: self.requests.count)
                            let indexPathOfLastRow = NSIndexPath(forRow: self.requests.count - 1, inSection: 0)
                            self.tableView.insertRowsAtIndexPaths([indexPathOfLastRow], withRowAnimation: .Top)
                            self.tableView.endUpdates()
                        })
                    } else {
                        print(error)
                    }
                })
            }
        
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return requests.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        print(requests.count)

        if requests.count == 0 {
            return cell
        }
        
        let request = requests[indexPath.row]
        
        print(request)
        
        if let requestSong = request["song"] as? String {
            let requestArtist = request["artist"] as! String
            let requestTip = request["tip"] as! String
            let dateComponentsFormatter = NSDateComponentsFormatter()
            dateComponentsFormatter.allowedUnits = [.Minute]
            let timeStamp = NSDate()
            let creationDate = (request.creationDate!)
            let diff = timeStamp.timeIntervalSinceDate(creationDate)
            let diffString = dateComponentsFormatter.stringFromTimeInterval(diff)
            let elapsedString = "This request is \(diffString!) minutes old"
            let fullRequest = "\(requestSong) by \(requestArtist) for $\(requestTip)"
            
            cell.textLabel?.text = fullRequest
            cell.detailTextLabel?.text = elapsedString
        }

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
