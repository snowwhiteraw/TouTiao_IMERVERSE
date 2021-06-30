//
//  FabuViewController.swift
//  TouTiaoSK17.V2
//
//  Created by SeventeenK17 on 2021/6/27.
//

import UIKit





class FabuViewController: UIViewController, UITextViewDelegate {
    
//    var textView = UITextView()
    let textView = UITextView(frame: CGRect(x:0, y:100, width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
    let imageResize = ImageResize()
    let rightBarButton = UIBarButtonItem(title: "发布", style: .plain, target: self, action: nil)
    


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        rightBarButton.tintColor = .gray
        self.navigationItem.rightBarButtonItem = rightBarButton
        configTextView()
        configToolBar()

        // Do any additional setup after loading the view.
    }

    //配置TextView
    func configTextView(){
        textView.delegate = self
        self.view.addSubview(textView)
        //字体颜色
        textView.textColor = UIColor.black
        //内容部分链接样式
        textView.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange,
                                       NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        //边框
//        textView.layer.borderColor = UIColor.red.cgColor
//        textView.layer.borderWidth = 1.5
        //字体大小
        textView.font = UIFont.systemFont(ofSize: 16)
        //内容可编辑
        textView.isEditable = true
        //内容可选
//        textView.isSelectable = true
        //边框圆角设置
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 5.0
        //自适应高度
        textView.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
        //对齐方式
        textView.textAlignment = .left
        //返回键的类型
        textView.returnKeyType = .done
        //键盘类型
        textView.keyboardType = UIKeyboardType.default
        //是否可以滚动
        textView.isScrollEnabled = true
        //给文字中的网址和电话号码自动加上链接
        textView.dataDetectorTypes = .all  //电话和网址都加
        //获得焦点后选中现有文本内容，输入内容时清除当前选中文本内容
        textView.clearsOnInsertion = true
        //选中一段文本
        textView.selectedRange = NSMakeRange(3,3 )
        
        textView.becomeFirstResponder()
        
        //默认文字
//        let placeholderTextView = KMPlaceholderTextView(frame: view.bounds)
//        placeholderTextView.placeholder = "再小的想法，都值得被记录"
//        textView.addSubview(placeholderTextView)


//        //设置富文本
//        let attributeString:NSMutableAttributedString=NSMutableAttributedString(string: "自小的想法，都值得被记录")
//
//        //设置字体颜色
//        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.gray, range: NSMakeRange(0, attributeString.length))
//
//        //文本所有字符字体HelveticaNeue-Bold，16号
//        attributeString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 16), range: NSMakeRange(0, attributeString.length))
//
//        //赋值富文本
//        textView.attributedText = attributeString
//

    }
    
    //配置ToolBar
    func configToolBar(){
        let toolBar = UIToolbar(frame: CGRect(x: 0, y:UIScreen.main.bounds.height-45 , width: UIScreen.main.bounds.width, height: 45))
//        let tb1Image = UIImage(systemName: "photo")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        let tb1Image = UIImage(systemName: "photo")
        let tb1ImageNew = imageResize.resizeImage(image: tb1Image!, width: 40).withTintColor(.red, renderingMode: .alwaysOriginal)
        let tb2Image = UIImage(systemName: "face.smiling")
        let tb2ImageNew = imageResize.resizeImage(image: tb2Image!, width: 35).withTintColor(.red, renderingMode: .alwaysOriginal)
        let tb1 = UIBarButtonItem(image: tb1ImageNew, style: .plain, target: self, action: #selector(tb1Click))
        let tb2 = UIBarButtonItem(image: tb2ImageNew, style: .plain, target: self, action: #selector(tb2Click))
        let tbSpacer1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolBar.items = [tbSpacer1,tb1,tb2]
        self.textView.inputAccessoryView = toolBar

//        self.view.addSubview(toolBar)

        }
        
        
    @objc func tb1Click(){
        
    }
    @objc func tb2Click(){
        
    }
    
    @objc func fabu(){
        print(textView.text ?? "kong")
        
    }
    

    
    //发布按钮
    func fabuButton() -> UIBarButtonItem  {
        if textView.text.isEmpty  {
            let rightBarButton = UIBarButtonItem(title: "发布", style: .plain, target: self, action: nil)
            rightBarButton.tintColor = .gray
            
            return rightBarButton

        }else{
            let rightBarButton = UIBarButtonItem(title: "发布", style: .plain, target: self, action: #selector(fabu))
            return rightBarButton

        }
    }
    func textViewDidChange(_ textView: UITextView) {
        self.navigationItem.rightBarButtonItem = fabuButton()
        
    }
}


