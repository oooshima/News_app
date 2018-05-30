//
//  ViewController.swift
//  NEWSAPI
//
//  Created by Oshima Haruna on 2018/05/02.
//  Copyright © 2018年 Oshima Haruna. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    var refreshControl:UIRefreshControl!
    var articles: [Article]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getArticles()
        table.dataSource = self
        table.delegate = self
        self.navigationItem.title = "NEWS一覧"
        table.tableFooterView = UIView(frame: .zero)
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "引っ張って更新")
        self.refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        //self.refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.table.addSubview(refreshControl)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getArticles() {
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v2/top-headlines?country=jp&category=business&apiKey=2e8afe29cdde49378281b0b30066d120")!)
        
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            
            if error != nil {
                print(error)
                return
            }
            
            // Article.swift
            self.articles = [Article]()
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                if let articlesFromJson = json["articles"] as? [[String : AnyObject]] {
                    for articleFromJson in articlesFromJson {
                        let article = Article()
                        if let title = articleFromJson["title"] as? String{
                            article.title = title
                        }
                        if  let url = articleFromJson["url"] as? String {
                            article.url = url
                        }
                        if let urlToImage = articleFromJson["urlToImage"] as? String {
                            article.imageUrl = urlToImage
                        }
                        self.articles?.append(article)
                    }
                }
                DispatchQueue.main.async {
                    self.table.reloadData()
                    self.refreshControl.endRefreshing()
                }
                
            } catch let error {
                print(error)
            }
            
            
        }
        
        task.resume()
        
    }
    
    @objc func refresh()
    {
        getArticles()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ArticleCellTableViewCell
        cell.title.text = self.articles?[indexPath.item].title
      
        if self.articles?[indexPath.item].imageUrl == nil{
            cell.imgView.image = UIImage(named: "noimage.png")
        }else{
            cell.imgView.downloadImage(from: (self.articles?[indexPath.item].imageUrl)!)
        }
         return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "WebView", bundle: Bundle.main)
        let secondViewController: WebView = storyboard.instantiateInitialViewController() as! WebView
        secondViewController.url = (self.articles?[indexPath.item].url)!
        secondViewController.Title = (self.articles?[indexPath.item].title)!
        self.navigationController?.pushViewController(secondViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        
        /*let storyboard: UIStoryboard = UIStoryboard(name: "WebView", bundle: nil)
        let nextView = storyboard.instantiateInitialViewController() as! WebView
        nextView.url = (self.articles?[indexPath.item].url)!
        present(nextView, animated: true, completion: nil)*/
//        //print("\(self.articles?[indexPath.item].url)が押されました")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
}

extension UIImageView {
    
    func downloadImage(from url: String){
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            
            if error != nil {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}


