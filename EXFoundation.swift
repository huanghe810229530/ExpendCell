//
//  EXFoundation.swift
//  MLShenZhen
//
//  Created by huanghe on 10/21/16.
//  Copyright © 2016 HCFData. All rights reserved.
//

import UIKit


/// 安全添加和移除观察者
extension NSObject {
    
    fileprivate struct associatedKeys {
        static var safe_observersArray = "observers"
    }
    
    
    fileprivate var observers: [[String : NSObject]] {
        get {
            if let observers = objc_getAssociatedObject(self, &associatedKeys.safe_observersArray) as? [[String : NSObject]] {
                return observers
            } else {
                self.observers = [[String : NSObject]]()
                return self.observers
            }
        } set {
            objc_setAssociatedObject(self, &associatedKeys.safe_observersArray, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    public func safe_addObserver(_ observer: NSObject, forKeyPath keyPath: String) {
        let observerInfo = [keyPath : observer]
        
        if observers.index(where: { $0 == observerInfo }) == nil {
            observers.append(observerInfo)
            addObserver(observer, forKeyPath: keyPath, options: [.old, .new], context: nil)
        }
    }
    
    public func safe_removeObserver(_ observer: NSObject, forKeyPath keyPath: String) {
        let observerInfo = [keyPath : observer]
        if let index = observers.index(where: { $0 == observerInfo}) {
            observers.remove(at: index)
            removeObserver(observer, forKeyPath: keyPath)
        }
    }
    
}
