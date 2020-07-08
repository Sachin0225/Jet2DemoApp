//
//  UserDetailViewController.swift
//  JET2DemoApp
//
//  Created by Sachin on 07/07/20.
//  Copyright © 2020 Sachin. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userDesignationLbl: UILabel!
    @IBOutlet weak var userCityLbl: UILabel!
    @IBOutlet weak var userDescriptionLbl: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    var userData : UsersModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let data = userData {
            let url = URL(string: data.avatar ?? "")
            self.userImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
            self.userCityLbl.text = data.city ?? ""
            self.userNameLbl.text = data.name ?? ""
            self.userDesignationLbl.text = data.designation ?? ""
            self.userDescriptionLbl.text = data.about ?? ""
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
