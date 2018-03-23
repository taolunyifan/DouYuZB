//
//  PageView.swift
//  DouYu
//
//  Created by 黄忠汉(外包) on 2018/3/21.
//  Copyright © 2018年 黄忠汉(外包). All rights reserved.
//

import UIKit

let cellId = "contentCell"


protocol PageViewDelegate:class {
    func pageView(pageView:PageView,progress:CGFloat,startIndex:Int,endIndex:Int)
}

class PageView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    private var childVcs:[UIViewController]
    private weak var superVc:UIViewController?
    private var startOffsetX:CGFloat = 0
    weak var delegate:PageViewDelegate?
    private var isForbidScrollDelegate:Bool = false
    
    init(frame: CGRect,childVcs:[UIViewController],superVc:UIViewController?) {
        self.childVcs = childVcs
        self.superVc = superVc
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private lazy var collectionView:UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.itemSize = (self?.bounds.size)!
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        return collectionView
    }()
    
}

extension PageView{
    private func setUI(){
        for vc in childVcs {
            superVc?.addChildViewController(vc)
        }
        collectionView.frame = bounds
        addSubview(collectionView)
    }
}

extension PageView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return childVcs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

extension PageView{
    func  setPageViewOffsetIndex(offsetIndex:Int) {
        isForbidScrollDelegate = true
        let offset = CGFloat(offsetIndex)*kScreenW
        collectionView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
    }
}

extension PageView:UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScrollDelegate == true {
            return
        }
        var startIndex:Int = 0
        var endIndex:Int = 0
        var progress:CGFloat = 0
        var collectionW = collectionView.bounds.width
        if scrollView.contentOffset.x > startOffsetX {//左移
            startIndex = Int(scrollView.contentOffset.x / collectionW)
            endIndex = startIndex + 1
            progress = scrollView.contentOffset.x/collectionW - floor(scrollView.contentOffset.x/collectionW)
            if endIndex >= childVcs.count{
                endIndex = childVcs.count - 1
            }
            if scrollView.contentOffset.x - startOffsetX == collectionW{
                progress = 1
                endIndex = startIndex
            }
        } else {//右移
            endIndex = Int(scrollView.contentOffset.x / collectionW)
            startIndex = endIndex + 1
            progress = 1 - (scrollView.contentOffset.x/collectionW - floor(scrollView.contentOffset.x/collectionW))
            if startIndex >= childVcs.count{
                startIndex = childVcs.count - 1
            }
            if startOffsetX-scrollView.contentOffset.x == collectionW{
                progress = 1
                startIndex = endIndex
            }
        }
        print("startIndex:\(startIndex)endIndex:\(endIndex)progress:\(progress)")
        delegate?.pageView(pageView:self,progress:progress,startIndex:startIndex,endIndex:endIndex)
    }
}
