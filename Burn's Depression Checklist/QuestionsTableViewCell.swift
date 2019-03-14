//
//  QuestionsTableViewCell.swift
//  Burn's Depression Checklist
//
//  Created by saroj mohanty on 7/25/18.
//  Copyright © 2018 saroj. All rights reserved.
//

import UIKit

class QuestionsTableViewCell: UITableViewCell {
    
    //Label for the question 
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var selection: UISegmentedControl!
    
    //Used as a callback to the main VC
    var callback : ((Int) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        //Pass the curren selection to the callback
        callback?(sender.selectedSegmentIndex)
    }
}
