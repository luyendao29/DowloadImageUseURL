//
//  TableViewCell.swift
//  Reuse cell
//
//  Created by AnhTT on 8/11/20.
//  Copyright © 2020 AnhTT. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var imageName: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleSetup()
        // Initialization code
    }
 override func prepareForReuse() {
        imageName.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension TableViewCell {
    func styleSetup() {
        imageName.layer.borderWidth = 1
        imageName.layer.borderColor = UIColor.red.cgColor
    }
}
