//
//  RequestDetailViewController.swift
//  SongRequester
//
//  Created by David Swaintek on 7/6/16.
//  Copyright © 2016 David Swaintek. All rights reserved.
//

import UIKit
import CloudKit

class RequestDetailViewController: UIViewController {
    
    var request: CKRecord!

    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBAction func fiveDollarTip(sender: AnyObject) {
        
        request["tip"] = (request["tip"]! as! Double) + 5.0
        
        let publicData = CKContainer.defaultContainer().publicCloudDatabase
        publicData.saveRecord(request, completionHandler: { (record: CKRecord?, error: NSError?) -> Void in
            if error == nil {
                NSOperationQueue.mainQueue().addOperationWithBlock({ 
                    self.tipLabel.text = "Tip Amount: $ \(record!["tip"]!)"
                })
            } else {
                print(error)
            }
        })
    }
    
    @IBAction func tenDollarTip(sender: AnyObject) {
        
        request["tip"] = (request["tip"]! as! Double) + 10.0
        
        let publicData = CKContainer.defaultContainer().publicCloudDatabase
        publicData.saveRecord(request, completionHandler: { (record: CKRecord?, error: NSError?) -> Void in
            if error == nil {
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    self.tipLabel.text = "Tip Amount: $ \(record!["tip"]!)"
                })
            } else {
                print(error)
            }
        })
    }
    
    @IBAction func twentyDollarTip(sender: AnyObject) {
        
        request["tip"] = (request["tip"]! as! Double) + 20.0
        
        let publicData = CKContainer.defaultContainer().publicCloudDatabase
        publicData.saveRecord(request, completionHandler: { (record: CKRecord?, error: NSError?) -> Void in
            if error == nil {
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    self.tipLabel.text = "Tip Amount: $ \(record!["tip"]!)"
                })
            } else {
                print(error)
            }
        })
    }
    
    @IBAction func fiftyDollarTip(sender: AnyObject) {
        
        request["tip"] = (request["tip"]! as! Double) + 50.0
        
        let publicData = CKContainer.defaultContainer().publicCloudDatabase
        publicData.saveRecord(request, completionHandler: { (record: CKRecord?, error: NSError?) -> Void in
            if error == nil {
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    self.tipLabel.text = "Tip Amount: $ \(record!["tip"]!)"
                })
            } else {
                print(error)
            }
        })
    }
    
    @IBAction func hundredDollarTip(sender: AnyObject) {
        
        request["tip"] = (request["tip"]! as! Double) + 100.0
        
        let publicData = CKContainer.defaultContainer().publicCloudDatabase
        publicData.saveRecord(request, completionHandler: { (record: CKRecord?, error: NSError?) -> Void in
            if error == nil {
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    self.tipLabel.text = "Tip Amount: $ \(record!["tip"]!)"
                })
            } else {
                print(error)
            }
        })
    }
    
    
    override func viewWillAppear(animated: Bool) {
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        let imageViewBackground = UIImageView(frame: CGRectMake(0,0,width,height))
        imageViewBackground.image = UIImage(named: "kwahu")
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = imageViewBackground.bounds
        imageViewBackground.addSubview(blurView)
        self.view.addSubview(imageViewBackground)
        self.view.sendSubviewToBack(imageViewBackground)
        songLabel.text = "Song Name: \(request["song"] as! String)"
        artistLabel.text = "Artist: \(request["artist"] as! String)"
        tipLabel.text = "Tip Amount: $ \(request["tip"]!)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
