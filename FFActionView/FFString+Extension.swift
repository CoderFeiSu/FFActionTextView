//
//  FFString+Extension.swift
//  FFActionViewExample
//
//  Created by 飞飞 on 2017/12/30.
//  Copyright © 2017年 飞飞. All rights reserved.
//

import Foundation

//range转换为NSRange
//扩展的是String类，不可改为NSRange或者Range的扩展，因为samePosition，utf16是String里的
extension String {
    
    func fetchNSRange(of value: String) -> NSRange? {
        guard let range = self.range(of: value) else {return nil}
        if let from = range.lowerBound.samePosition(in: utf16), let to = range.upperBound.samePosition(in: utf16) {
            return NSMakeRange(utf16.distance(from: utf16.startIndex, to: from), utf16.distance(from: from, to: to))
        }
        return nil
    }
}
