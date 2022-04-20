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
        
        NetWork.share.get(path: "/user", param: nil, token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHBpcmVUaW1lIjoiMTY1NzE3Njk0MTQ1MiIsImV4cCI6MTY1NzE3Njk0MSwidXNlcklkIjoiY3Vqanhhd2kiLCJpYXQiOjE2NDk0MDA5NDF9.sJccxprnavfLZf-HqzBqz6oz0HQxQPA3sR1NcP5r63c") { dic in
            
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
