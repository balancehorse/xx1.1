//
//  chartViewControllerPie.swift
//  xx1.0
//
//  Created by majunheng on 2019/4/12.
//  Copyright © 2019 小嘉仪. All rights reserved.
//

import UIKit
import AAInfographics

class chartViewControllerPie: UIViewController {

    let chartViewWidth:CGFloat = UIScreen.main.applicationFrame.size.width
    let chartViewHeight:CGFloat = UIScreen.main.applicationFrame.size.height - 380
    var aaChartView = AAChartView()
    var chartModel = AAChartModel()
        .chartType(.column)//图表类型
        .title("花费情况")//图表主标题
        .subtitle("2020年09月18日")//图表副标题
        .inverted(false)//是否翻转图形
        .yAxisTitle("花费金额")// Y 轴标题
        .legendEnabled(true)//是否启用图表的图例(图表底部的可点击的小圆点)
        .tooltipValueSuffix("摄氏度")//浮动提示框单位后缀
        .categories(["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                     "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
        .colorsTheme(["#fe117c","#ffc069","#06caf4","#7dffc0"])//主题颜色数组
        .series([
            AASeriesElement()
                .name("吃饭")
                .data([7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6])
                .toDic()!,
            AASeriesElement()
                .name("出行")
                .data([0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5])
                .toDic()!,
            AASeriesElement()
                .name("购物")
                .data([0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0])
                .toDic()!,
            AASeriesElement()
                .name("社交")
                .data([3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8])
                .toDic()!,])
    
    override func viewDidLoad() {
        //设置navigation的titile
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        // 自定义view设置title
        let titleLabel = UILabel(frame: CGRect(x:0, y:0, width:40, height:40))
        titleLabel.text = "图表"
        titleLabel.textColor = UIColor.black
        self.navigationItem.titleView = titleLabel
        
        let items = ["7天","30天","365天"]
        let segmented = UISegmentedControl(items: items)
        //设置中心位置
        segmented.center = self.view.center
        segmented.frame = CGRect(x: 75, y: 10, width: 220, height: 22)
        
        //设置默认选中的索引,索引从0开始
        segmented.selectedSegmentIndex = 2
        //添加监听事件
        segmented.addTarget(self, action: #selector(ChartViewController.SegmentedChanged(_:)), for: .valueChanged)
        //添加文字选项
        //        segmented.insertSegment(withTitle: "option D", at: 4, animated: true)
        //        //添加图片选项(withRenderingMode(.alwaysOriginal)设置图片颜色为原颜色，而不是系统默认的蓝色)
        //        segmented.insertSegment(with: UIImage(named:"Icon")?.withRenderingMode(.alwaysOriginal), at: 1, animated: true)
        //        //移除指定选项
        //        segmented.removeSegment(at: 1, animated: true)
        //移除全部选项
        //        segmented.removeAllSegments()
        //修改选项颜色
        segmented.tintColor = UIColor(red: 0/255.0, green: 113/255.0, blue: 221/255.0, alpha: 1)
        //        segmented.setTitle("newName", forSegmentAt: 3)
        //修改选项图片
        //        segmented.setImage(UIImage(named: "newIcon"), forSegmentAt: 1)
        //修改选项内容偏移位置
        //        segmented.setContentOffset(CGSize(width: 5, height: 5), forSegmentAt: 1)
        //添加到视图中
        self.view.addSubview(segmented)
        
        
        
        //设置左右两边的按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"柱图"), style: .plain, target: self, action: #selector(self.leftClick))
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor.gray
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"分享"), style: .plain, target: self, action: #selector(self.rightClick))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.gray
        
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        aaChartView.frame = CGRect(x:0,y:32,width:chartViewWidth,height:chartViewHeight)
        self.view.addSubview(aaChartView)
        aaChartView.aa_drawChartWithChartModel(chartModel)
        
        //创建下半部分view
        
    }
    @objc func rightClick()->Void {
      
        
    }
    @objc func leftClick()->Void {
        //实例化一个将要跳转的viewController
        let addBook = ChartViewController()
        //跳转
        self.navigationController?.pushViewController(addBook , animated: true)
        
    }
    @objc func SegmentedChanged(_ segmented:UISegmentedControl)
    {
        if segmented.selectedSegmentIndex == 0 {
            chartModel = AAChartModel()
                .chartType(.column)//图表类型
                .title("花费情况")//图表主标题
                .subtitle("2020年09月18日")//图表副标题
                .inverted(false)//是否翻转图形
                .yAxisTitle("花费金额")// Y 轴标题
                .legendEnabled(true)//是否启用图表的图例(图表底部的可点击的小圆点)
                .tooltipValueSuffix("摄氏度")//浮动提示框单位后缀
                .categories(["Mon", "Tue", "Wed", "Thr", "Fri", "Sat",
                             "Sun"])
                .colorsTheme(["#fe117c","#ffc069","#06caf4","#7dffc0"])//主题颜色数组
                .series([
                    AASeriesElement()
                        .name("吃饭")
                        .data([7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2])
                        .toDic()!,
                    AASeriesElement()
                        .name("出行")
                        .data([0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8])
                        .toDic()!,
                    AASeriesElement()
                        .name("购物")
                        .data([0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6])
                        .toDic()!,
                    AASeriesElement()
                        .name("社交")
                        .data([3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0])
                        .toDic()!,])
            viewWillAppear(true)
        }
        if segmented.selectedSegmentIndex == 1 {
            chartModel = AAChartModel()
                .chartType(.column)//图表类型
                .title("花费情况")//图表主标题
                .subtitle("2020年09月18日")//图表副标题
                .inverted(false)//是否翻转图形
                .yAxisTitle("花费金额")// Y 轴标题
                .legendEnabled(true)//是否启用图表的图例(图表底部的可点击的小圆点)
                .tooltipValueSuffix("摄氏度")//浮动提示框单位后缀
                .categories(["第一周", "第二周", "第三周", "第四周"])
                .colorsTheme(["#fe117c","#ffc069","#06caf4","#7dffc0"])//主题颜色数组
                .series([
                    AASeriesElement()
                        .name("吃饭")
                        .data([7.0, 6.9, 9.5, 14.5])
                        .toDic()!,
                    AASeriesElement()
                        .name("出行")
                        .data([0.2, 0.8, 5.7, 11.3])
                        .toDic()!,
                    AASeriesElement()
                        .name("购物")
                        .data([0.9, 0.6, 3.5, 8.4])
                        .toDic()!,
                    AASeriesElement()
                        .name("社交")
                        .data([3.9, 4.2, 5.7, 8.5])
                        .toDic()!,])
            viewWillAppear(true)
        }
        if segmented.selectedSegmentIndex == 2 {
            chartModel = AAChartModel()
                .chartType(.column)//图表类型
                .title("花费情况")//图表主标题
                .subtitle("2020年09月18日")//图表副标题
                .inverted(false)//是否翻转图形
                .yAxisTitle("花费金额")// Y 轴标题
                .legendEnabled(true)//是否启用图表的图例(图表底部的可点击的小圆点)
                .tooltipValueSuffix("摄氏度")//浮动提示框单位后缀
                .categories(["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                             "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
                .colorsTheme(["#fe117c","#ffc069","#06caf4","#7dffc0"])//主题颜色数组
                .series([
                    AASeriesElement()
                        .name("吃饭")
                        .data([7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6])
                        .toDic()!,
                    AASeriesElement()
                        .name("出行")
                        .data([0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5])
                        .toDic()!,
                    AASeriesElement()
                        .name("购物")
                        .data([0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0])
                        .toDic()!,
                    AASeriesElement()
                        .name("社交")
                        .data([3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8])
                        .toDic()!,])
            viewWillAppear(true)
            
        }
        //打印选项的索引
        print("index is \(segmented.selectedSegmentIndex)")
        //打印选择的文字
        print("option is \(String(describing: segmented.titleForSegment(at: segmented.selectedSegmentIndex)))")//将获得值转为String类型
    }
    
}
