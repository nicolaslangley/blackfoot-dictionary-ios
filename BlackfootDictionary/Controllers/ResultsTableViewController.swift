//
//  ResultsTableViewController.swift
//  BlackfootDictionary
//
//  Created by Nicolas Langley on 1/4/16.
//  Copyright © 2016 Hierarchy. All rights reserved.
//

import Foundation

class ResultsTableViewController: UITableViewController {
    
    var inputText: String!
    var randomWord: Bool = false
    var translationResults = [TranslationResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (randomWord) {
            loadRandomWord()
        } else {
            loadTranslatedResults()
        }
    }
    
    func setRandomWord(random: Bool, _nonojbc: () = ()) {
        randomWord = random
    }
    
    // Receive the input text value and store it
    func setInputText(input: String, _nonojbc: () = ()) {
        inputText = input
    }
    
    func loadRandomWord() {
        let outputData = TranslationEngineWrapper.queryRandomWord()
        processData(outputData)
    }
    
    func loadTranslatedResults() {
        let outputData = TranslationEngineWrapper.queryMatches(inputText)
        processData(outputData)
    }
    
    func processData(translations: [String]) {
        for result in translations {
            // Split the string into word and translation
            let resultArr = result.componentsSeparatedByString("-")
            translationResults.append(TranslationResult(blackfootWord: resultArr[0], englishGloss: resultArr[1]))
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
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
}