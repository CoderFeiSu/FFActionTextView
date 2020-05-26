# FFActionView
* 一个可以根据文字点击响应事件的view，类似于新浪微博里面各种字符串的点击
* 简单易用



## 怎样使用
* CocoaPods使用 pod 'FFActionView'
* 手动拖入FFActionView文件夹到项目中
* 网易新闻顶部示例代码1:

```swift

class ViewController: UIViewController {

   fileprivate lazy var kLineSpacing: CGFloat = 10
   fileprivate lazy var kScreenW: CGFloat = UIScreen.main.bounds.width
   
   override func viewDidLoad() {
      super.viewDidLoad()
   
      let introduce = "我们可以提供"
      let phoneKey = "联系电话"
      let phoneValue = "18878828899"
      let mailKey = "联系邮箱"
      let mailValue = "444999@163.com"
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


```
## 支持版本
iOS8及以上
