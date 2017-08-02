//
//  RLoginViewController.swift
//  Town
//
//  Created by 冯振玲 on 2017/6/26.
//  Copyright © 2017年 Reiko. All rights reserved.
//

import UIKit

class RLoginViewController: RViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        
        let coverImageView = UIImageView.init(image: UIImage.init(named: "login_bg"))
        view.addSubview(coverImageView)
        coverImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        

        let backButton = UIButton.init(type: .custom)
        backButton.setImage(UIImage.init(named: "towndetail_back"), for: .normal)
        view.addSubview(backButton)
        backButton.addTarget(self, action:#selector(actionBackButton(_ :)), for: .touchUpInside)
        backButton.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(30)
            make.size.equalTo(CGSize.init(width: 30, height: 30))
        }
        
        
        
        
        let mineView = RMineView.init(typeArray: [.PhoneNum,.Password]) { (doneButton) in
            
        }
        
        view.addSubview(mineView)
        mineView.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.left.right.equalTo(view)
            make.height.equalTo(200)
        }


        // Do any additional setup after loading the view.
    }
    func actionBackButton(_ button:UIButton) {
        superNavigationController().popViewController(animated: true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
