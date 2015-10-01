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
        // Add tap recognizer
        let tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "Blackfoot Dictionary"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Action to perform for moving to translate view
        if (segue.identifier == "TranslateSegue") {
            let vc: TranslateViewController = segue.destinationViewController as! TranslateViewController
            vc.setInputText(inputTextField.text!)
        } else if (segue.identifier == "RandomWordSegue") {
            // Nothing to perform for moving to Random Word view
            _ = segue.destinationViewController as! RandomWordViewController
        }
    }
    
    func dismissKeyboard() {
        // Resign first responder status
        view.endEditing(true)
    }

    // Handle pressing of translate button
    @IBAction func translateButtonPressed(sender : AnyObject) {
        if (inputTextField.text == "") {
            return
        } else {
            self.performSegueWithIdentifier("TranslateSegue", sender: sender)
        }
    }
    
    @IBAction func randomWordButtonPressed(sender : AnyObject) {
        self.performSegueWithIdentifier("RandomWordSegue", sender: sender)
    }
}

