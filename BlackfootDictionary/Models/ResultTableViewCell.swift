//
//  ResultTableViewCell.swift
//  BlackfootDictionary
//
//  Created by Nicolas Langley on 1/4/16.
//  Copyright © 2016 Hierarchy. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var blackfootWordLabel: UILabel!
    @IBOutlet weak var englishGlossLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure view for selected state
    }
}
