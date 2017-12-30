//
//  FFActionModel.swift
//  FFActionViewExample
//
//  Created by 飞飞 on 2017/12/29.
//  Copyright © 2017年 飞飞. All rights reserved.
//

import UIKit

public class FFActionModel: NSObject {
    // 值
    public var value = ""
    // 值的范围
    public var range: NSRange = NSMakeRange(0, 0)
    // 值的类型(手机号或QQ号或网址)
    public var type = ""
    // 值的rects(因为子字符串有可能换行就会有两个rect)
    public var rects = [CGRect.zero]
    
}
