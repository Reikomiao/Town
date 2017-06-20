//
//  RTownLocationSetTableViewCell.swift
//  Town
//
//  Created by 冯振玲 on 2017/6/20.
//  Copyright © 2017年 Reiko. All rights reserved.
//

import UIKit

class RTownLocationSetTableViewCell: UITableViewCell {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var autherImageView: UIImageView!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var seeNumLabel: UILabel!
  
    var locationSetModel = RTownLocationSetModel(){
        didSet {
            coverImageView.sd_setImage(with: URL.init(string: imageDomain + locationSetModel.coverImage))
            autherImageView.sd_setImage(with: URL.init(string: imageDomain + locationSetModel.autherImage))
            venueLabel.text = locationSetModel.name
            seeNumLabel.text = locationSetModel.seeNum;
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
