//
//  FFActionModel.swift
//  FFActionViewExample
//
//  Created by 飞飞 on 2017/12/29.
//  Copyright © 2017年 飞飞. All rights reserved.
//

import UIKit

class FFActionModel: NSObject {
    
    // 值
    var value = ""
    // 值的范围
    var range: NSRange = NSMakeRange(0, 0)
    // 值的类型(手机号或QQ号或网址)
    var type = ""
    // 值的rects(因为子字符串有可能换行就会有两个rect)
    var rects = [CGRect.zero]
    
}
