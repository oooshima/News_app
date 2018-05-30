//
//  WebView.swift
//  NEWSAPI
//
//  Created by Oshima Haruna on 2018/05/02.
//  Copyright © 2018年 Oshima Haruna. All rights reserved.
//

import UIKit

class WebView: UIViewController,UIWebViewDelegate {
    //接続するurlを生成
    var url = "https://fussan-blog.com"
    var Title = "Title"
    @IBOutlet weak var WebViewController: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegateの設定
        WebViewController.delegate = self
        
        //webViewのサイズを設定
        WebViewController.frame = self.view.bounds
        
        
        
        //リクエストの生成
        let req = URLRequest(url: URL(string: url)!)
        
        //webViewにurlを設定
        WebViewController.loadRequest(req as URLRequest)
        
        self.navigationItem.title = Title
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

