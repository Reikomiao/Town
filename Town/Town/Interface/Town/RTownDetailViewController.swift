//
//  RTownDetailViewController.swift
//  Town
//
//  Created by 冯振玲 on 2017/6/21.
//  Copyright © 2017年 Reiko. All rights reserved.
//

import UIKit
import CoreMotion

class RTownDetailViewController: RViewController {
    var coverImage = String()
    var motionManager =  CMMotionManager()
    var imageScrollView = UIScrollView.init()
    var offx:CGFloat?

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        startUpdates()
       
        // Do any additional setup after loading the view.
    }
    
    func addSubViews(){
        
        let coverImageView = UIImageView.init()
        coverImageView.sd_setImage(with: URL.init(string: imageDomain + coverImage))
        let image = coverImageView.image
        let imageWidth = (image?.size.width)! * screenHeight / (image?.size.height)!
        

    
        imageScrollView = UIScrollView.init()
        imageScrollView.bounces = false
        view.addSubview(imageScrollView)
        imageScrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
            make.height.equalTo(screenHeight)
            make.width.equalTo(screenWidth)
        }
        offx = (imageWidth - screenWidth) / 2
        imageScrollView.contentOffset = CGPoint.init(x: offx!, y: 0)
        imageScrollView.contentSize = CGSize.init(width: imageWidth, height: screenHeight)
        imageScrollView.backgroundColor = UIColor.yellow
        
        imageScrollView.addSubview(coverImageView)
        coverImageView.snp.makeConstraints { (make) in
            make.left.equalTo(imageScrollView)
            make.size.equalTo(imageScrollView.contentSize)
            make.right.equalTo(imageScrollView)
        }
        coverImageView.image = image
        
    
        
        let hearderView = UIView()
        view.addSubview(hearderView)
        hearderView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(view)
            make.height.equalTo(50)
            
        }
        
        let backButton = UIButton.init(type: .custom)
        backButton.setImage(UIImage.init(named: "towndetail_back"), for: .normal)
        hearderView.addSubview(backButton)
        backButton.addTarget(self, action:#selector(actionBackButton(_ :)), for: .touchUpInside)
        backButton.snp.makeConstraints { (make) in
            make.left.equalTo(hearderView).offset(15)
            make.centerY.equalTo(hearderView)
            make.size.equalTo(CGSize.init(width: 30, height: 30))
        }
        
       
        
    }
    func actionBackButton(_ button:UIButton) {
        superNavigationController().popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startUpdates() {
        if !motionManager.isGyroAvailable {
            return
        }
        motionManager.gyroUpdateInterval = 0.5
        motionManager.showsDeviceMovementDisplay = true
        
        motionManager.startGyroUpdates(to: .main) { gyroData, error in
            guard let gyroData = gyroData else { return }
            var ratey = gyroData.rotationRate.y
            if ratey > 0{
                if ratey > 1 {
                    ratey = 1
                }
                self.imageScrollView.contentOffset = CGPoint.init(x: self.offx! + screenWidth + (self.offx! * CGFloat(ratey))
                    , y: 0)
                
            }else{
                if ratey < -1 {
                    ratey = -1
                }
                self.imageScrollView.contentOffset = CGPoint.init(x: screenWidth + self.offx! * 2 + self.offx! * CGFloat(ratey)
                    , y: 0)
            }
            
//            print(gyroData.rotationRate.y)

            
        }
    }
    
    func stopUpdates() {
        if !motionManager.isAccelerometerAvailable {
            return
        }
        
        motionManager.stopGyroUpdates()
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
