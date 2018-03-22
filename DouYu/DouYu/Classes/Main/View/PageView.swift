//
//  PageView.swift
//  DouYu
//
//  Created by 黄忠汉(外包) on 2018/3/21.
//  Copyright © 2018年 黄忠汉(外包). All rights reserved.
//

import UIKit

let cellId = "contentCell"
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
