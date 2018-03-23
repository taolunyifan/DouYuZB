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
let kNormalColor:(CGFloat,CGFloat,CGFloat) = (115,115,115)
let kSelectColor:(CGFloat,CGFloat,CGFloat) = (251,127,29)

protocol TitleViewDelegate:class {
    func titleView(titleView:TitleView,currentIndex:Int)
}

class TitleView: UIView {
    private var currentIndex:Int = 0
    private lazy var labels:[UILabel] = [UILabel]()
    private var titles:[String]
    private var labelW:CGFloat = 0
    weak var delegate:TitleViewDelegate?
    
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
        line.backgroundColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
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
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
    }
    private func setTitleLabels(){
        let labelY:CGFloat = 0
        labelW = frame.width / CGFloat(titles.count)
        let labelH:CGFloat = frame.height - kScrollLineH
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
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
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        currentIndex = currentLabel.tag
        
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.25) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        delegate?.titleView(titleView:self,currentIndex:currentIndex)
    }
}

extension TitleView{
    func setTitle(progress:CGFloat,startIndex:Int,endIndex:Int){
        
        let startLabel = labels[startIndex]
        let endLabel = labels[endIndex]
        let movex = endLabel.frame.origin.x - startLabel.frame.origin.x
        scrollLine.frame.origin.x = startLabel.frame.origin.x + movex*progress
        currentIndex = endIndex

        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        startLabel.textColor = UIColor(r: kSelectColor.0-colorDelta.0*progress, g: kSelectColor.1-colorDelta.1*progress, b: kSelectColor.2-colorDelta.2*progress)
        endLabel.textColor = UIColor(r: kNormalColor.0+colorDelta.0*progress, g: kNormalColor.1+colorDelta.1*progress, b: kNormalColor.2+colorDelta.2*progress)
    }
}
