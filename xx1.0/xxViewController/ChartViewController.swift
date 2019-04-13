//
//  ChartViewController.swift
//  xx1.0
//
//  Created by 小嘉仪 on 2019/1/29.
//  Copyright © 2019 小嘉仪. All rights reserved.
//

import UIKit
import AAInfographics

extension UIColor {
    
    // Hex String -> UIColor
    convenience init(hexString: String) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }}


class ChartViewController: UIViewController {
    
    let backgView = UIView()
    let items = ["7天","30天","365天"]
    var segmented = UISegmentedControl()
    var ChartBool :Bool = true
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
        .tooltipValueSuffix("元")//浮动提示框单位后缀
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
    //  pie图
    var chartModel2 = AAChartModel()
        .chartType(.pie)
        .backgroundColor("#ffffff")
        .title("开销情况")
        .subtitle("virtual data")
        .dataLabelEnabled(true)//是否直接显示扇形图数据
        .yAxisTitle("℃")
        .series(
            [
                AASeriesElement()
                    .name("Language market shares")
                    .innerSize("20%")//内部圆环半径大小占比(内部圆环半径/扇形图半径),
                    .allowPointSelect(false)
                    .data([
                        ["吃饭"  ,124],
                        ["购物",400],
                        ["社交",120],
                        ["出行",56],
                        
                        ])
                    .toDic()!,
            ]
    )
    
    override func viewDidLoad() {
        //设置navigation的titile
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        // 自定义view设置title
        let titleLabel = UILabel(frame: CGRect(x:0, y:0, width:40, height:40))
        titleLabel.text = "图表"
        titleLabel.textColor = UIColor.black
        self.navigationItem.titleView = titleLabel
        
        segmented = UISegmentedControl(items: items)
        //设置中心位置
        segmented.center = self.view.center
        segmented.frame = CGRect(x: 75, y: 10, width: 220, height: 22)
        
        //设置默认选中的索引,索引从0开始
        segmented.selectedSegmentIndex = 2
        //添加监听事件
        segmented.addTarget(self, action: #selector(ChartViewController.SegmentedChanged(_:)), for: .valueChanged)
        //修改选项颜色
        segmented.tintColor = UIColor(red: 0/255.0, green: 113/255.0, blue: 221/255.0, alpha: 1)
        //添加到视图中
        self.view.addSubview(segmented)
 
        
        
        //设置左右两边的按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"饼图"), style: .plain, target: self, action: #selector(self.leftClick))
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor.gray
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"分享"), style: .plain, target: self, action: #selector(self.rightClick))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.gray
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        aaChartView.frame = CGRect(x:0,y:32,width:chartViewWidth,height:chartViewHeight)
        self.view.addSubview(aaChartView)
        
        if ChartBool{
        aaChartView.aa_drawChartWithChartModel(chartModel)
        }else{
            aaChartView.aa_drawChartWithChartModel(chartModel2)
        }
        //创建下半部分view
        showSecondView()
    }
    
    func showSecondView() -> Void {

        for v in backgView.subviews{
            v.removeFromSuperview()
        }
        var imgArr = ["吃饭","社交","出行","购物"]
        var booksArr = ["吃饭","社交","出行","购物"]
        var percentArr = [0.6,0.75,0.8,0.5]
        var costArr = ["200","400","600","350"]
        var costPerArr = ["60%","75%","80%","50%"]
        var colorArr = ["#fe117c","#ffc069","#06caf4","#7dffc0"]
        backgView.frame = CGRect(x: 0, y: 300, width: UIScreen.main.applicationFrame.size.width, height: 400)
        if ChartBool{
        backgView.backgroundColor = UIColor(red: 184/255.0, green: 184/255.0, blue: 173/255.0, alpha: 0.5)
        let titleLabel = UILabel.init(frame: CGRect(x: 5, y: 2, width: 100, height: 17))
        titleLabel.text = "开支详情"
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = UIColor(red: 68/255.0, green: 68/255.0, blue: 68/255.0, alpha: 1)
        backgView.addSubview(titleLabel)
        self.view.addSubview(backgView)
        for index in 0..<4{
            let backgroundView = UIView.init(frame: CGRect(x: 0 , y: 20 + index * 50, width: 475, height: 50))
            backgroundView.backgroundColor = UIColor.white
            let lineView =  UIView.init(frame: CGRect(x: 45 , y: 20 + index * 50, width: 475, height: 1))
            lineView.backgroundColor = UIColor(red: 184/255.0, green: 184/255.0, blue: 173/255.0, alpha: 0.75)
            let imgView = UIImageView.init(frame: CGRect(x: 18 , y: 30 + index*50, width: 28, height: 28))
            imgView.image = UIImage(named: imgArr[index])
            let bookName = UILabel.init(frame: CGRect(x: 56, y: 27 + index * 50, width: 50, height: 20))
            bookName.text = booksArr[index]
            bookName.font = UIFont.systemFont(ofSize: 14)
            
            //生成进度条
            let balanceView = UIProgressView.init(frame: CGRect(x: 58, y: 57 + index * 50, width: Int(UIScreen.main.applicationFrame.size.width/1.35), height: 15))
            
            balanceView.progress = Float(percentArr[index])
            balanceView.progressTintColor = UIColor.init(red: 34/255.0, green: 162/255.0, blue: 221/255.0, alpha: 1) //进度颜色
            balanceView.trackTintColor = UIColor.init(red: 184/255.0, green: 184/255.0, blue: 173/255.0, alpha: 1) //剩余进度颜色
            balanceView.layer.masksToBounds = true
            balanceView.layer.cornerRadius = 2.5
            balanceView.transform = CGAffineTransform(scaleX: 1.0, y: 3.0)
            
            let costMoney = UILabel.init(frame: CGRect(x: 340, y: 27 + index * 50, width: 50, height: 20))
            costMoney.text = costArr[index]
            costMoney.font = UIFont.systemFont(ofSize: 14)
            costMoney.textColor = UIColor.init(red: 111/255.0, green: 111/255.0, blue: 111/255.0, alpha: 1)
            
            let costPercent = UILabel.init(frame: CGRect(x: 340, y: 48 + index * 50, width: 50, height: 20))
            costPercent.text = costPerArr[index]
            costPercent.font = UIFont.systemFont(ofSize: 14)
            costPercent.textColor = UIColor.init(red: 111/255.0, green: 111/255.0, blue: 111/255.0, alpha: 1)
            
            backgView.addSubview(backgroundView)
            if index != 0{
                backgView.addSubview(lineView)}
            backgView.addSubview(imgView)
            backgView.addSubview(bookName)
            backgView.addSubview(balanceView)
            backgView.addSubview(costMoney)
            backgView.addSubview(costPercent)
            }}
        else{
            backgView.backgroundColor = UIColor.white
            for index in 0..<4{
                let blockView = UIView.init(frame: CGRect(x: 20 , y: 15 + index * 30, width: 10, height: 22))
                blockView.backgroundColor = UIColor.init(hexString: costPerArr[index])
                
                
                let bookName = UILabel.init(frame: CGRect(x: 40, y: 23 + index * 30, width: 50, height: 20))
                bookName.text = booksArr[index]
                bookName.font = UIFont.systemFont(ofSize: 14)
                
                let costPercent = UILabel.init(frame: CGRect(x: 75, y: 23 + index * 30, width: 50, height: 20))
                costPercent.text = costPerArr[index]
                costPercent.font = UIFont.systemFont(ofSize: 14)
                costPercent.textColor = UIColor.init(red: 111/255.0, green: 111/255.0, blue: 111/255.0, alpha: 1)
                backgView.addSubview(blockView)
                backgView.addSubview(costPercent)
                backgView.addSubview(bookName)
            }
        }
        return
    }
    @objc func rightClick()->Void {
     
        
    }
    @objc func leftClick()->Void {
        if ChartBool{
            ChartBool = false
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"柱图"), style: .plain, target: self, action: #selector(self.leftClick))
            navigationItem.leftBarButtonItem?.tintColor = UIColor.gray
            segmented.selectedSegmentIndex = 2
            SegmentedChanged(segmented)
        }else{ ChartBool = true
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"饼图"), style: .plain, target: self, action: #selector(self.leftClick))
            navigationItem.leftBarButtonItem?.tintColor = UIColor.gray
            segmented.selectedSegmentIndex = 2
            SegmentedChanged(segmented)
        }
        
        viewWillAppear(true)
        
    }
    @objc func SegmentedChanged(_ segmented:UISegmentedControl)
    {
        if ChartBool {
        if segmented.selectedSegmentIndex == 0 {
            chartModel = AAChartModel()
                .chartType(.column)//图表类型
                .title("花费情况")//图表主标题
                .subtitle("2020年09月18日")//图表副标题
                .inverted(false)//是否翻转图形
                .yAxisTitle("花费金额")// Y 轴标题
                .legendEnabled(true)//是否启用图表的图例(图表底部的可点击的小圆点)
                .tooltipValueSuffix("元")//浮动提示框单位后缀
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
                .tooltipValueSuffix("元")//浮动提示框单位后缀
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
                .tooltipValueSuffix("元")//浮动提示框单位后缀
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
            
        }else{
            if segmented.selectedSegmentIndex == 0{
                chartModel2 = AAChartModel()
                    .chartType(.pie)
                    .backgroundColor("#ffffff")
                    .title("开销情况")
                    .subtitle("virtual data")
                    .dataLabelEnabled(true)//是否直接显示扇形图数据
                    .yAxisTitle("℃")
                    .series(
                        [
                            AASeriesElement()
                                .name("Language market shares")
                                .innerSize("20%")//内部圆环半径大小占比(内部圆环半径/扇形图半径),
                                .allowPointSelect(false)
                                .data([
                                    ["吃饭"  ,67],
                                    ["购物",200],
                                    ["社交",83],
                                    ["出行",45],
                                    
                                    ])
                                .toDic()!,
                        ]
                )
                viewWillAppear(true)
            }
            if segmented.selectedSegmentIndex == 1{
                chartModel2 = AAChartModel()
                    .chartType(.pie)
                    .backgroundColor("#ffffff")
                    .title("开销情况")
                    .subtitle("virtual data")
                    .dataLabelEnabled(true)//是否直接显示扇形图数据
                    .yAxisTitle("℃")
                    .series(
                        [
                            AASeriesElement()
                                .name("Language market shares")
                                .innerSize("20%")//内部圆环半径大小占比(内部圆环半径/扇形图半径),
                                .allowPointSelect(false)
                                .data([
                                    ["吃饭"  ,124],
                                    ["购物",400],
                                    ["社交",120],
                                    ["出行",56],
                                    
                                    ])
                                .toDic()!,
                        ]
                )
                viewWillAppear(true)
            }
            if segmented.selectedSegmentIndex == 2{
                chartModel2 = AAChartModel()
                    .chartType(.pie)
                    .backgroundColor("#ffffff")
                    .title("开销情况")
                    .subtitle("virtual data")
                    .dataLabelEnabled(true)//是否直接显示扇形图数据
                    .yAxisTitle("℃")
                    .series(
                        [
                            AASeriesElement()
                                .name("Language market shares")
                                .innerSize("20%")//内部圆环半径大小占比(内部圆环半径/扇形图半径),
                                .allowPointSelect(false)
                                .data([
                                    ["吃饭"  ,600],
                                    ["购物",800],
                                    ["社交",157],
                                    ["出行",100],
                                    
                                    ])
                                .toDic()!,
                        ]
                )
            }
            viewWillAppear(true)
        }
//        //打印选项的索引
//        print("index is \(segmented.selectedSegmentIndex)")
//        //打印选择的文字
//        print("option is \(String(describing: segmented.titleForSegment(at: segmented.selectedSegmentIndex)))")//将获得值转为String类型
    }
 
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
