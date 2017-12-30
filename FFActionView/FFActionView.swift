//
//  FFActionView.swift
//  FFActionViewExample
//
//  Created by 飞飞 on 2017/12/29.
//  Copyright © 2017年 飞飞. All rights reserved.
//

import UIKit

class FFActionView: UITextView {
    
    // 属性字符串
    var attributedStr: NSAttributedString? {
        didSet {
            attributedText = attributedStr
        }
    }
    
    // 存放所有可以执行点击事件的对象数组
    var items: [FFActionModel]? {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
              self.setUpActionRects()
            }
        }
    }
    // 被点击后的背景颜色
    var selectedColor: UIColor = UIColor(white: 0, alpha: 0.7)
    
    // 字符串里面某个item被点击
    var itemIsClicked: ((_ action: FFActionModel)->())?

    // 标记选择的view
    fileprivate lazy var actionTag: Int = 1000
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        isEditable = false
        isScrollEnabled = false
        textContainerInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: -5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        UIMenuController.shared.isMenuVisible = false
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let point = touches.first?.location(in: self) else {
            return
        }
        guard let action = fetchActionModel(from: point) else {
            return
        }
        
        // 回调回去
        itemIsClicked?(action)
        
        // 添加底部标记
        for rect in action.rects {
            let view = UIView()
            view.frame = rect
            view.backgroundColor = selectedColor
            view.tag = actionTag
            insertSubview(view, at: 0)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.touchesCancelled(touches, with: event)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for view in subviews {
            if view.tag == actionTag {
                UIView.animate(withDuration: 0.25, animations: {
                    view.removeFromSuperview()
                })
            }
        }
    }
    
    private func fetchActionModel(from point: CGPoint) -> FFActionModel? {
        for action in items ?? [] {
            for rect in action.rects {
                if rect.contains(point) {
                    return action
                }
            }
        }
        return nil
    }
    
    // 获取执行action动作的子字符串的rects(如果换行有两个rect)
    private func setUpActionRects(){
        for action in items ?? [] {
            // 给selectedRange赋值会改变selectedTextRange的值
            selectedRange = action.range
            // 获取rect
            guard let selectedTextRange = selectedTextRange else {return}
            guard let selectionRects = selectionRects(for: selectedTextRange) as? [UITextSelectionRect] else {return}
            var rects = [CGRect]()
            for selectionRect in selectionRects {
                if selectionRect.rect.width == 0 || selectionRect.rect.height == 0 {
                    continue
                }
                rects.append(selectionRect.rect)
            }
            action.rects = rects
        }
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard let _ = fetchActionModel(from: point) else {
            return false
        }
        return true
    }

}
