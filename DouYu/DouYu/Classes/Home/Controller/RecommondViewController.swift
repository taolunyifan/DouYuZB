//
//  RecommondViewController.swift
//  DouYu
//
//  Created by 黄忠汉(外包) on 2018/3/23.
//  Copyright © 2018年 黄忠汉(外包). All rights reserved.
//

import UIKit

let kItemS:CGFloat = 10
let kItemW:CGFloat = (kScreenW - 3 * kItemS) / 2
let kItemH:CGFloat = kItemW * 3 / 4
let kHeadH:CGFloat = 50
let kNormalCellId = "normalCell"
let kSpecialCellId = "specialCell"
let kHeaderId = "header"

class RecommondViewController: UIViewController {
    
    lazy var collectionView:UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemS
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeadH)
        
        let frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH - kStatusBarH - kNavigationBarH - kTabBarH - 40)
        let colletionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        colletionView.backgroundColor = UIColor.white
        //不知为何无效
//        colletionView.autoresizesSubviews = true
//        colletionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        colletionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellId)
        colletionView.register(UINib(nibName: "RecommondVCHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderId)
        colletionView.dataSource = self
        return colletionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        setUI()
    }

    

    // MARK:

}

extension RecommondViewController{
    private func setUI(){
        view.backgroundColor = UIColor.green
        view.addSubview(collectionView)

        
    }
}

extension RecommondViewController:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderId, for: indexPath)
        return header
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellId, for: indexPath)
        return cell
    }
}
