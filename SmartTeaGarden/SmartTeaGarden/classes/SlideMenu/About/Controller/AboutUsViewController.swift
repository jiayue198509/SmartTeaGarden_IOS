//
//  CCAboutUsViewController.swift
//  CaiCai
//
//  Created by jiaerdong on 16/10/11.
//  Copyright © 2016年 Dale. All rights reserved.
//

import Foundation
import UIKit

class AboutUsViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    var plantID:Int?
    var plantName:String?
    var greenUrl:NSString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavi()
        self.customWebView()
        self.loadWebPage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func setupNavi() {
        self.title = "关于我们"
    }
    
    func customWebView() {
        self.webView.backgroundColor=UIColor.gray
        self.webView.scrollView.delegate = self
        self.webView.scrollView.showsVerticalScrollIndicator = false
        self.automaticallyAdjustsScrollViewInsets = false;
        for subView in self.webView.subviews{
            if subView is UIScrollView
            {
                let subsub = subView as! UIScrollView
                subsub.bounces = false
                for scrollView in subsub.subviews
                {
                    if scrollView is UIImageView
                    {
                        scrollView.isHidden = true
                    }
                }
            }
        }
    }
    
    
    func loadWebPage() {
        
        // 本地html路径
        let path:String = Bundle.main.path(forResource: "introduce", ofType: "html")!
        // 转换路径为请求url
        let url = NSURL.fileURL(withPath: path)
        self.webView.loadRequest(NSURLRequest(url: url) as URLRequest)
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y > 0) {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            
        }
    }
}
