//
//  ViewController.swift
//  FFActionViewExample
//
//  Created by 飞飞 on 2017/12/29.
//  Copyright © 2017年 飞飞. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    fileprivate lazy var kLineSpacing: CGFloat = 10
    fileprivate lazy var kInteritemSpacing: CGFloat = 10
    fileprivate lazy var kScreenW: CGFloat = UIScreen.main.bounds.width
    fileprivate lazy var kScreenH: CGFloat = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let introduce = "我们可以提供"
        let phoneKey = "联系电话"
        let phoneValue = "18680571673"
        let mailKey = "联系邮箱"
        let mailValue = "sf2907989@163.com"
        let totalStr = introduce + phoneKey + phoneValue + mailKey + mailValue
        guard let phoneValueNSRange = totalStr.fetchNSRange(of: phoneValue) else {return}
        guard let mailValueNSRange = totalStr.fetchNSRange(of: mailValue) else {return}

        // 添加NSMutableParagraphStyle属性解决textview内容没有满格反而换行的问题
        let linebreak = NSMutableParagraphStyle()
        linebreak.lineBreakMode = .byCharWrapping
       let attrs =  NSMutableAttributedString(string: totalStr, attributes: [NSAttributedStringKey.paragraphStyle: linebreak])
        attrs.addAttributes([NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17.0)], range: NSMakeRange(0, attrs.length))
        attrs.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue, range: phoneValueNSRange)
        attrs.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue, range: mailValueNSRange)

        // 把要处理的子字符串包装成对象添加进数组里面
        var actions  = [FFActionModel]()
        let action1 = FFActionModel()
        action1.value = phoneValue
        action1.range = phoneValueNSRange
        action1.type = "1"
        actions.append(action1)
        let action2 = FFActionModel()
        action2.value = mailValue
        action2.range = mailValueNSRange
        action2.type = "2"
        actions.append(action2)
        
        // 计算actionView的尺寸
        let maxWidth = kScreenW - 4 * kLineSpacing
        let realSize = attrs.boundingRect(with: CGSize(width: maxWidth, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, context: nil).size
        // 设置actionView
        let actionView = FFActionView()
        actionView.itemIsClicked = {  action in
            print("回调:\(action.value)---\(action.type)")
        }
        actionView.attributedStr = attrs
        actionView.items = actions
        actionView.selectedColor = UIColor.lightGray
        actionView.frame = CGRect(x: 2 * kLineSpacing, y: 100, width: realSize.width, height: realSize.height)
        view.addSubview(actionView)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("hhahah")
    }
}






