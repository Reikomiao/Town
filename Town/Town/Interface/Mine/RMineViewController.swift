//
//  RMineViewController.swift
//  Town
//
//  Created by 冯振玲 on 2017/5/25.
//  Copyright © 2017年 Reiko. All rights reserved.
//

import UIKit

class RMineViewController: RViewController {
    
    @IBOutlet weak var shadowView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        shadowView.layer.shadowOffset = CGSize.init(width: 10, height: 10)
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowRadius = 50
   

        // Do any additional setup after loading the view.
    }


    @IBAction func actionLoactionButton(_ sender: UIButton) {
        // 暂时写成登录注册
        let loginVC = RLoginViewController()
        superNavigationController().pushViewController(loginVC, animated: true)
 
    
    }
    
    
    @IBAction func actionPhotoButton(_ sender: UIButton) {
    }
    
    
    @IBAction func actionSetButton(_ sender: UIButton) {
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
