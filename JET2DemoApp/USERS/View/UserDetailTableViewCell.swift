//
//  UserDetailTableViewCell.swift
//  JET2DemoApp
//
//  Created by Sachin on 06/07/20.
//  Copyright © 2020 Sachin. All rights reserved.
//

import UIKit

class UserDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userDesignationLbl: UILabel!
    @IBOutlet weak var userCityLbl: UILabel!
    @IBOutlet weak var userImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
