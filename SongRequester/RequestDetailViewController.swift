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

    @IBOutlet weak var requestNameLabel: UILabel!
    
    
    override func viewWillAppear(animated: Bool) {
        requestNameLabel.text = request["song"] as? String
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
