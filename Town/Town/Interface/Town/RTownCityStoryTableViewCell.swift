//
//  RTownCityStoryTableViewCell.swift
//  Town
//
//  Created by 冯振玲 on 2017/6/9.
//  Copyright © 2017年 Reiko. All rights reserved.
//

import UIKit



class RTownCityStoryTableViewCell: UITableViewCell {
    // 背景
    @IBOutlet weak var cityBackgroundImageView: UIImageView!
    // 时间
    @IBOutlet weak var timeLabel: UILabel!
    // 地址
    @IBOutlet weak var addressLabel: UILabel!
    // 景物
    @IBOutlet weak var sceneryLabel: UILabel!
    // 作者
    @IBOutlet weak var authorLabel: UILabel!
    // 作者头像
    @IBOutlet weak var autherIconImageView: UIImageView!
    // 喜欢的人数
    @IBOutlet weak var likeNumLabel: UILabel!
    // 看的人数
    @IBOutlet weak var seeNumLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func actionLikeButton(_ sender: UIButton) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
