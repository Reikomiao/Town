//
//  RTownViewController.swift
//  Town
//
//  Created by 冯振玲 on 2017/5/25.
//  Copyright © 2017年 Reiko. All rights reserved.
//

import UIKit
import SDWebImage
import Kingfisher

class RTownViewController: RViewController,UITableViewDelegate,UITableViewDataSource{
  
    enum  SelectedType{
        case cityStory
        case venuebook
    }
    var viewControllers = [UIViewController]()
    var tableView: UITableView?
    var dataArray: Array = Array<AnyObject>()
    var iconDataArray : Array = Array<RTownCodeModel>()
    var selectedType : SelectedType = .cityStory

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
        setUpIconData()
        addSubViews()
        // Do any additional setup after loading the view.
    }

    
    func addSubViews(){
        view.backgroundColor = viewBGColor
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
        
        
        // 城市故事
        tableView = UITableView.init();
        view.addSubview(tableView!)
        tableView?.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(searchView.snp.bottom).offset(10)
        })
        tableView?.delegate = self;
        tableView?.dataSource = self;
        tableView?.register(UINib.init(nibName: "RTownCityStoryTableViewCell", bundle:nil), forCellReuseIdentifier:"RTownCityStoryTableViewCell");
        tableView?.register(UINib.init(nibName: "RTownLocationSetTableViewCell", bundle:nil), forCellReuseIdentifier:"RTownLocationSetTableViewCell");

        
        let hearderView = UIView.init()
        hearderView.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: 260)
        tableView?.tableHeaderView = hearderView;

        let scrollView = UIScrollView.init()
        hearderView.addSubview(scrollView)
        hearderView.backgroundColor = viewBGColor
        scrollView.snp.makeConstraints { (make) in
            make.left.right.top.right.equalTo(hearderView)
            make.height.equalTo(201)
        }

        let iconButtonWidth = 70
        let iconButtonHeight = 100

        var row = iconDataArray.count / 2 as Int
        let line = iconDataArray.count % 2 as Int
        if line != 0 {
            row = row + 1
        }
        scrollView.contentSize = CGSize.init(width: row * iconButtonWidth + 5, height: 200 + 1)
        scrollView.backgroundColor = viewBGColor
        for (index,value) in iconDataArray.enumerated() {
            let iconButton = UIButton.init(type: .custom)
            scrollView.addSubview(iconButton)
            iconButton.snp.makeConstraints({ (make) in
                make.size.equalTo(CGSize.init(width: iconButtonWidth, height: iconButtonHeight))
                make.top.equalTo(scrollView).offset(iconButtonHeight * (index / row) + (index / row))
                make.left.equalTo(scrollView).offset(iconButtonWidth * (index % row) + (index % row) - 1)
            })
           
            if index == 0 {
                iconButton.setImage(UIImage.init(named: "featured_icon"), for: .normal)
            }else{
                iconButton.sd_setImage(with: URL.init(string: imageDomain + value.iconBlue), for: .normal)
            }
            iconButton.imageEdgeInsets = UIEdgeInsets.init(top:0, left:  15, bottom: 50, right: 10)
            let titleLabel = UILabel.init()
            iconButton.addSubview(titleLabel)
            titleLabel.snp.makeConstraints({ (make) in
                make.left.right.equalTo(iconButton)
                make.bottom.equalTo(iconButton).offset(-15)
            })
            titleLabel.text = value.title
            titleLabel.textColor = UIColor.gray
            titleLabel.font = UIFont.systemFont(ofSize: 12)
            titleLabel.textAlignment = .center
            iconButton.backgroundColor = UIColor.white
            
            
        }
        
        // 城市故事地点集合
        let segmentedControl = UISegmentedControl.init(items: ["城市故事","地点集"])
        hearderView.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { (make) in
            make.left.equalTo(hearderView).offset(10)
            make.right.equalTo(hearderView).offset(-10)
            make.top.equalTo(scrollView.snp.bottom).offset(15)
            make.height.equalTo(30)
        }
        let selectedTextAttributes = [NSForegroundColorAttributeName: UIColor.black];
        let normalTextAttributes = [NSForegroundColorAttributeName: UIColor.gray];

        segmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        segmentedControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        segmentedControl.tintColor = UIColor.RGBColor(red: 249, green: 249, blue: 249, alpha: 1)
        segmentedControl.setBackgroundImage(UIImage.init(named: "segmentedControl_selected"), for: .selected, barMetrics: .default)
        segmentedControl.setBackgroundImage(UIImage.init(named: "segmentedControl_normal"), for: .normal, barMetrics: .default)
        segmentedControl.addTarget(self, action: #selector(actionSegmentedControl(_ :)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
    
        
        
        
    }
    // 城市故事地点集的点击事情
    func actionSegmentedControl(_ segement:UISegmentedControl){
        if segement.selectedSegmentIndex == 0{
            setUpData()
        } else if segement.selectedSegmentIndex == 1{
            setUpLocationSetData()
        }
        
    }
    func setUpData() {
        dataArray.removeAll()
        selectedType = .cityStory
        if let  jsonBundlePath = Bundle.main.path(forResource: "JSONResources", ofType: "bundle"){
            let jsonBundle = Bundle.init(path: jsonBundlePath)
            if let townJsonPath = jsonBundle?.path(forResource: "Home_freshFabulas", ofType: "json") {
                
                do {
                    let jsonData =  try Data.init(contentsOf: URL.init(fileURLWithPath: townJsonPath))
                    if let data = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? Dictionary<String,AnyObject> {
                        
                        let result = data["result"] as! [String: Any]
                        let rows = result["rows"] as! [[String: Any]]
                        for dic in rows {
                            let model = RTownCityStoryModel.init()
                            let fabula = dic["fabula"] as! [String: Any]
                            let pages = fabula["pages"] as![[String: Any]]
                            let text = pages[0]["text"] as! [String]
                            model.name = text[0] as String
                            let images = pages[0]["images"] as![[String: Any]]
                            let createdAt = images[0]["createdAt"] as! Double;
                            model.time = timestampTurnTime(createdAt)
                            model.bgThumbnailImage = images[0]["thumbnail"] as! String;
                            model.bgoriginalImage = images[0]["original"] as! String;
                            let creater = fabula["creator"] as! [String: Any]
                            model.auther = creater["name"] as! String
                            let avatar = creater["avatar"] as! [String: Any]
                            model.autherImage = avatar["original"] as! String
                            let venue = fabula["venue"] as! [String: Any]
                            model.address = venue["address"] as! String
                            model.likeNum = "\(fabula["likersCount"] as! Int)"
                            model.isLike = fabula["isLike"] as! Bool
                            model.seeNum = "\(fabula["readTimes"] as! Int)"
                            dataArray.append(model)
                        }
                        tableView?.reloadData()
                        
                    }
                }catch(let error) {
                    print(error)
                }
                


            }
        }
    }
    
    func setUpIconData(){
        if let  jsonBundlePath = Bundle.main.path(forResource: "JSONResources", ofType: "bundle"){
            let jsonBundle = Bundle.init(path: jsonBundlePath)
            if let townJsonPath = jsonBundle?.path(forResource: "Home_iconPage", ofType: "json") {
                
                do {
                    let jsonData =  try Data.init(contentsOf: URL.init(fileURLWithPath: townJsonPath))
                    if let data = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? Dictionary<String,AnyObject> {
                        
                        let result = data["result"] as! [String: Any]
                        let categories = result["categories"] as! [[String: Any]]
                        // 拼接精选model
                        let featuredModel = RTownCodeModel.init()
                        featuredModel.title = "精选"
                        iconDataArray.append(featuredModel)
                        
                        for dic in categories {
                            let model = RTownCodeModel.init()
                            model.code = dic["code"] as! String
                            model.title = dic["title"] as! String
                            let icons = dic["icons"] as! [String: Any]
                            model.iconBlue = icons["blue"] as! String
                            model.iconWhite = icons["white"] as! String
                            iconDataArray.append(model)
                        }
                       


                    }
                }catch(let error) {
                    print(error)
                }
                
                
                
            }
        }

    }
    func setUpLocationSetData() {
        dataArray.removeAll()
        selectedType = .venuebook
        if let  jsonBundlePath = Bundle.main.path(forResource: "JSONResources", ofType: "bundle"){
            let jsonBundle = Bundle.init(path: jsonBundlePath)
            if let townJsonPath = jsonBundle?.path(forResource: "Home_venuebook", ofType: "json") {
                
                do {
                    let jsonData =  try Data.init(contentsOf: URL.init(fileURLWithPath: townJsonPath))
                    if let data = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? Dictionary<String,AnyObject> {
                        
                        let result = data["result"] as! [String: Any]
                        let rows = result["rows"] as! [[String: Any]]
                        for dic in rows {
                            let model = RTownLocationSetModel.init()
                            let venuebook = dic["venuebook"] as! [String: Any]
                            model.name = venuebook["name"] as! String
                            let creator = venuebook["creator"] as! [String: Any]
                            let avatar = creator["avatar"] as! [String: Any]
                            model.autherImage = avatar["original"] as! String
                            let coverInfo = venuebook["coverInfo"] as! [[String: Any]]
                            model.coverImage = coverInfo[0]["original"] as! String
                            model.seeNum = "\(venuebook["venueCount"] as! Int)"
                            dataArray.append(model)
                        
                        }
                        tableView?.reloadData()
                        
                    }
                }catch(let error) {
                    print(error)
                }
                
                
                
            }
        }
    }

  
    // 时间戳转时间
    func timestampTurnTime (_ timestamp:Double) -> String {
        let timeStr = "\(timestamp)"
        let index = timeStr.index(timeStr.endIndex, offsetBy: -5)
        let time = timeStr.substring(to: index)
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy.MM.dd hh:mm"
        let date = Date.init(timeIntervalSince1970: Double(time)!)
        return formatter.string(from: date)
    }
    
    func actionAreaButton(_ button:UIButton){
    
    
    }
    func actionNearbyButton(_ button:UIButton){
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch selectedType {
        case .cityStory:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RTownCityStoryTableViewCell", for: indexPath) as! RTownCityStoryTableViewCell
            if let model = dataArray[indexPath.row] as? RTownCityStoryModel{
                cell.cityStoryModel = model;
            }
            return cell

        case .venuebook:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RTownLocationSetTableViewCell", for: indexPath) as! RTownLocationSetTableViewCell
            if let model = dataArray[indexPath.row] as? RTownLocationSetModel{
                cell.locationSetModel = model;
            }
            return cell
            
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count;
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch selectedType {
        case .cityStory:
            let model = dataArray[indexPath.row] as! RTownCityStoryModel
            let detailVC = RTownDetailViewController()
            detailVC.coverImage = model.bgoriginalImage
            superNavigationController().pushViewController(detailVC, animated: true)
            
//            navigationController?.pushViewController(detailVC, animated: true)
            
        case .venuebook:
            let model = dataArray[indexPath.row] as! RTownLocationSetModel
            let detailVC = RTownDetailViewController()
            detailVC.coverImage = model.coverImage;
            navigationController?.pushViewController(detailVC, animated: true)
        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch selectedType {
        case .cityStory:
            return screenWidth + 10

        case .venuebook:
            return screenWidth / 2

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
