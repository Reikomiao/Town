//
//  RMineView.swift
//  Town
//
//  Created by 冯振玲 on 2017/6/26.
//  Copyright © 2017年 Reiko. All rights reserved.
//

import UIKit
import SnapKit


class RMineView: UIView,UITextFieldDelegate {
    enum RMineviewType {
        case PhoneNum
        case Password
        case VerificationCode

    }
    var viewTypeArray = [RMineviewType]()
    var viewIndicatorNum = 0
    var widthConstraint: Constraint?
    var topConstraint: Constraint?
    let indicatorView = UIView.init()
    let nextButton = UIButton.init(type: .custom)
    let hintLable = UILabel.init()
    var viewcurrentType = RMineviewType.PhoneNum
    let textField = UITextField.init()
    let phoneNumTextField = UITextField.init()
    var viewDoneButtonClosure:((_ doneButton:UIButton) -> Void)?


    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    init(typeArray:[RMineviewType], doneButtonClosure:@escaping ((_ doneButton:UIButton) -> Void)) {
        super.init(frame:.zero)
        viewDoneButtonClosure = doneButtonClosure
        viewTypeArray = typeArray
        viewcurrentType = typeArray.first!
        addSubViews()

    }

    override func layoutSubviews() {
        super.layoutSubviews()
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews(){
        
        // 横线
        let lineView = UIView()
        lineView.backgroundColor = UIColor.white
        addSubview(lineView)
        lineView.frame = CGRect.init(x: 30, y: 90, width: (screenWidth - 100)/2, height: 0.5)
//        lineView.snp.makeConstraints { (make) in
//            make.left.equalTo(30)
//            make.top.equalTo(25)
//            make.height.equalTo(0.5)
//            self.widthConstraint =  make.width.equalTo((screenWidth - 60) / 2).constraint
//
//        }
        UIView.animate(withDuration: 1, delay: 0, options: .beginFromCurrentState, animations: {
//            self.widthConstraint?.update(offset: screenWidth - 60)
//            self.layoutIfNeeded()
            lineView.frame = CGRect.init(x: 30, y: 90, width: (screenWidth - 100), height: 0.5)
        }) { (finish) in
            
        }
        // 按钮
        nextButton.setImage(UIImage.init(named: "nextButton_normal"), for: .normal)
        nextButton.alpha = 0
        nextButton.addTarget(self, action: #selector(actionNextButton(_ :)), for: .touchUpInside)
        addSubview(nextButton)
        nextButton.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.size.equalTo(CGSize.init(width: 40, height: 40))
            make.centerY.equalTo(lineView)
        
        }
        
        phoneNumTextField.isHidden = true
//        phoneNumTextField.delegate = self
        phoneNumTextField.textColor = UIColor.darkGray
        phoneNumTextField.isEnabled = false
        phoneNumTextField.borderStyle = .none
        phoneNumTextField.font = UIFont.init(name: "Avenir Next Condensed-Medium", size: 15)
        self.addSubview(phoneNumTextField)
        phoneNumTextField.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(30)
            make.right.equalTo(self).offset(-30)
            self.topConstraint = make.top.equalTo(self).offset(50).constraint

        }
        
     
        
        // 输入框
        textField.alpha = 0
        textField.delegate = self
        textField.textColor = UIColor.white
        textField.borderStyle = .none
        textField.becomeFirstResponder()
        textField.font = UIFont.init(name: "Avenir Next Condensed-Medium", size: 15)
        self.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(30)
            make.right.equalTo(self).offset(-30)
            make.top.equalTo(self).offset(50)
        }
        
        
        
        hintLable.alpha = 0
        hintLable.textColor = UIColor.white
        hintLable.font = UIFont.init(name: "PingFangSC-Medium", size: 14)
        self.addSubview(hintLable)
        hintLable.snp.makeConstraints { (make) in
            make.left.equalTo(textField)
            make.top.equalTo(lineView.snp.bottom).offset(20)
            make.width.equalTo(textField)
        }
        
        switch viewcurrentType {
        case .PhoneNum:
            textField.keyboardType = .numberPad
            phoneNumTextField.keyboardType = .numberPad
            hintLable.text = "请输入手机号"
        case .Password:
            textField.isSecureTextEntry = true
            hintLable.text = "请输入密码"

        case .VerificationCode:
            textField.keyboardType = .numberPad
            hintLable.text = "请输入验证码"

        default:break
        }
        
        indicatorView.alpha = 0
        addSubview(indicatorView)
        indicatorView.snp.makeConstraints { (make) in
            make.top.equalTo(hintLable.snp.bottom).offset(30)
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.left.equalTo(textField)

 
        }
        
        var tempImageView:UIImageView?
        for (index,_) in viewTypeArray.enumerated()  {
            let indicatorImageView = UIImageView.init()

            if index == 0 {
                indicatorImageView.image = UIImage.init(named:"triangle_current")

            }else{
                indicatorImageView.image = UIImage.init(named:"triangle_next")

            }
            indicatorView.addSubview(indicatorImageView)
            indicatorImageView.tag = index
            indicatorImageView.snp.makeConstraints { (make) in
                if (index == 0) {
                    make.left.equalToSuperview()
                }else{
                    make.left.equalTo((tempImageView?.snp.right)!).offset(20)
                }
                make.top.equalToSuperview()
                make.size.equalTo(CGSize.init(width: 5, height: 10))
            }
            
            tempImageView = indicatorImageView
        }
        
        // 忘记密码
        let forgetPasswordButton = UIButton.init(type: .custom)
        forgetPasswordButton.setTitle("忘记密码？", for: .normal)
        forgetPasswordButton.setTitleColor(mainColor, for: .normal)
        forgetPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        forgetPasswordButton.isHidden = true
        addSubview(forgetPasswordButton)
        forgetPasswordButton.snp.makeConstraints { (make) in
            make.top.equalTo(indicatorView.snp.bottom).offset(20)
            make.left.equalTo(textField)
        }
        
        
        UIView.animate(withDuration: 1, delay: 1, options: .beginFromCurrentState, animations: {
            self.nextButton.alpha = 1
            self.textField.alpha = 1
            self.hintLable.alpha = 1
            self.indicatorView.alpha = 1
            
        }) { (finish) in
            
        }
       
    }
    
    // 指示器指向的位置
    func indicatorSelectIndex(index:Int) {
        for (value,view) in indicatorView.subviews.enumerated() {
            let indicatorImageView = view as! UIImageView
            if value == index {
                indicatorImageView.image = UIImage.init(named:"triangle_current")
            }else{
                indicatorImageView.image = UIImage.init(named:"triangle_front")

            }
            
        }
    }
    
    // 下一步按钮
    func  actionNextButton(_ button:UIButton) {
        if viewcurrentType == viewTypeArray.last {
            viewDoneButtonClosure!(button)
        }else{
            if viewTypeArray.count == 2 && viewTypeArray.first == .PhoneNum {
                self.phoneNumTextField.isHidden = false
                self.phoneNumTextField.text = self.textField.text
                UIView.animate(withDuration: 0.3, delay: 0.3, options: .allowAnimatedContent, animations: {
                    self.topConstraint?.update(offset: 0)
                    self.layoutIfNeeded()
                }, completion: { (finise) in
                    
                })
//                UIView.animate(withDuration: 1, animations: {
//                    
//                })
            }
            textField.text = ""
            if let index = viewTypeArray.index(of: viewcurrentType) {
                viewcurrentType = viewTypeArray[index + 1]
                indicatorSelectIndex(index: index + 1)
                switch viewcurrentType {
                case .Password:
                    hintLable.text = "请输入密码"
                    textField.isSecureTextEntry = true
                case .VerificationCode:
                    hintLable.text = "请输入验证码"
                default:
                    hintLable.text = "请输入手机号"

                }
            }
            
        }
    }
    
    
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let totalLength = (textField.text?.characters.count)! - range.length + string.characters.count
            switch viewcurrentType {
            case .PhoneNum:
                let attDic = [NSKernAttributeName:3] as [String : Any]
                textField.attributedText = NSAttributedString.init(string: textField.text!, attributes: attDic)
                if totalLength == 11 {
                    if viewcurrentType == viewTypeArray.last {
                        nextButton.setImage(UIImage.init(named: "nextButton_done"), for: .normal)

                    }else{
                        nextButton.setImage(UIImage.init(named: "nextButton_next"), for: .normal)

                    }
                }else if totalLength > 11 {
                    return false
                }
            case .VerificationCode:
                if totalLength == 6 {
                    if viewcurrentType == viewTypeArray.last {
                        nextButton.setImage(UIImage.init(named: "nextButton_done"), for: .normal)
                        
                    }else{
                        nextButton.setImage(UIImage.init(named: "nextButton_next"), for: .normal)
                        
                    }
                }else if totalLength > 6 {
                    return false
                }
                
            case .Password:
                if totalLength > 6 {
                    if viewcurrentType == viewTypeArray.last {
                        nextButton.setImage(UIImage.init(named: "nextButton_done"), for: .normal)
                        
                    }else{
                        nextButton.setImage(UIImage.init(named: "nextButton_next"), for: .normal)
                        
                    }
                }
                
            default: break
                
            }
        return  true
    }
}
