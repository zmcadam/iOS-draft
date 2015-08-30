//
//  ViewController.swift
//  
//
//  Created by zmc on 15/8/24.
//
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate,UITableViewDataSource
{
    
    // MARK: - Global Variable
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var timer:NSTimer!    // time counter
    var timerTwo:NSTimer!
    
    @IBAction func choosePage(sender: UIPageControl) {
        var page = sender.currentPage
        let x = CGFloat(page) * self.scrollView.frame.size.width
        self.scrollView.contentOffset = CGPointMake(x, 0) // scrollView's offset
        println(sender.currentPage)
    }
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    var buttonClicked = 1
    
    
    @IBOutlet weak var table: UITableView!
    @IBAction func tableOne(sender: UIButton) {
        button2.setImage(UIImage(named: "实盘赛n"), forState: nil)
        button1.setImage(UIImage(named: "热门微期权"), forState: nil)
        buttonClicked = 1
        table.reloadData()
        
    }
    @IBAction func tableTwo(sender: UIButton) {
        button1.setImage(UIImage(named: "热门微期权n"), forState: nil)
        button2.setImage(UIImage(named: "实盘赛"), forState: nil)
        buttonClicked = 2
        table.reloadData()
    }
    
    
    // MARK: - fake data source for convenience
    
    let stock = [
        ("60'","沪深300股","⬆︎","1.200","79"),
        ("30'","上证50中证500股","⬆︎","1.104","35"),
        ("半天","上海交易所白银期货","⬇︎","1.104","35"),
        ("全天","沪深300股","⬆︎","1.200","79")
    ]
    
    // MARK: - tableView
    // section
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    // rows of tableview
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if buttonClicked == 1 {
            return stock.count
        } else {
            return 1
        }
    }
    
    // content of each cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        let cellWidth = cell.frame.size.width
        let cellHeight = cell.frame.size.height

        
        if buttonClicked == 1 {
        
        var label1 = UILabel()
        label1.frame = CGRectMake(20, 10, 27, 20)
        label1.backgroundColor = UIColor.lightGrayColor()
        label1.textColor = UIColor.whiteColor()
        label1.textAlignment = .Center
        label1.layer.shadowOpacity = 0.1
        label1.font = UIFont.systemFontOfSize(13)
        label1.text = stock[indexPath.row].0
        
        var label2 = UILabel()
        label2.frame = CGRectMake(60, 10, 200, 20)
        label2.textColor = UIColor.darkGrayColor()
        label2.text = stock[indexPath.row].1
        
        var color = UIColor.redColor()
        if stock[indexPath.row].2 == "⬇︎" {
            color = UIColor.greenColor()
        }
        
        var label3 = UILabel()
        label3.frame = CGRectMake(270, 10, 12, 20)
        label3.backgroundColor = color
        label3.textColor = UIColor.whiteColor()
        label3.font = UIFont.systemFontOfSize(13)
        label3.textAlignment = .Center
        label3.text = stock[indexPath.row].2
        
        var label4 = UILabel()
        label4.frame = CGRectMake(282, 10, 30, 20)
        label4.backgroundColor = color
        label4.textColor = UIColor.whiteColor()
        label4.font = UIFont.boldSystemFontOfSize(10)
        label4.textAlignment = .Center
        label4.text = stock[indexPath.row].3
        
        var label5 = UILabel()
        label5.frame = CGRectMake(312, 10, 30, 20)
        label5.backgroundColor = color
        label5.textColor = UIColor.whiteColor()
        label5.font = UIFont.boldSystemFontOfSize(23)
        label5.textAlignment = .Left
        label5.text = stock[indexPath.row].4

        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
     
        cell.addSubview(label1)
        cell.addSubview(label2)
        cell.addSubview(label3)
        cell.addSubview(label4)
        cell.addSubview(label5)
        } else {
            cell.textLabel?.text = "木有数据ahahaha"
        }
        return cell
    }
    
    
    // MARK: - labelScroll
    func labelScroll() {
        label.text = "2015年7月3日平台调整通知"
        var from:CGFloat = 0
        var to:CGFloat = 40
        let screenWidth = UIScreen.mainScreen().bounds.width
        let screenHeight = UIScreen.mainScreen().bounds.height
        
        
        println("\(screenWidth),\(screenHeight)")
        
        if screenWidth == 320 && screenHeight == 568 {
            label.font = UIFont.systemFontOfSize(10)
            from = -30
            to = 10
        } else if screenWidth == 375 && screenHeight == 667 {
            label.font = UIFont.systemFontOfSize(11)
            from = -20
            to = 50
        } else if screenWidth == 414 && screenHeight == 736 {
            label.font = UIFont.boldSystemFontOfSize(13)
            from = -10
            to = 60
        }
        
        println("\(label.frame.origin.x),\(label.frame.origin.y)")
        // JNW 位移
        let translation = JNWSpringAnimation(keyPath: "transform.translation")
        translation.damping = 6
        translation.stiffness = 1
        translation.mass = 2
        translation.fromValue = label.frame.origin.x + from
        translation.toValue = label.frame.origin.x + to
        translation.speed = 0.2
        translation.repeatCount = 100
        label.layer.addAnimation(translation, forKey: translation.keyPath)

    }
    
    
    // MARK: - pictureScroll
    func pictureScroll() {
        
        // add view
        self.view.addSubview(scrollView)
        self.view.addSubview(pageControl)
        
        let imageW = self.view.frame.width
        let imageH = self.scrollView.frame.size.height
        var imageY:CGFloat = 0
        var totalCount = 3
        
        // add pic
        for index in 0..<totalCount {
            var imageView = UIImageView()
            let imageX = CGFloat(index) * imageW
            imageView.frame = CGRectMake(imageX, imageY, imageW, imageH)
            println("imageX = \(imageX)  imageY = \(imageY)  imageW = \(imageW)  imageH = \(imageH)")
            let name = String(format: "scroll%d", index+1)
            imageView.image = UIImage(named: name)
            self.scrollView.showsHorizontalScrollIndicator = false
            self.scrollView.addSubview(imageView)
        }
        
        // set contentSize
        let contentW = imageW * CGFloat(totalCount)
        self.scrollView.contentSize = CGSizeMake(contentW, 0)
        
        // set scrollview
        self.scrollView.pagingEnabled = true
        self.scrollView.delegate = self
        
        // set pagecontrol
        self.pageControl.numberOfPages = totalCount
        self.pageControl.userInteractionEnabled = true
        self.pageControl.defersCurrentPageDisplay = false

        self.addTimer()
        
    }
    
    // set a timecounter
    func addTimer() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(5,
            target: self,
            selector: "nextImage:",
            userInfo: nil,
            repeats: true)
    }
    
    func nextImage(sender: AnyObject!) {
        var page = self.pageControl.currentPage
        if page == 2 {
            page = 0
        } else {
            page++
        }
        let x = CGFloat(page) * self.scrollView.frame.size.width
        self.scrollView.contentOffset = CGPointMake(x, 0) // scrollView's offset
    }
    
    // MARK: - Delegate override of scrollView
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let scrollviewW = scrollView.frame.size.width
        let x = scrollView.contentOffset.x
        let page = (Int)((x+scrollviewW/2) / scrollviewW)
        self.pageControl.currentPage = page
    }

    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pictureScroll()
        labelScroll()
    }}
