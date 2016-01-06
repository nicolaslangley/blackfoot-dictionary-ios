//
//  AboutViewController.swift
//  BlackfootDictionary
//
//  Created by Nicolas Langley on 10/5/15.
//  Copyright © 2015 Hierarchy. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the reveal view controller
        if (self.revealViewController() != nil) {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "About"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Action to perform for moving to another view
    }
}