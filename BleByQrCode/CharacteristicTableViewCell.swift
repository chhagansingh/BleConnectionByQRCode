//
//  CharacteristicTableViewCell.swift
//  BleByQrCode
//
//  Created by Chhagan Singh on 27/08/18.
//  Copyright © 2018 Chhagan Singh. All rights reserved.
//

import UIKit

class CharacteristicTableViewCell: UITableViewCell {
    
    @IBOutlet var ValueEntryField: UITextField!
    @IBOutlet var Unsubscribe: UIButton!
    @IBOutlet var UUID: UILabel!
    @IBOutlet var rawProperties: UILabel!
    @IBOutlet var propertyString: UILabel!
    @IBOutlet var rawValue: UILabel!
    @IBOutlet var ASCIIvalue: UILabel!
    @IBOutlet var hexValue: UILabel!
    @IBOutlet var presentationFormat: UILabel!
    @IBOutlet var decValue: UILabel!
    @IBOutlet var userDescription: UILabel!
    @IBOutlet var valueFormat: UILabel!
    @IBOutlet var valueExponent: UILabel!
    @IBOutlet var valueUnits: UILabel!
    @IBOutlet var presentedValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
