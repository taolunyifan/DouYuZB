//
//  TitleView.swift
//  DouYu
//
//  Created by 黄忠汉(外包) on 2018/3/21.
//  Copyright © 2018年 黄忠汉(外包). All rights reserved.
//

import UIKit
private let kScrollLineH:CGFloat = 2
private let kBottomLineH:CGFloat = 0.5
class TitleView: UIView {
    private var currentIndex:Int = 0
    private lazy var labels:[UILabel] = [UILabel]()
    private var titles:[String]
    
    private lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    private lazy var bottomLine:UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.lightGray
        line.frame = CGRect(x: 0, y: bounds.height-kBottomLineH, width: bounds.width, height: kBottomLineH)
        return line
    }()
    private lazy var scrollLine:UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.orange
        guard let width = labels.first?.frame.size.width else{
            return line
        }
        line.frame = CGRect(x: 0, y: bounds.height-kBottomLineH-kScrollLineH, width: width, height: kScrollLineH)
        return line
    }()
    
    init(frame: CGRect,titles:[String] ) {
        self.titles = titles
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// mark! -设置ui界面
extension TitleView{
    private func setUI(){
        addSubview(scrollView)
        scrollView.frame = bounds
        setTitleLabels()
        addSubview(bottomLine)
        addSubview(scrollLine)
        guard let firstLabel = labels.first else{return}
        firstLabel.textColor = UIColor.orange
    }
    private func setTitleLabels(){
        let labelY:CGFloat = 0
        let labelW:CGFloat = frame.width / CGFloat(titles.count)
        let labelH:CGFloat = frame.height - kScrollLineH
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            let labelX:CGFloat = CGFloat(index) * labelW
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            labels.append(label)
            
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(titleClicked))
            label.addGestureRecognizer(tap)
        }
    }
    @objc private func titleClicked(tap:UITapGestureRecognizer){
        print(tap.description)
        print("tap title")
        guard let currentLabel = tap.view as? UILabel else {
            return
        }
        let oldLabel = labels[currentIndex]
        oldLabel.textColor = UIColor.darkGray
        currentLabel.textColor = UIColor.orange
        
        currentIndex = currentLabel.tag
        
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.25) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
    }
}

