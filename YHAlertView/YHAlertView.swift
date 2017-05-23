//
//  YHAlertView.swift
//  YHAlertView
//
//  Created by samuelandkevin on 2017/5/12.
//  Copyright © 2017年 samuelandkevin. All rights reserved.
//  https://github.com/samuelandkevin/YHAlertView

import Foundation
import UIKit

typealias YHAlertViewClickButtonBlock = ((_ alertView:YHAlertView,_ buttonIndex:Int)->Void)?

enum YHAlertAnimationOptions {
    case none
    case zoom        // 先放大，再缩小，在还原
    case topToCenter // 从上到中间
}


protocol YHAlertViewDelegate {
    // Called when a button is clicked. The view will be automatically dismissed after this call returns
    func alertView(alertView:YHAlertView,clickedButtonAtIndex:Int)
}

class YHAlertView : UIView{
    
    // MARK: - Public Property
    public var delegate : YHAlertViewDelegate?//weak
    public var animationOption:YHAlertAnimationOptions = .none
    // background visual
    public var visual = false {
        willSet(newValue){
            if newValue == true {
                _effectView.backgroundColor = UIColor.clear
            }else {
                _effectView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 102.0/255)
            }
        }
        
    }
    // backgroudColor visual
    public var visualBGColor = UIColor(red: 0, green: 0, blue: 0, alpha: 102.0/255) {
        willSet(newValue){
             _effectView.backgroundColor = newValue
        }
    }
    
    // MARK: - Private Property
    /** 1.视图的宽高 */
    private let _screenWidth  = UIScreen.main.bounds.size.width
    private let _screenHeight = UIScreen.main.bounds.size.height
    private let _contentWidth:CGFloat  = 270.0
    private let _contentHeight:CGFloat = 88.0
    
    /** 2.视图容器 */
    private var _contentView:UIView!
    /** 3.标题视图 */
    private var _labelTitle:UILabel!
    /** 4.内容视图 */
    private var _labelMessage:UILabel!
    /** 5.处理delegate传值 */
    private var _arrayButton:[UIButton] = []
    /** 6.虚化视图 */
    private var _effectView:UIVisualEffectView!
    
    /** 7.显示的数据 */
    private var _title:String!
    private var _message:String?
    
    private var _cancelButtonTitle:String?
    private var _otherButtonTitles:[String] = []
    private var _clickButtonBlock:YHAlertViewClickButtonBlock
    
    // MARK: - init
    override init(frame: CGRect) {
        _contentView        = UIView()
        _contentView.frame  = CGRect(x: 0.0, y: 0.0, width: _contentWidth, height: _contentHeight)
        _contentView.center = CGPoint(x: _screenWidth/2, y: _screenHeight/2)
        _contentView.backgroundColor = UIColor.white
        _contentView.layer.cornerRadius  = 10
        _contentView.layer.masksToBounds = true
        _contentView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin,.flexibleLeftMargin,.flexibleRightMargin]
        
        
        _labelTitle       = UILabel()
        _labelTitle.frame = CGRect(x: 16, y: 22, width: _contentWidth-32, height: 0)
        _labelTitle.textColor = UIColor.black
        _labelTitle.textAlignment = .center
        _labelTitle.numberOfLines = 0
        _labelTitle.font = UIFont.systemFont(ofSize: 17)
        
        
        _labelMessage       = UILabel()
        _labelMessage.frame = CGRect(x: 16, y: 22, width: _contentWidth-32, height: 0)
        _labelMessage.textColor = UIColor.black
        _labelMessage.textAlignment = .center
        _labelMessage.numberOfLines = 0
        _labelMessage.font = UIFont.systemFont(ofSize: 13)
        
        _effectView        = UIVisualEffectView()
        _effectView.frame  = CGRect(x: 0, y: 0, width: _screenWidth, height: _screenHeight)
        _effectView.effect = nil
        _effectView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    public convenience init(title:String,message:String?,delegate:YHAlertViewDelegate?,cancelButtonTitle:String?,otherButtonTitles:[String]){
        
        self.init()
        
        _arrayButton    = [UIButton]()
        
        //标题
        _title          = title
        _labelTitle.text   = _title
        
        let labelX:CGFloat = 16
        let labelY:CGFloat = 20
        let labelW:CGFloat = _contentWidth - 2*labelX
        _labelTitle.sizeToFit()
        
        let size = _labelTitle.frame.size
        _labelTitle.frame = CGRect(x: labelX, y: labelY, width: labelW, height: size.height)
        
        
        //消息
        _message        = message

        _labelMessage.text = _message
        _labelMessage.sizeToFit()
        let sizeMessage = _labelMessage.frame.size
        _labelMessage.frame = CGRect(x: labelX, y: _labelTitle.frame.maxY+5, width: labelW, height: sizeMessage.height)
        
        
        self.delegate   = delegate
        animationOption = .none
        _cancelButtonTitle = cancelButtonTitle
       
        
        for eachObject in otherButtonTitles{
            _otherButtonTitles.append(eachObject)
        }
        
        _setupDefault()
        _setupButton()
        
    }
    
    open class func show(title:String,message:String?,cancelButtonTitle:String?,otherButtonTitles:String ... ,clickButtonBlock:YHAlertViewClickButtonBlock){
        let alertView = YHAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: cancelButtonTitle, otherButtonTitles: otherButtonTitles)
        alertView._clickButtonBlock = clickButtonBlock
        alertView.show()
    }
    
    open class func show(title:String,message:String?,cancelButtonTitle:String?,otherButtonTitle:String,clickButtonBlock:YHAlertViewClickButtonBlock){
       
        let alertView = YHAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: cancelButtonTitle, otherButtonTitles: [otherButtonTitle])
        alertView._clickButtonBlock = clickButtonBlock
        alertView.show()
    }
    
    // shows popup alert animated.
    open func show(){
        
        UIApplication.shared.keyWindow?.addSubview(self)
        
        switch animationOption {
            
            case .none:
                _contentView.alpha = 0.0
                UIView.animate(withDuration: 0.34, animations: { [unowned self] in
                    if self.visual == true {
                        self._effectView.effect = UIBlurEffect(style: .dark)
                    }
                    self._contentView.alpha = 1.0
                })
            break
                
            case .zoom:
                
                self._contentView.layer.setValue(0, forKeyPath: "transform.scale")
                UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
                    [unowned self] in
                    if self.visual == true {
                        self._effectView.effect = UIBlurEffect(style: .dark)
                    }
                    self._contentView.layer.setValue(1.0, forKeyPath: "transform.scale")
                }, completion: { _ in
                    
                })

                break
            case .topToCenter:
                
                let startPoint = CGPoint(x: center.x, y: _contentView.frame.height)
                _contentView.layer.position = startPoint
                
                UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: { [unowned self] in
                    if self.visual == true {
                        self._effectView.effect = UIBlurEffect(style: .dark)
                    }
                    self._contentView.layer.position = self.center
                }, completion: { _ in
                    
                })
        
                break
         
        }

    }
    
    
    // MARK: - Private Method
    fileprivate func _setupDefault(){
        frame = CGRect(x: 0, y: 0, width: _screenWidth, height: _screenHeight)
        self.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        backgroundColor  = UIColor.clear
        visual = true
        animationOption = .zoom
        addSubview(_effectView)
        addSubview(_contentView)
        _contentView.backgroundColor = UIColor.white
        _contentView.addSubview(_labelTitle)
        _contentView.addSubview(_labelMessage)
    }
    
    
    private func _setupButton(){

        let buttonY  = _labelMessage.frame.maxY + 20
        var countRow = 0
        
        if _cancelButtonTitle?.isEmpty == false {
            countRow = 1;
        }
        countRow += _otherButtonTitles.count
        
        switch countRow {
            case 0:
                
                _contentView.addSubview(_button(frame: CGRect(x: 0, y: buttonY, width: _contentWidth, height:_contentHeight/2), title: "", target: self, action: #selector(_clickCancel(sender:))))
               let height = _contentHeight/2 + buttonY
                _contentView.frame = CGRect(x: 0, y: 0, width:_contentWidth, height: height)
                _contentView.center = self.center
    
            break
            
            case 2:
        
                var titleCancel:String
                var titleOther:String
                if _cancelButtonTitle?.isEmpty == false {
                    titleCancel = _cancelButtonTitle ?? ""
                    titleOther  = _otherButtonTitles[0]
                }else {
                    titleCancel = _otherButtonTitles[0]
                    titleOther  = _otherButtonTitles.last!
                }
               
                let buttonCancel = _button(frame:  CGRect(x: 0, y: buttonY, width: _contentWidth/2, height: _contentHeight/2), title: titleCancel, target: target, action: #selector(_clickCancel(sender:)))
                let buttonOther = _button(frame: CGRect(x: _contentWidth/2, y: buttonY, width: _contentWidth/2, height: _contentHeight/2), title: titleOther, target: self, action: #selector(_clickOther(sender:)))
                _contentView.addSubview(buttonOther)
                _contentView.addSubview(buttonCancel)
            
                let height = _contentHeight/2 + buttonY
                _contentView.frame = CGRect(x: 0, y: 0, width: _contentWidth, height: height)
                _contentView.center = self.center
        
            break
        default:
            
            for number in 0..<countRow {
                var title = ""
                var selector:Selector
                if _otherButtonTitles.count > number {
                    title = _otherButtonTitles[number]
                    selector = #selector(_clickOther(sender:))
                }else{
                    title = _cancelButtonTitle ?? ""
                    selector = #selector(_clickCancel(sender:))
                }
                let button = _button(frame: CGRect(x: 0, y: (CGFloat(number)*_contentHeight/2 + buttonY), width: _contentWidth, height: _contentHeight/2), title: title, target: self, action: selector)
                _arrayButton.append(button)
                _contentView.addSubview(button)
            }
            
            var height = _contentHeight/2 + buttonY
            if countRow > 2 {
                height = CGFloat(countRow) * (_contentHeight/2) + buttonY
            }
            _contentView.frame = CGRect(x: 0, y: 0, width: _contentWidth, height: height)
            _contentView.center = self.center
       
            break
        }
    }
    
    
    
    private func _image(color:UIColor) -> UIImage?{
    
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    private func _button(frame:CGRect,title:String,target:Any,action:Selector) -> UIButton{
        let button = UIButton(type: .custom)
        button.frame = frame
        button.setTitleColor(UIColor.init(red: 70.0/255, green: 130.0/255, blue: 233.0/255, alpha: 1.0), for: .normal)
        button.setTitle(title, for: .normal)
        button.setBackgroundImage(_image(color: UIColor.init(red: 235.0/255, green: 235.0/255, blue: 235.0/255, alpha: 1.0)), for: .highlighted)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(target, action: action, for: .touchUpInside)
        let lineUp = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 0.5))
        lineUp.backgroundColor = UIColor.init(red: 219.0/255, green: 219.0/255, blue: 219.0/255, alpha: 1.0)
        let lineRight = UIView(frame: CGRect(x: frame.size.width, y:  0, width: 0.5, height: frame.size.height))
        lineRight.backgroundColor = UIColor.init(red: 219.0/255, green: 219.0/255, blue: 219.0/255, alpha: 1.0)
        button.addSubview(lineUp)
        button.addSubview(lineRight)
        return button
    }
    
    private func _remove(){
        
            switch animationOption {
                case .none:
                    
                    UIView.animate(withDuration: 0.3, animations: { 
                        [unowned self] in
                        if self.visual == true {
                            self._effectView.effect = nil
                        }
                        self._contentView.alpha = 0.0
                        }, completion: { [unowned self] (finished:Bool) in
                         
                        self.removeFromSuperview()
                    })
                 
                break
                    
                case .zoom:
                    UIView.animate(withDuration: 0.3, animations: {
                        self._contentView.alpha = 0.0
                        if self.visual == true {
                            self._effectView.effect = nil
                        }
                        
                    }, completion: { [unowned self] (finished:Bool) in
                        self.removeFromSuperview()
                    })

                break
                case .topToCenter:
                    let endPoint = CGPoint(x: center.x, y: frame.height+_contentView.frame.height)
                    UIView.animate(withDuration: 0.3, animations: {
                        if self.visual == true {
                            self._effectView.effect = nil
                        }
                        self._contentView.layer.position = endPoint
                    }, completion: {[unowned self] (finished:Bool)in
                        self.removeFromSuperview()
                    })

                break

            }

    }
    
    // MARK: - Action
    func _clickOther(sender:UIButton){
        var buttonIndex:Int = 0
        if _cancelButtonTitle?.isEmpty == false {
            buttonIndex = 1
        }
        if _arrayButton.count > 0 {
            buttonIndex += _arrayButton.index(of: sender) ?? 0
        }
     
        delegate?.alertView(alertView: self, clickedButtonAtIndex: buttonIndex)
        if let aBlock = _clickButtonBlock {
            aBlock(self,buttonIndex)
        }
        _remove()

    }

     func _clickCancel(sender:UIButton){

        delegate?.alertView(alertView: self, clickedButtonAtIndex: 0)
        if let aBlock = _clickButtonBlock {
            aBlock(self,0)
        }
        _remove()

    }
    
    // MARK: - Life 
    deinit {
//        let filename = URL(string:"\(#file)")?.lastPathComponent ?? ""
//        debugPrint("\(filename) 第 \(#line) 行  ,\(#function)")
    }
}



