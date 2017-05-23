//
//  ViewController.swift
//  YHAlertView
//
//  Created by samuelandkevin on 2017/5/22.
//  Copyright © 2017年 samuelandkevin. All rights reserved.
//  https://github.com/samuelandkevin/YHAlertView

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        _setUpNavigationBar()
        _setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private Method
    private func _setUpNavigationBar(){
        self.title = "YHAlertView"
        
        //设置导航栏背景颜色
        let color = UIColor(red: CGFloat(0) / 255.0, green: CGFloat(191) / 255.0, blue: CGFloat(143) / 255.0, alpha: CGFloat(1))
        navigationController?.navigationBar.barTintColor = color
        
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.init(white: 0.871, alpha: 1.000)
        shadow.shadowOffset = CGSize(width: 0.5, height: 0.5)
        shadow.shadowBlurRadius = 20
        
        //设置导航栏标题颜色
        let attributes = [NSForegroundColorAttributeName:UIColor.white,NSFontAttributeName:UIFont.systemFont(ofSize: 18),NSShadowAttributeName:shadow]
        
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.isTranslucent = false
        
        //设置返回按钮的颜色
        UINavigationBar.appearance().tintColor = UIColor.white
        

    }
    
    private func _setupUI(){
        
        for i in 0..<5 {
            let btn = UIButton()
            btn.tag = 100 + i
            
            let w:CGFloat = 200
            let h:CGFloat = 60
            let x = (view.frame.size.width - w)/2
            let y = (h+10) * CGFloat(i) + CGFloat(10)
            btn.frame = CGRect(x: x, y: y, width: w, height: h)
            btn.backgroundColor = UIColor.orange
            btn.setTitle("样式 "+"\(i+1)", for: .normal)
            btn.addTarget(self, action: #selector(onBtn(sender:)), for: .touchUpInside)
            view.addSubview(btn)
        }
      
    }
    
    // MARK: - Action
    func onBtn(sender:UIButton){
        
        switch sender.tag {
            case 100:
                
                // message 和 cancelBtn 为nil
                YHAlertView.show(title: "YHAlertView", message: nil, cancelButtonTitle: nil, otherButtonTitle: "确定") { (alertV:YHAlertView, index:Int) in
                    print("点击下标是:\(index)")
                }
                break
            case 101:
                
                // message 好长
                YHAlertView.show(title: "YHAlertView", message: "消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊", cancelButtonTitle: "取消", otherButtonTitle: "确定") { (alertV:YHAlertView, index:Int) in
                    print("点击下标是:\(index)")
                }
                break
            case 102:
                
                // 多选择弹框
                YHAlertView.show(title: "YHAlertView", message: "多选择弹框", cancelButtonTitle: "取消", otherButtonTitles:"1","2","3","4","5","6") { (alertV:YHAlertView, index:Int) in
                    print("点击下标是:\(index)")
                }
                
                break
            case 103:
                
                //取消模糊背景
                let alertV = YHAlertView(title: "YHAlertView", message: "取消模糊背景", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: ["确定"])
                alertV.visual = false
                alertV.show()

                break
            case 104:
            
            //取消弹出动画,改变背景颜色
            let alertV = YHAlertView(title: "YHAlertView", message: "取消弹出动画,改变背景颜色", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: ["确定"])
            alertV.visual = false
            alertV.animationOption = .none
            alertV.visualBGColor = UIColor.red
            alertV.show()
            
            break
            
            default:
                break
        }
        
        
        
        
    }

   
}

// Mark: YHAlertViewDelegate
extension ViewController:YHAlertViewDelegate{
    func alertView(alertView: YHAlertView, clickedButtonAtIndex: Int) {
        print("点击下标是:\(clickedButtonAtIndex)")
    }
}




