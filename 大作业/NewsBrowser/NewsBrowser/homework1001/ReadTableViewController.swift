//
//  ReadViewController.swift
//  homework1001
//
//  Created by maxinyu on 2021/5/19.
//  Copyright © 2021 mxy. All rights reserved.
//

import UIKit

class ReadTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setRefreshView()
        setMoreView()
        loadMore()
        
        let xib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "reuseIdentifier")
        tableView.rowHeight = 300
    }

    //上拉刷新视图
    func setMoreView() {
        let loadMoreView = UIView(frame: CGRect(x:0, y:self.tableView.contentSize.height,width:self.tableView.bounds.size.width, height:60))
        loadMoreView.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
        loadMoreView.backgroundColor = self.tableView.backgroundColor
        
        //添加中间的环形进度条
        let indicator = UIActivityIndicatorView()
        //indicator.color = UIColor.darkGray
        let indicatorX = self.view.frame.width/2-indicator.frame.width/2
        let indicatorY = loadMoreView.frame.size.height/2-indicator.frame.height/2
        indicator.frame = CGRect(x:indicatorX, y:indicatorY, width:indicator.frame.width, height:indicator.frame.height)
        indicator.startAnimating()
        loadMoreView.addSubview(indicator)
        self.tableView.tableFooterView = loadMoreView
    }
    
    func setRefreshView()
    {
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.refreshControl!.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        self.refreshData()   
    }
    
    // 刷新数据
    @objc func refreshData() {
        NewsManager.shared.refresh{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        self.refreshControl!.endRefreshing()
    }
    
    //加载更多数据
    func loadMore(){
        print("加载新数据！")
        NewsManager.shared.fetchMore {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // todo
        return NewsManager.shared.news.count
    }

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! NewsTableViewCell
        let new = NewsManager.shared.news[indexPath.row]
        /*cell.textLabel?.text = new.title
        cell.detailTextLabel?.text = new.passtime*/
        cell.titleLabel?.text = new.title
        cell.imagView1.downloadAsyncFrom(url: new.image)
        cell.timeLabel?.text = new.passtime
        //todo init cell
        
        //当下拉到底部，执行loadMore()
        if (indexPath.row == NewsManager.shared.news.count-1) {
            loadMore()
        }
        return cell
     }
    
        /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if let dest = segue.destination as? DetailViewController
            {
                dest.news = NewsManager.shared.news[tableView.indexPathForSelectedRow!.row]
            }
        }*/
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainstoryboard = UIStoryboard(name:"User",bundle: nil)
        let detailVC = mainstoryboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        let nav = self.navigationController
        detailVC.news = NewsManager.shared.news[tableView.indexPathForSelectedRow!.row]
        nav?.pushViewController(detailVC, animated: true)
    }
}
