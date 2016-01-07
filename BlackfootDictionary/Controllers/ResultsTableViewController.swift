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
    var translationWordResults = [TranslationResult]()
    var translationPhraseResults = [TranslationResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (randomWord) {
            self.navigationItem.title = "Random Word"
            // Remove header
            self.tableView.contentInset = UIEdgeInsetsMake(-1.0, 0.0, 0.0, 0.0)
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
        processData(outputData, isWord: true)
    }
    
    func loadTranslatedResults() {
        let outputWordData = TranslationEngineWrapper.queryWordMatches(inputText)
        let outputPhraseData = TranslationEngineWrapper.queryPhraseMatches(inputText)
        if (outputWordData.count == 0 && outputPhraseData.count == 0) {
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
        processData(outputWordData, isWord: true)
        processData(outputPhraseData, isWord: false)
    }
    
    func processData(translations: [String], isWord: Bool) {
        for result in translations {
            // Split the string into word and translation
            let resultArr = result.componentsSeparatedByString("-")
            let word = resultArr[0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            let gloss = resultArr[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            if (isWord) {
                self.translationWordResults.append(TranslationResult(blackfootWord: word, englishGloss: gloss))
            } else {
                self.translationPhraseResults.append(TranslationResult(blackfootWord: word, englishGloss: gloss))
            }
        }
    }
    
    // MARK: TableView functions

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if (!randomWord) {
            return 2
        } else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (!randomWord) {
            if (section == 0) {
                return 30.0
            } else {
                return 15.0
            }
        }
        return 3.0
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (!randomWord) {
            if (section == 0) {
                return "Words"
            } else if (section == 1) {
                return "Phrases"
            }
        }
        return nil
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return self.translationWordResults.count
        } else {
            return self.translationPhraseResults.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ResultTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ResultTableViewCell
        if (indexPath.section == 0) {
            let translationResult = self.translationWordResults[indexPath.row]
            cell.blackfootWordLabel.text = translationResult.blackfootWord
            cell.englishGlossLabel.text = translationResult.englishGloss
        } else {
            let translationResult = translationPhraseResults[indexPath.row]
            cell.blackfootWordLabel.text = translationResult.blackfootWord
            cell.englishGlossLabel.text = translationResult.englishGloss
        }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "RowSelectionSegue" {
            let vc: ResultViewController = segue.destinationViewController as! ResultViewController
            vc.englishGloss = self.selectedData.englishGloss
            vc.blackfootWord = self.selectedData.blackfootWord
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 0) {
            self.selectedData = self.translationWordResults[indexPath.row]
        } else {
            self.selectedData = self.translationPhraseResults[indexPath.row]
        }
        performSegueWithIdentifier("RowSelectionSegue", sender: self)
    }
}