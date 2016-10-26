//
//  NewTableViewCell.swift
//  Scoops
//
//  Created by Jacobo Enriquez Gabeiras on 25/10/16.
//  Copyright © 2016 enanibus. All rights reserved.
//

import UIKit

class NewTableViewCell: UITableViewCell {
    @IBOutlet weak var titulo: UILabel!

    @IBOutlet weak var valoracion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
