//
//  FrameModel.swift
//  ExpendCell
//
//  Created by guchengfeng on 5/10/17.
//  Copyright © 2017 HCFDATA. All rights reserved.
//

import UIKit

protocol BuildHtmlProtocol {
    func buildHtml(body: String) -> String
}

extension BuildHtmlProtocol {
    var docFront: String {
        get {
            return "<!doctype html><html><head><meta http-equiv='x-ua-compatible' content='IE=edge'><meta name='renderer' content='webkit'><meta charset='UTF-8'><meta name='fragment' content='!'><meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'><meta name='viewport' content='minimal-ui,width=device-width,initial-scale=1,maximum-scale=1,minimum-scale=1,user-scalable=no'><meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='white'><meta name='format-detection' content='telephone=no'><style >img {width: 60%; pointer-events: none; display:block;}body {font: normal 75% Helvetica, Arial, sans-serif;word-wrap:break-word}</style></head><body>"
        }
    }
    
    var docBehind: String {
        get {
            return "</body></html>"
        }
    }
    
    func buildHtml(body: String) -> String {
        let webStringDesc = NSMutableString(string: docFront)
        webStringDesc.append(body.replacingOccurrences(of: "\"", with: "\'"))
        webStringDesc.append(docBehind)
        
        return webStringDesc as String
    }
}

class FrameModel: BuildHtmlProtocol {
    
    var content = ""
    private(set) var htmlString = ""
    private(set) var contentHeight: CGFloat = 0
    
    var isOpen = false
    
    init(content: String) {
        guard content.characters.count > 0 else {
            return
        }
        
        self.content = content
        self.htmlString = buildHtml(body: content)
    }
    
    func setContentHeight(height: CGFloat) {
        contentHeight = height
    }
}
