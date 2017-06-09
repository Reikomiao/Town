//
//  RHomeViewController.swift
//  Town
//
//  Created by 冯振玲 on 2017/5/25.
//  Copyright © 2017年 Reiko. All rights reserved.
//

import UIKit
import SnapKit

class RHomeViewController: UIViewController,UIScrollViewDelegate {

    var viewControllers = [UIViewController]()
    let scrollView = UIScrollView();
    let triangleImageView = UIImageView()
    var buttonArray = [UIButton]()


    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [RTownViewController(),RDynamicViewController(),RSearchViewController(),RMessageViewController(),RMineViewController(),RPublishViewController()]
        addsubViews();

        
        // Do any additional setup after loading the view.
    }
    
    
    func addsubViews(){
        let titleView = UIView();
        titleView.backgroundColor = UIColor.black;
        view.addSubview(titleView);
        titleView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(view);
            make.height.equalTo(60)
        }
        // town
        let townButton = UIButton(type:.custom)
        townButton.setTitle("TOWN", for: .normal)
        townButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        townButton.setTitleColor(UIColor.white, for: .normal)
        townButton.setTitleColor(mainColor, for: .selected)
        townButton.addTarget(self, action: #selector((actionTitleButton(_:))), for: .touchUpInside)
        buttonArray.append(townButton)
        townButton.isSelected = true
        titleView.addSubview(townButton)
        townButton.snp.makeConstraints {(make) in
            make.left.equalTo(titleView).offset(10)
            make.centerY.equalTo(titleView)
        }
        
        // 动态
        let dynamicButton = UIButton(type: .custom)
        dynamicButton.setTitle("动态", for: .normal)
        dynamicButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        dynamicButton.setTitleColor(UIColor.white, for: .normal)
        dynamicButton.setTitleColor(mainColor, for: .selected)
        dynamicButton.addTarget(self, action: #selector((actionTitleButton(_:))), for: .touchUpInside)
        buttonArray.append(dynamicButton)
        titleView.addSubview(dynamicButton)
        dynamicButton.snp.makeConstraints { (make) in
            make.left.equalTo(townButton.snp.right).offset(20)
            make.centerY.equalTo(titleView)
        }
        
         // 搜索，我的，消息，发送
        let selectedArray = ["search_selected","bell_selected","mine_selected","plus_selected"]
        let imageArray = ["search_normal","bell_normal","mine_normal","plus_normal"]
        var tempButton = UIButton(type: .custom)
        for i in 0...3 {
            let rightButton = UIButton(type: .custom)
            rightButton.setImage(UIImage.init(named: imageArray[i]), for: .normal)
            rightButton.setImage(UIImage.init(named: selectedArray[i]), for: .selected)
            buttonArray.append(rightButton)
            rightButton.addTarget(self, action: #selector((actionTitleButton(_:))), for: .touchUpInside)
            titleView.addSubview(rightButton)
            rightButton.snp.makeConstraints({ (make) in
                if i == 0 {
                    make.left.equalTo(view.snp.right).offset(-230)
                }else{
                    make.left.equalTo(tempButton.snp.right).offset(10)
                }
                make.size.equalTo(CGSize.init(width: 50, height: 50))
                make.centerY.equalTo(titleView)
                
            })
            tempButton = rightButton
        }
        // 三角
        triangleImageView.image = UIImage(named:"triangle")
        titleView.addSubview(triangleImageView)
        triangleImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(titleView).offset(-2)
            make.size.equalTo(CGSize.init(width: 6, height: 3))
            make.centerX.equalTo(townButton)
        }
        
        
        view.addSubview(scrollView);
        scrollView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(titleView.snp.bottom)
            
        }
        scrollView.contentSize = CGSize.init(width:screenWidth * (CGFloat)(viewControllers.count), height: 0)
        scrollView.isPagingEnabled = true;
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.delegate = self
        for (index, value) in viewControllers.enumerated() {
            scrollView.addSubview(value.view)
            value.view.snp.makeConstraints({ (make) in
                make.size.equalTo(scrollView)
                make.left.equalTo(scrollView).offset((CGFloat)(index) * screenWidth)
                make.top.equalTo(scrollView);
                
            })
            
        
        }
        
        
        
        
        
    }

    func actionTitleButton(_ button:UIButton){
        let index = buttonArray.index(of: button)
        scrollView.setContentOffset(CGPoint.init(x: (CGFloat)(index!) * screenWidth, y: 0), animated: true)
        changeButtonSelected(button)
    

        
    }
    
    func changeButtonSelected(_ titleButton:UIButton){
   
        for button in buttonArray {
            if button.isSelected {
                button.isSelected = false
            }
        }
        titleButton.isSelected = !titleButton.isSelected
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
     
        
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index =  (Int)(scrollView.contentOffset.x / screenWidth)
        let titleButton = buttonArray[index]
        changeButtonSelected(titleButton)
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index =  (Int)(scrollView.contentOffset.x / screenWidth)
        if index < buttonArray.count - 1 {
            let titleButtonCurrent = buttonArray[index]
            let titleButtonNext = buttonArray[index + 1]
            let x = scrollView.contentOffset.x - ((CGFloat)(index) * screenWidth)
            let triangleImageViewCenterX = (titleButtonNext.center.x - titleButtonCurrent.center.x) *  x / screenWidth + titleButtonCurrent.center.x
//            UIView.animate(withDuration: 0.2) {
                var center = self.triangleImageView.center
                center.x = triangleImageViewCenterX
                self.triangleImageView.center = center;
//            }
            
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
