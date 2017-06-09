//
//  RTownViewController.swift
//  Town
//
//  Created by 冯振玲 on 2017/5/25.
//  Copyright © 2017年 Reiko. All rights reserved.
//

import UIKit



class RTownViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    var viewControllers = [UIViewController]()
    var tableView: UITableView?
    let dataArray: Array = Array<AnyObject>()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setUpData()
        // Do any additional setup after loading the view.
    }

    
    func addSubViews(){
        let searchView = UIView.init()
        view.addSubview(searchView)
        searchView.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(10);
            make.right.equalTo(view).offset(-10);
            make.top.equalTo(view).offset(12)
            make.height.equalTo(30);
            
        }
       
        // 选择地区的按钮
        let areaButton = UIButton.init(type: .custom)
        searchView.addSubview(areaButton)
        areaButton.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(searchView)
            make.width.equalTo(65)
        }
//        areaButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        areaButton.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0)
        areaButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -50)
        areaButton.setTitle("北京", for: .normal)
        areaButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        areaButton.setImage(UIImage.init(named: "area_triangle"), for: .normal)
        areaButton.setBackgroundImage(UIImage.init(named: "area_button_bg"), for: .normal)
        areaButton.setTitleColor(UIColor.black, for: .normal)
        areaButton.addTarget(self, action: #selector(actionAreaButton(_:)), for: .touchUpInside)
        // 附近按钮
        let nearbyButton = UIButton.init(type: .custom)
        searchView.addSubview(nearbyButton)
        nearbyButton.snp.makeConstraints { (make) in
            make.right.top.bottom.equalTo(searchView)
            make.width.equalTo(55)
        }
        nearbyButton.setTitle("附近", for: .normal)
        nearbyButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        nearbyButton.setTitleColor(UIColor.black, for: .normal)
        nearbyButton.addTarget(self, action: #selector(actionNearbyButton(_:)), for: .touchUpInside)
        nearbyButton.setBackgroundImage(UIImage.init(named: "nearby_button_bg"), for: .normal)
        
        
        // 搜索框
        let searchTextField = UITextField.init()
        searchView.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { (make) in
            make.left.equalTo(areaButton.snp.right)
            make.top.bottom.equalTo(searchView)
            make.right.equalTo(nearbyButton.snp.left).offset(-5)
        }
        let leftView = UIView.init()
        leftView.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        searchTextField.leftView = leftView

        let leftImageView = UIImageView.init(image: UIImage.init(named: "area_search"))
        leftImageView.frame = CGRect.init(x: (leftView.frame.size.width - 13) / 2, y: (leftView.frame.size.height - 13) / 2, width: 13, height: 13)
        leftView.addSubview(leftImageView)
        leftImageView.contentMode = .scaleAspectFit
        searchTextField.placeholder = "搜索地点、地点集"
        searchTextField.font = UIFont.systemFont(ofSize: 13)
        searchTextField.backgroundColor = UIColor.RGBColor(red: 255, green: 223, blue: 88, alpha: 1)
        searchTextField.leftViewMode = .always
        
        tableView = UITableView.init();
        view.addSubview(tableView!)
        tableView?.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(searchView.snp.bottom).offset(10)
        })
        tableView?.delegate = self;
        tableView?.dataSource = self;
        
        
    }
    
    func setUpData() {
        
        do {
           let jsonData =  try Data.init(contentsOf: URL.init(string: jsonPath!)!)
            do {
               let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                let result = json as! Dictionary<String,Any>
                
                
            } catch let error  {
                print(error.localizedDescription)
            }
        } catch let extensen {
            print(extensen.localizedDescription)
        }
        
        
        
        
        
        
    }
    
    func addTableViewHeaderView(){
        
    }
    func actionAreaButton(_ button:UIButton){
    
    
    }
    func actionNearbyButton(_ button:UIButton){
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count;
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
