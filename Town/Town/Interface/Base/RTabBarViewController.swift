//
//  RTabBarViewController.swift
//  SwiftDemo
//
//  Created by 冯振玲 on 2017/5/4.
//  Copyright © 2017年 Reiko. All rights reserved.
//

import UIKit

class RTabBarViewController: UITabBarController {

    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChildViewControllers();

        // Do any additional setup after loading the view.
    }
    
    private func addChildViewControllers(){
         

        
        
        
    }
    
    private func addChildViewController(controller: UIViewController, title:String, normalImageName: String, selectedImageName: String){
        controller.tabBarItem.image = UIImage(named:normalImageName);
        controller.tabBarItem.selectedImage = UIImage(named:selectedImageName);
        controller.tabBarItem.title = title;
        
        let navgationController = RNavigationViewController();
        navgationController.addChildViewController(controller);
        self.addChildViewController(navgationController);
        
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
