//
//  NewTableViewCell.swift
//  Scoops
//
//  Created by Jacobo Enriquez Gabeiras on 25/10/16.
//  Copyright © 2016 enanibus. All rights reserved.
//

import UIKit

class NewTableViewCell: UITableViewCell {
    
    //MARK: - Static vars
    static let cellID = "NewTableViewCellId"
    static let cellHeight : CGFloat = 66.0
    static let cellHeader : CGFloat = 66.0
    
    @IBOutlet weak var titulo: UILabel!

    @IBOutlet weak var valoracion: UILabel!
    
    @IBOutlet weak var autor: UILabel!
    
    @IBOutlet weak var foto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.foto.layer.masksToBounds = true
        self.foto.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
