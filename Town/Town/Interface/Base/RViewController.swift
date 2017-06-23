//
//  RViewController.swift
//  SwiftDemo
//
//  Created by 冯振玲 on 2017/5/4.
//  Copyright © 2017年 Reiko. All rights reserved.
//

import UIKit

class RViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func superNavigationController() -> UINavigationController {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController
        if (rootVC?.isKind(of: UINavigationController.self))! {
            return rootVC as! UINavigationController
        }
        return UINavigationController()
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
