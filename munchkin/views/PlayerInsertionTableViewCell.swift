//
//  PlayerInsertionTableViewCell.swift
//  munchkin
//
//  Created by Guilherme Siepmann on 30/04/2018.
//  Copyright © 2018 Guilherme Siepmann. All rights reserved.
//

import UIKit

class PlayerInsertionTableViewCell: UITableViewCell {

    @IBOutlet weak var playerNameTextField: UITextField!
    @IBOutlet weak var playerGenderButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func genderChange(_ sender: Any) {
    }
}
