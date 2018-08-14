# JXMarqueeView
A powerful and easy to use marquee view.

## 简介
[简书地址](https://www.jianshu.com/p/835ba205453d)
相信大家在工作中，都会遇到这样一个情况。一个UILabel仅显示一行，在小屏手机中显示不完整出现... 但是这些信息又比较重要，不能省略且没有充足的空间换行显示。
那么问题来了？这该怎么办呢？这个时候，聪明的产品经理摸了摸下巴，突然双眼放光“用跑马灯啊” ![image](http://upload-images.jianshu.io/upload_images/1085173-8e2995c2dc7144a3.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

好吧，既然产品都给出了精妙绝伦的方案，程序员的使命就是义无反顾地完成它。

## 原理
- 原理很简单，就是用CADisplayLink，根据刷新频率，不停的调整视图的位置就行。为了达到循环显示，需要添加两个一样的视图。
- 为了扩大跑马灯的使用范围，我进行了抽象化处理，并没有写死用UILabel来实现，而是暴露了一个属性`contentView: UIView`。只要是UIView及其子类，都可以用来进行跑马灯显示。对于复杂的视图，需要自己重写contentView的sizeThatFits方法，返回正确的size即可。
- 具体细节可以看源码了解，这里分享两个骚操作：
1. 如何实现UIView的拷贝？
```swift
//骚操作：UIView是没有遵从拷贝协议的。可以通过UIView支持NSCoding协议，间接来复制一个视图
let otherContentViewData = NSKeyedArchiver.archivedData(withRootObject: validContentView)
let otherContentView = NSKeyedUnarchiver.unarchiveObject(with: otherContentViewData) as! UIView
otherContentView.frame = CGRect(x: validContentView.bounds.size.width + contentMargin, y: 0, width: validContentView.bounds.size.width, height: self.bounds.size.height)
containerView.addSubview(otherContentView)
```
2. 如何断开CADisplayLink的循环引用？
大家知道CADisplayLink和NSTimer都会对Target强持有，Target一般也会强持有它们。如果使用闭包回调的API，可以解决这个问题，但是这些API要求iOS的系统都比较高。所以，还是需要直面这个问题。
```swift
override func willMove(toSuperview newSuperview: UIView?) {
        //骚操作：当视图将被移除父视图的时候，newSuperview就为nil。在这个时候，停止掉CADisplayLink，断开循环引用，视图就可以被正确释放掉了。
        if newSuperview == nil {
            self.stopMarquee()
        }
    }
```
## 使用
```swift
//文字
let label = UILabel()
label.textColor = UIColor.red
label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
label.text = "abcdefghijklmnopqrstuvwxyz"

marqueeView.contentView = label
marqueeView.contentMargin = 50
marqueeView.marqueeType = .left
self.view.addSubview(marqueeView)

//图片
let imageView = UIImageView(image: UIImage(named: "haizeiwang.jpeg"))
        imageView.contentMode = .scaleAspectFill

marqueeView.contentView = imageView
marqueeView.marqueeType = .reverse
self.view.addSubview(marqueeView)
```

## 预览
`JXMarqueeType.left`：往左滚动
![left.gif](https://upload-images.jianshu.io/upload_images/1085173-712f04ce62c1a3bc.gif?imageMogr2/auto-orient/strip)


`JXMarqueeType.right`：往右滚动
![right.gif](https://upload-images.jianshu.io/upload_images/1085173-5d21ffa924ec2afa.gif?imageMogr2/auto-orient/strip)


`JXMarqueeType.reverse`：循环反转
![reverse.gif](https://upload-images.jianshu.io/upload_images/1085173-acffb41b6479bf1a.gif?imageMogr2/auto-orient/strip)


图片

![picture.gif](https://github.com/pujiaxin33/JXMarqueeView/blob/master/JXMarqueeView/Assets/picture.gif?raw=true)

自定义
![poetry.gif](https://upload-images.jianshu.io/upload_images/1085173-c197188ee4e4fb44.gif?imageMogr2/auto-orient/strip)
