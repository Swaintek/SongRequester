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
    
    var songs = [CKRecord]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadData () {
        songs = [CKRecord]()
        
        let publicData = CKContainer.defaultContainer().publicCloudDatabase
        
        let query = CKQuery(recordType: "Song", predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
        
        publicData.performQuery(query, inZoneWithID: nil) { (results:[CKRecord]?, error:NSError?) -> Void in
            if let songs = results {
                self.songs = songs
                
            }
        
    }
    
    @IBAction func sendRequest(sender: AnyObject) {
        
        let alert = UIAlertController(title: "New Request", message: "Enter a song", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
            textField.placeholder = "Please enter a song name"
        }
        alert.addAction(UIAlertAction(title: "Send", style: .Default, handler: { (action: UIAlertAction) -> Void in
            
            let textField = alert.textFields!.first!
            
            if textField.text != "" {
                let newSong = CKRecord(recordType: "Song")
                newSong["content"] = textField.text
                
                let publicData = CKContainer.defaultContainer().publicCloudDatabase
                publicData.saveRecord(newSong, completionHandler: { (record: CKRecord?, error: NSError?) -> Void in
                    if error == nil {
                        
                        print("Song saved")
                        
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
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
