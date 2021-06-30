//
//  HomeViewController.swift
//  TouTiaoSK17.V2
//
//  Created by SeventeenK17 on 2021/6/26.
//

import UIKit
import MJRefresh

class PersonHomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var personImageInit = UIImage(systemName: "person.circle")
    var personNameInit = "用户名字"
    
    lazy var table1 = configTable(tableName: 1)
    lazy var table2 = configTable(tableName: 2)
    lazy var table3 = configTable(tableName: 3)
    lazy var table4 = configTable(tableName: 4)
    lazy var table5 = configTable(tableName: 5)
    lazy var table6 = configTable(tableName: 6)
    
    func configTable(tableName:Int) -> UITableView {
        let tableName = UITableView()
        tableName.delegate = self
        tableName.dataSource = self
        tableName.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
        tableName.tableFooterView = UIView.init()
        if #available(iOS 13.0, *) {
            tableName.automaticallyAdjustsScrollIndicatorInsets = false
        }
        return tableName
    }
    
    lazy var headerView: UIView = {
        let tmpView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 230))
        tmpView.backgroundColor = UIColor.white
        let imgView = UIImageView.init(image: UIImage.init(named: "TTBackground"))
//        imgView.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 150)
        imgView.contentMode = UIView.ContentMode.top
        imgView.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        imgView.alpha = 0.3
        tmpView.addSubview(imgView)
        imgView.center = tmpView.center
        tmpView.clipsToBounds = true
        //用户头像
        let personImage = UIImageView(image: personImageInit)
        personImage.frame = CGRect(x: 20, y: 140, width: 80, height: 80)
        tmpView.addSubview(personImage)
        
        //用户名字
        let personName = UILabel(frame: CGRect(x: 120, y: 120, width: 150, height: 80))
        personName.text = personNameInit
        personName.adjustsFontSizeToFitWidth = true
        personName.font = UIFont.systemFont(ofSize: 20)
        tmpView.addSubview(personName)
        
        //用户数据
        tmpView.addSubview(personData(Data: "头条：0", x: 120))
        tmpView.addSubview(personData(Data: "获赞：0", x: 180))
        tmpView.addSubview(personData(Data: "粉丝：0", x: 240))
        tmpView.addSubview(personData(Data: "关注：0", x: 300))
        
        
        return tmpView
    }()
    
    func personData(Data:String,x:CGFloat) -> UILabel {
        let personData = UILabel(frame: CGRect(x: x, y: 155, width: 50, height: 80))
        personData.text = Data
        personData.textColor = .darkGray
        personData.adjustsFontSizeToFitWidth = true
        personData.font = UIFont.systemFont(ofSize: 15)
        return personData
    }
    
    lazy var segmentItem: PageBar = {
        let tmpSeg = PageBar.init(frame: CGRect.init(x: 0, y: 230, width: UIScreen.main.bounds.width, height: 44))
        tmpSeg.backgroundColor = UIColor.white
        return tmpSeg
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view, typically from a nib.
        title = "个人中心"
        navigationController?.navigationBar.isTranslucent = false
        //加入分页VC，可直接使用，也可继承。
        let pageVC = PageViewController.init(headView: headerView, hoverView: segmentItem, subViewCount:6)        //1
        addChild(pageVC)
        view.addSubview(pageVC.view)
        pageVC.configTableView(subViews: [table1,table2,table3,table4,table5,table6], selectIndex: 0)

        //headerView，segment置前
        //加入headerView
        self.view.addSubview(headerView)
        //加入segment
        let titles = ["头条","粉丝","关注","收藏","评论","点赞"]
        segmentItem.selectedItemIndex = 0
        segmentItem.setTitles(titles)
        self.view.addSubview(segmentItem)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
//        cell?.textLabel?.text = String.init(format: "%d", indexPath.row)
        cell?.textLabel?.text = ""
        return cell ?? UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }


    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


