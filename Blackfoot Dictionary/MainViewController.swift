//
//  ViewController.swift
//  Blackfoot Dictionary
//
//  Created by Nicolas Langley on 8/21/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

import UIKit
import Foundation

class MainViewController: UIViewController {
    
    // Input outlets from Interface Builder
    @IBOutlet weak var inputTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "Blackfoot Dictionary"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "TranslateSegue") {
            var vc: TranslateViewController = segue.destinationViewController as TranslateViewController
            vc.setInputText(inputTextField.text)
        }
    }

    // Handle pressing of translate button
    @IBAction func translateButtonPressed(sender : AnyObject) {
        self.performSegueWithIdentifier("TranslateSegue", sender: sender)
    }
    

}

