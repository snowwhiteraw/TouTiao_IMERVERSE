//
//  MenuViewController.swift
//  TouTiaoSK17.V2
//
//  Created by SeventeenK17 on 2021/6/25.
//

import UIKit

class MenuViewController: UIViewController {
    let menuIcon = ["square.and.pencil","message","qrcode.viewfinder","gearshape"]
    let menuLable = ["发布","消息","扫描","设置"]
    var personImageInit = UIImage(systemName: "person.circle")
    var personNameInit = "用户名字"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        configPersonImage()
        configPersonName()
        configMenu()
        configNC()

        // Do any additional setup after loading the view.
    }
    
   ////用户头像
    func configPersonImage()  {
        let personImage = UIImageView(image: personImageInit)
        personImage.frame = CGRect(x: 20, y: 90, width: 80, height: 80)
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleClick))
        personImage.addGestureRecognizer(singleTap)
        personImage.isUserInteractionEnabled = true
        self.view.addSubview(personImage)
    }
    
    //用户名字
    func configPersonName()  {
        let personName = UILabel(frame: CGRect(x: 120, y: 90, width: 150, height: 80))
        personName.text = personNameInit
        personName.adjustsFontSizeToFitWidth = true
        personName.font = UIFont.systemFont(ofSize: 20)
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleClick))
        personName.addGestureRecognizer(singleTap)
        personName.isUserInteractionEnabled = true
        self.view.addSubview(personName)
    }
    
    //菜单
    func configMenu()  {
        let tableView = UITableView(frame: CGRect(x: 0, y: 190, width: view.bounds.width, height: view.bounds.height-180), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView.init()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        extendedLayoutIncludesOpaqueBars = true;
                if #available(iOS 11.0, *) {
                    tableView.contentInsetAdjustmentBehavior = .never
                } else {
                    automaticallyAdjustsScrollViewInsets = false;
                };
//            tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 49, right: 0)
//                tableView.scrollIndicatorInsets = tableView.contentInset

        self.view.addSubview(tableView)
    }
    
    //导航栏【返回键】
    func configNC(){
        self.navigationController?.navigationBar.tintColor = UIColor.red
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: nil)
    }
    
    //视图将要显示
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
          
         //设置导航栏背景透明
         self.navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                                     for: .default)
         self.navigationController?.navigationBar.shadowImage = UIImage()
     }
      
     //视图将要消失
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
          
//         //重置导航栏背景
//         self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
//         self.navigationController?.navigationBar.shadowImage = nil
        
     }
    
    @objc func singleClick() {
        self.navigationController?.pushViewController(PersonHomeViewController(), animated: true)
        print("调用了personvc",self.navigationController)
//        self.present(HomeViewController(), animated: true, completion: nil)

    }

    
}
    extension MenuViewController: UITableViewDelegate,UITableViewDataSource{

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return menuLable.count


        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
            cell.accessoryType = .none
            cell.textLabel?.text =  menuLable[indexPath.row]
            cell.imageView?.image = UIImage(systemName: menuIcon[indexPath.row])?.withTintColor(.red,renderingMode: .alwaysOriginal)
            //自定义背景色
            cell.selectedBackgroundView = UIView()
            cell.selectedBackgroundView?.backgroundColor = .red
            return cell
            
        }
        
                
        //点击【发布】后侧边栏跳转
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.row == 0{
                self.navigationController?.pushViewController(FabuViewController(), animated:true )
            }
            //取消底色
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        
        
    }


