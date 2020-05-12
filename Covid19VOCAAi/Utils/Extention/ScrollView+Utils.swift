//
//  ScrollView+Utils.swift
//  
//
//  Created by Omer Elimelech on 3/29/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    
    func getMaxYForSubviewClass(subviewClass: AnyClass) -> CGFloat {
        var maxY:CGFloat = 0.0
        for subview in self.subviews {
            if subview.isKind(of: subviewClass) {
                if maxY < subview.frame.maxY {
                    maxY = subview.frame.maxY - self.frame.size.height
                }
            }
        }
        
        return maxY
    }
    
    func getMaxXForSubviewClass(subviewClass: AnyClass) -> CGFloat {
        var maxX:CGFloat = 0.0
        for subview in self.subviews {
            if subview.isKind(of: subviewClass) {
                if maxX < subview.frame.maxX {
                    maxX = subview.frame.maxX
                }
            }
        }
        
        return maxX
    }
}

extension UITableView {
    
    public func setOffsetToBottom(animated: Bool) {
        if self.contentSize.height > self.frame.size.height {
            self.setContentOffset(CGPoint.init(x: 0, y: self.contentSize.height - self.bounds.size.height), animated: animated)
        }
    }
    
    public func scrollToLastRow(animated: Bool, section: Int) {
        if self.numberOfRows(inSection: 0) > 0 {
            self.scrollToRow(at: IndexPath.init(row: self.numberOfRows(inSection: section) - 1, section: section), at: .top, animated: animated)
        }
    }
}
