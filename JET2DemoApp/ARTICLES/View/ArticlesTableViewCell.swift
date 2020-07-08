//
//  ArticlesTableViewCell.swift
//  JET2DemoApp
//
//  Created by Sachin on 07/07/20.
//  Copyright © 2020 Sachin. All rights reserved.
//

import UIKit

class ArticlesTableViewCell: UITableViewCell {
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userDesignationLbl: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var articlePostDateLbl: UILabel!
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleImageHeight: NSLayoutConstraint!
    @IBOutlet weak var articleImageBottom: NSLayoutConstraint!

    @IBOutlet weak var articleContentLbl: UILabel!
    @IBOutlet weak var articleTitleLbl: UILabel!
    @IBOutlet weak var articleTitleLblTop: NSLayoutConstraint!

    @IBOutlet weak var articleURLLbl: UILabel!
    @IBOutlet weak var articleURLLblTop: NSLayoutConstraint!

    @IBOutlet weak var articleLikesLbl: UILabel!
    @IBOutlet weak var articleCommentsLbl: UILabel!
  

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellDescriptor(articleData : ArticlesModel) {
        if let usersData = articleData.user, let user = usersData.first {
            userNameLbl.text = user.name
            userDesignationLbl.text = user.designation
            let url = URL(string: user.avatar ?? "")
            userImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        }
        articlePostDateLbl.text = articleData.createdAt?.toDateFromISO()?.timeAgo()
        articleContentLbl.text = articleData.content ?? ""
        
        articleImage.isHidden = true
        articleImageHeight.constant = 0
        articleImageBottom.constant = 0
        
        articleTitleLbl.isHidden = true
        articleTitleLblTop.constant = 0
        
        articleURLLbl.isHidden = true
        articleURLLblTop.constant = 0
        
        if let allMediaData = articleData.media, let mediaData = allMediaData.first {
            if let articleURl = mediaData.image, !articleURl.isEmpty {
                let url = URL(string: articleURl)
                articleImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
                articleImage.isHidden = false
                articleImageHeight.constant = 160
                articleImageBottom.constant = 15
            }
            if let titleStr = mediaData.title, !titleStr.isEmpty {
                articleTitleLbl.text = titleStr
                articleTitleLbl.isHidden = false
                articleTitleLblTop.constant = 10
            }
            if let articleURL = mediaData.url, !articleURL.isEmpty {
                articleURLLbl.text = articleURL
                articleURLLbl.isHidden = false
                articleURLLblTop.constant = 10
            }
        }
        if articleData.likes == 0 {
            articleLikesLbl.text = "Yet to get like"
        }
        else if articleData.likes == 1 {
            articleLikesLbl.text = "1 like"
        }
        else {
            articleLikesLbl.text = "\(Double(articleData.likes).shortStringRepresentation) Likes"
        }
        
        if articleData.comments == 0 {
            articleCommentsLbl.text = "Yet to get comments"
        }
        else if articleData.comments == 1 {
            articleCommentsLbl.text = "1 comment"
        }
        else {
            articleCommentsLbl.text = "\(Double(articleData.comments).shortStringRepresentation) Comments"
        }
    }
}
