//
//  ArticleCellTableViewCell.swift
//  NEWSAPI
//
//  Created by Oshima Haruna on 2018/05/02.
//  Copyright © 2018年 Oshima Haruna. All rights reserved.
//

import UIKit

class Article: NSObject {
    var title: String?
    var url: String?
    var imageUrl: String?
}

class ArticleCellTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!{
        didSet{
            title.numberOfLines = 2
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
