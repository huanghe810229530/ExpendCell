//
//  ExpendTableViewCell.swift
//  ExpendCell
//
//  Created by guchengfeng on 5/10/17.
//  Copyright © 2017 HCFDATA. All rights reserved.
//

import UIKit

class ExpendTableViewCell: UITableViewCell {
    
    private static let keyPath = "contentSize"
    
    @IBOutlet weak var contentWebView: UIWebView!
    
    /// webView的高度约束，默认为0
    @IBOutlet weak var contentWebViewHeightConstraint: NSLayoutConstraint!
    
    var viewModel = FrameModel(content: "")

    @IBOutlet weak var btn: UIButton!
    
    var expendClouser: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textLabel?.numberOfLines = 2
        contentWebView.scrollView.isScrollEnabled = false        
        contentWebView.scrollView.safe_addObserver(self, forKeyPath: ExpendTableViewCell.keyPath)
    }
    
    deinit {
        contentWebView.scrollView.safe_removeObserver(self, forKeyPath: ExpendTableViewCell.keyPath)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if viewModel.isOpen {
            contentWebView.isHidden = false
            btn.setTitle("收起详情", for: .normal)
            
            contentWebView.loadHTMLString(viewModel.htmlString, baseURL: nil)
        }else {
            btn.setTitle("展开详情", for: .normal)
            contentWebView.isHidden = true
        }
        
        contentView.bringSubview(toFront: btn)
    }
    
    @IBAction func onExpandAction(_ sender: UIButton) {
        if viewModel.isOpen == false { // 点击展开
            viewModel.isOpen = true
            let h = contentWebView.scrollView.contentSize.height
            viewModel.setContentHeight(height: h > 0 ? h : bounds.height)
            contentWebViewHeightConstraint.constant = h > 0 ? h : bounds.height
            if h > 0 {
                expendClouser?()
            }
        }else if viewModel.isOpen == true  { // 点击收起
            viewModel.isOpen = false
            viewModel.setContentHeight(height: 0)
            expendClouser?()
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if change != nil && keyPath == ExpendTableViewCell.keyPath {
            let obj = change?[.newKey]
            let oldSize = (change?[.oldKey] as? NSValue)?.cgSizeValue
            let size = (obj as? NSValue)?.cgSizeValue
            let scroller = object as? UIScrollView
            
            if  (scroller == contentWebView.scrollView) {
                if let aSize = size, let oSize = oldSize , oSize.equalTo(aSize) == false {
                    viewModel.setContentHeight(height: aSize.height)
                    contentWebViewHeightConstraint.constant = aSize.height
                    expendClouser?()
                }
            }
        }
    }
    
}
