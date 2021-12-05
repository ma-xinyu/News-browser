//
//  SaveTableViewController.swift
//  homework1001
//
//  Created by maxinyu on 2021/5/23.
//  Copyright © 2021 mxy. All rights reserved.
//

import UIKit

class SaveTableViewController: UITableViewController {

    var saveNews:Array<Any> = []
    var searchcontroller : UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Test.initDB()
        initSearch()
        saveNews = Test.GetAllNews() as! Array<Any>
    }

    // MARK: - Table view data source
    func initSearch()
    {
        let resultsController = SearchTableViewController()
        resultsController.AllNews = Test.GetAllNews() as! [Any]
        
        searchcontroller = UISearchController(searchResultsController: resultsController)
        let searchBar = searchcontroller.searchBar
        searchBar.scopeButtonTitles = ["标题","日期"]
        searchBar.placeholder = "Enter a search item"
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
        searchcontroller.searchResultsUpdater = resultsController
        self.definesPresentationContext = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        saveNews = Test.GetAllNews() as! Array<Any>
        return saveNews.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        saveNews = Test.GetAllNews() as! Array<Any>
        let cell = tableView.dequeueReusableCell(withIdentifier: "saveIdentifier", for: indexPath)
        let a = saveNews[indexPath.row] as! [String:Any]
        cell.textLabel?.text = a["title"] as? String
        //print(cell.textLabel?.text as Any)
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        saveNews = Test.GetAllNews() as! Array<Any>
        if editingStyle == .delete {
            // Delete the row from the data source
            let a = saveNews[indexPath.row] as! [String:Any]
            let id = a["id"]
            let b = "\(id ?? 0)"
            
            saveNews.remove(at: indexPath.row)
            Test.DeleteNew(idI: b)
            let nav = tabBarController?.viewControllers?[1] as? UINavigationController
            nav?.tabBarItem.badgeValue = "\(saveNews.count)"
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Override to support editing the table view.
    /*override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        saveNews = Test.GetAllNews() as! Array<Any>
        /*let a = saveNews[indexPath.row] as! [String:Any]
        let b = a["id"] as? String
        print(type(of:b))*/
        if editingStyle == .delete {
            // Delete the row from the data source
            saveNews.remove(at: indexPath.row)
            //Test.DeleteNew(idI:b)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }*/
    
    //查看收藏新闻
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? SaveViewController
        {
            //saveNews = Test.GetAllNews() as! Array<Any>
            dest.savenews = saveNews[tableView.indexPathForSelectedRow!.row] as? [String : Any]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    /*func refresh(_ tableView: UITableView)
    {
        tableView.reloadData()
    }*/
}
