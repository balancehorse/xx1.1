//
//  DetailViewController.swift
//  xx1.0
//
//  Created by 小嘉仪 on 2019/1/29.
//  Copyright © 2019 小嘉仪. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    //测试用账本
    var books = ["吃饭","出行","购物","社交"]
    
    //账本金额
    var moneyID = ["500","500","400","300",]
    
    //图片名称
    var imgName = ["吃饭","出行","购物","社交"]
    
    let contents:Dictionary<String,[String]> =
        ["03月18日 星期一":["购物"],
         "03月19日 星期二":["吃饭","出行","购物","交际"],
         "03月20日 星期三":["吃饭","吃饭"]]
    var keys:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置navigation的titile
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        // 自定义view设置title
        let titleLabel = UILabel(frame: CGRect(x:0, y:0, width:40, height:40))
        titleLabel.text = "明细"
        titleLabel.textColor = UIColor.black
        self.navigationItem.titleView = titleLabel
        
        navigationController?.isNavigationBarHidden = false
        // 把字典里的key拿出来放到一个数组中，备用，作为章节的标题
        keys = contents.keys.sorted()
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 60, width: UIScreen.main.bounds.width
            , height: UIScreen.main.bounds.height), style: .plain)
        //        tableView.backgroundColor = UIColor.white;
        //去掉没有数据显示部分多余的分隔线
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        //将分隔线offset设为零，即将分割线拉满屏幕
        tableView.separatorInset = UIEdgeInsets(top: 45, left: 45, bottom: 45, right: 0)
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        
        //给TableView添加表头页眉
        let headerView:UIView = UIView(frame:
            CGRect(x:0, y:0, width:tableView.frame.size.width, height:60))
        let headerlabel:UILabel = UILabel(frame: CGRect(x: 10, y: 5, width: tableView.frame.size.width, height: 20))
        headerlabel.textColor = UIColor.darkGray
        headerlabel.font = UIFont.systemFont(ofSize: 13)
        headerlabel.text = "2019年          预设（元）          支出（元）          剩余（元）"
        headerView.addSubview(headerlabel)
        
        let selectMonthBtn:UIButton = UIButton(frame: CGRect(x: 10, y: 28, width: 50, height: 30))
        //        selectMonthBtn.backgroundColor = UIColor.lightGray
        selectMonthBtn.setTitle("04月", for: .normal)
        selectMonthBtn.setTitleColor(UIColor.black, for: .normal)
        headerView.addSubview(selectMonthBtn)
        
        self.view.addSubview(headerView)
        
    }
    //MARK: UITableViewDataSource
    //MARK: 章节的个数
    func numberOfSections(in tableView: UITableView) -> Int {
        return keys.count
    }
    //MARK: 某一章节cell个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arr = contents[keys[section]]
        return (arr?.count)!
    }
    //MARK: 初始化cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "indexsCellId")
        if cell==nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "indexsCellId")
        }
        let arr = contents[keys[indexPath.section]]
        cell?.textLabel?.text = arr?[indexPath.row]
        //        cell?.detailTextLabel?.text = "¥  " + moneyID[indexPath.row]
        cell?.imageView?.image = UIImage(named: imgName[indexPath.row])
        cell?.imageView?.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        cell?.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        cell?.accessoryView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 15))
        let costlabel = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 15))
        costlabel.text = "-100"
        costlabel.textColor = UIColor.darkGray
        costlabel.font = UIFont.systemFont(ofSize: 15)
        costlabel.sizeToFit()
        costlabel.textAlignment = NSTextAlignment.center
        cell?.accessoryView?.addSubview(costlabel)
        
        
        
        return cell!
    }
    //MARK: UITableViewDelegate
    // 设置cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    //MARK: 每一个章节的标题
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.init(red: 237/255.0, green: 237/255.0, blue: 237/255.0, alpha: 1)
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 0, width: 150, height: 20))
        titleLabel.text = keys[section]
        titleLabel.textColor = UIColor.darkGray
        titleLabel.sizeToFit()
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        let costlabel = UILabel(frame: CGRect(x: tableView.frame.size.width-75, y: 0, width: 75, height: 20))
        // 一天内共花了多少钱
        costlabel.text = "支出：130"
        costlabel.textColor = UIColor.darkGray
        costlabel.sizeToFit()
        costlabel.font = UIFont.systemFont(ofSize: 13)
        //      titleLabel.center = CGPoint(x: self.view.frame.width/2, y: 20)
        headerView.addSubview(titleLabel)
        headerView.addSubview(costlabel)
        return headerView
        //        var label1 = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        //        label1.text = keys[section]
        //        return label1
    }
    
}




