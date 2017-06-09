//
//  RNavigationViewController.swift
//  SwiftDemo
//
//  Created by 冯振玲 on 2017/5/4.
//  Copyright © 2017年 Reiko. All rights reserved.
//

import UIKit

class RNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = nil;
        
        let apperance = UINavigationBar.appearance();
//        apperance.setBackgroundImage(UIImage(named:"navigate_bg"), for: .default);
        var textAttrs:[String: AnyObject] = [:];
        textAttrs[NSForegroundColorAttributeName] = UIColor.black;
        textAttrs[NSFontAttributeName] = UIFont.systemFont(ofSize: 16);
        apperance.titleTextAttributes = textAttrs;
        
        
    
        

        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count > 0 {
            let backImage = UIImage(named:"back");
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image:backImage, style:.plain, target:self, action:#selector(RNavigationViewController.backBarButtonAction(backBarBarItem:)));
            viewController.hidesBottomBarWhenPushed = true;
            
        }
        super.pushViewController(viewController, animated: animated);
    }

    func backBarButtonAction(backBarBarItem:UIBarButtonItem){
        if self.childViewControllers.count > 0 {
            self.popViewController(animated: true);
        }else{
            self .dismiss(animated: true, completion: { 
                
            });
        }
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
