# YHAlertView
iOS-YHAlertView(自定义AlertView,Swift版)

## 简单介绍
YHAlertView是仿系统的UIAlertView，UIAlertController弹出风格而定制的弹出视图。支持多选择，模糊背景，通俗易懂，扩展性好，代码无侵入。由此，你可以定制专属风格的AlertView.

## API 介绍
在YHAlertView.swift文件中，用标注的方式Public Property，Public Method,Private Property,Private Method区分好公有和私有的属性、方法。

## 调用方式
可以参考我的DEMO.:[YHAlertView](https://github.com/samuelandkevin/YHAlertView)
```
// 样式一:
// message 和 cancelBtn 为nil
                YHAlertView.show(title: "YHAlertView", message: nil, cancelButtonTitle: nil, otherButtonTitle: "确定") { (alertV:YHAlertView, index:Int) in
                    print("点击下标是:\(index)")
                }
                
// 样式二:
// message 好长
                YHAlertView.show(title: "YHAlertView", message: "消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊", cancelButtonTitle: "取消", otherButtonTitle: "确定") { (alertV:YHAlertView, index:Int) in
                    print("点击下标是:\(index)")
                }

// 样式三
// 多选择弹框
                YHAlertView.show(title: "YHAlertView", message: "多选择弹框", cancelButtonTitle: "取消", otherButtonTitles:"1","2","3","4","5","6") { (alertV:YHAlertView, index:Int) in
                    print("点击下标是:\(index)")
                }


// 样式四
// 取消模糊背景
                let alertV = YHAlertView(title: "YHAlertView", message: "取消模糊背景", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: ["确定"])
                alertV.visual = false
                alertV.show()

// 样式五
// 取消弹出动画,改变背景颜色
            let alertV = YHAlertView(title: "YHAlertView", message: "取消弹出动画,改变背景颜色", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: ["确定"])
            alertV.visual = false
            alertV.animationOption = .none
            alertV.visualBGColor = UIColor.red
            alertV.show()

```

## 效果图
<img src="http://img.blog.csdn.net/20170523100947678?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvc2FtdWVsYW5ka2V2aW4=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast" width="60%" alt="还在路上，稍等..."/>

<img src="http://img.blog.csdn.net/20170523101020222?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvc2FtdWVsYW5ka2V2aW4=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast" width="60%" alt="还在路上，稍等..."/>

<img src="http://img.blog.csdn.net/20170523101047960?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvc2FtdWVsYW5ka2V2aW4=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast" width="60%" alt="还在路上，稍等..."/>

<img src="http://img.blog.csdn.net/20170523101113538?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvc2FtdWVsYW5ka2V2aW4=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast" width="60%" alt="还在路上，稍等..."/>

<img src="http://img.blog.csdn.net/20170523101147038?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvc2FtdWVsYW5ka2V2aW4=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast" width="60%" alt="还在路上，稍等..."/>

## 点赞的都是帅哥和美女！
