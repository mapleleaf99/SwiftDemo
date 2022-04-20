//
//  ViewController.swift
//  SwiftDemo
//
//  Created by yun on 2021/8/3.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(stackView)
//        
        stackView.addArrangedSubview(btn1)
        stackView.addArrangedSubview(btn2)
        stackView.addArrangedSubview(btn3)
        stackView.addArrangedSubview(btn4)
        
        #if TEST
        view.backgroundColor = .red
        #endif
        
        NetWork.share.getUrlWithModel(path: "/user", param: nil, token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHBpcmVUaW1lIjoiMTY1ODIxOTIzNTcwMiIsImV4cCI6MTY1ODIxOTIzNSwidXNlcklkIjoiY3Vqanhhd2kiLCJpYXQiOjE2NTA0NDMyMzV9.0w56L1DM4e3t3hfaLk4POXPkARd6nZNjl_h9aRFcZgY", type: UserInfoModel.self) { userInfoModel in
            
        
        } failure: { error in
            
        }

    }

    private lazy var stackView: UIStackView = {
        let view = UIStackView(frame: CGRect(x: 10, y: 200, width: ScreenWidth - 20, height: 200))
        view.alignment = .center
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 10
        return view
    }()
    
    private lazy var btn1: UIButton = {
        let view = UIButton()
        view.backgroundColor = .red
        return view
    }()
    
    private lazy var btn2: UIButton = {
        let view = UIButton()
        view.backgroundColor = .green
        return view
    }()

    private lazy var btn3: UIButton = {
        let view = UIButton()
        view.backgroundColor = .blue
        return view
    }()
    
    private lazy var btn4: UIButton = {
        let view = UIButton()
        view.backgroundColor = .yellow
        return view
    }()

}
