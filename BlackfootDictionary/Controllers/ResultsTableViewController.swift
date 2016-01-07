//
//  ResultsTableViewController.swift
//  BlackfootDictionary
//
//  Created by Nicolas Langley on 1/4/16.
//  Copyright © 2016 Hierarchy. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var inputText: String!
    var selectedData: TranslationResult!
    var randomWord: Bool = false
    var translationResults = [TranslationResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsetsMake(-1.0, 0.0, 0.0, 0.0)
        if (randomWord) {
            self.navigationItem.title = "Random Word"
            loadRandomWord()
        } else {
            self.navigationItem.title = "Results"
            loadTranslatedResults()
        }
    }
    
    func setRandomWord(random: Bool, _nonojbc: () = ()) {
        randomWord = random
    }
    
    func setInputText(input: String, _nonojbc: () = ()) {
        inputText = input
    }
    
    func loadRandomWord() {
        let outputData = TranslationEngineWrapper.queryRandomWord()
        processData(outputData)
    }
    
    func loadTranslatedResults() {
        let outputData = TranslationEngineWrapper.queryAllMatches(inputText)
        if (outputData.count == 0) {
            let alert = UIAlertController(title: "No Results Found",
                                          message: "No Matching Word in Dictionary",
                                          preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                switch action.style{
                case .Default:
                    print("no search results found")
                    self.navigationController?.popViewControllerAnimated(true)
                case .Cancel:
                    print("cancel")
                case .Destructive:
                    print("destructive")
                }
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        processData(outputData)
    }
    
    func processData(translations: [String]) {
        for result in translations {
            // Split the string into word and translation
            let resultArr = result.componentsSeparatedByString("-")
            let word = resultArr[0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            let gloss = resultArr[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            translationResults.append(TranslationResult(blackfootWord: word, englishGloss: gloss))
        }
    }
    
    // MARK: TableView functions

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 3.0
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return translationResults.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ResultTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ResultTableViewCell
        let translationResult = translationResults[indexPath.row]
        cell.blackfootWordLabel.text = translationResult.blackfootWord
        cell.englishGlossLabel.text = translationResult.englishGloss
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "RowSelectionSegue" {
            let vc: ResultViewController = segue.destinationViewController as! ResultViewController
            vc.englishGloss = selectedData.englishGloss
            vc.blackfootWord = selectedData.blackfootWord
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedData = translationResults[indexPath.row]
        performSegueWithIdentifier("RowSelectionSegue", sender: self)
    }
}