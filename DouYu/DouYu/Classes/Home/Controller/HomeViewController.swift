//
//  HomeViewController.swift
//  DouYu
//
//  Created by 黄忠汉(外包) on 2018/3/20.
//  Copyright © 2018年 黄忠汉(外包). All rights reserved.
//

import UIKit
import SnapKit

private let kTitleViewH:CGFloat = 40
class HomeViewController: UIViewController {
    private lazy var pageTitleView:TitleView = {[weak self] in
        let titleViewFrame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = TitleView(frame: titleViewFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    private lazy var subVcs:[UIViewController] = [UIViewController]()
    private lazy var pageView:PageView = {[weak self] in
        let frame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH+kTitleViewH, width: kScreenW, height: kScreenH-kStatusBarH-kNavigationBarH-kTitleViewH-44)
        let redVC = RecommondViewController()
        subVcs.append(redVC)
        for _ in 0..<3{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            subVcs.append(vc)
        }
        let pageView = PageView(frame: frame, childVcs: subVcs, superVc: self)
        pageView.backgroundColor = UIColor.purple
        pageView.delegate = self
        return pageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        automaticallyAdjustsScrollViewInsets = false
        setUI()
        
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
extension HomeViewController{
    private func setUI(){
        initNavBar()
        view.addSubview(pageTitleView)
        view.addSubview(pageView)
    }
    private func initNavBar(){
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        let size = CGSize(width: 10, height: 10)
        let item1 = UIBarButtonItem(imageName: "homeLogoIcon")
        let item2 = UIBarButtonItem(imageName: "home_newGameicon", hightImageName: "home_newGameicon_clicked", size: size)
        let item3 = UIBarButtonItem(imageName: "viewHistoryIcon", hightImageName: "viewHistoryIconHL", size: size)
        navigationItem.leftBarButtonItem = item1
        navigationItem.rightBarButtonItems = [item3,item2]
        
        let searchView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 32))
        searchView.layer.cornerRadius = 16
        searchView.backgroundColor = UIColor.white
//        searchView.clipsToBounds = true
        navigationItem.titleView = searchView
        searchView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(32)
        }
        
        let searchImageV = UIImageView(image: UIImage(named: "searchIconDark"))
//        searchImageV.frame = CGRect(x: 7, y: 7, width: 18, height: 18)
        searchView.addSubview(searchImageV)
        searchImageV.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(18)
            make.left.equalTo(searchView).offset(7)
            make.top.equalTo(searchView).offset(7)
        }
        
//        let qrImageV = UIImageView(image: UIImage(named: "qr_er_btn"))
//        searchView.addSubview(qrImageV)
//        qrImageV.frame = CGRect(x: searchView.frame.size.width-7-18, y: 7, width: 18, height: 18)
//        qrImageV.snp.makeConstraints { (make) -> Void in
//            make.width.height.equalTo(18)
//            make.right.equalTo(searchView)
//            make.top.equalTo(searchView).offset(7)
//        }
    }
}
extension HomeViewController:TitleViewDelegate{
    func titleView(titleView: TitleView, currentIndex: Int) {
        print(currentIndex)
        pageView.setPageViewOffsetIndex(offsetIndex:currentIndex)
    }
}

extension HomeViewController:PageViewDelegate{
    func pageView(pageView: PageView, progress: CGFloat, startIndex: Int, endIndex: Int) {
        pageTitleView.setTitle(progress:progress,startIndex:startIndex,endIndex:endIndex)
    }
}
