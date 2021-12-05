//
//  SearchTableViewController.swift
//  homework1001
//
//  Created by maxinyu on 2021/5/25.
//  Copyright © 2021 mxy. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController,UISearchResultsUpdating {

    var AllNews:[Any] = []
    var ResultNews:[Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "saveIdentifier")
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchString = searchController.searchBar.text else {return}
        if searchString.isEmpty {return}
        AllNews = Test.GetAllNews() as! [Any]
        
        switch searchController.searchBar.selectedScopeButtonIndex {
        case 0:
            ResultNews = AllNews.filter{ (AllNew) -> Bool in
                let a = AllNew as! [String:Any]
                let sa = a["title"] as! String
                return sa.contains(searchString)}
        case 1:
            ResultNews = AllNews.filter{ (AllNew) -> Bool in
                let a = AllNew as! [String:Any]
                let sa = a["time"] as! String
                return sa.contains(searchString)}
        default:
            return
        }
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ResultNews.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "saveIdentifier", for: indexPath)
        let a = ResultNews[indexPath.row] as! [String:Any]
        cell.textLabel?.text = a["title"] as? String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mainstoryboard = UIStoryboard(name:"User",bundle: nil)
        let SaveVC = mainstoryboard.instantiateViewController(withIdentifier: "SaveVC") as! SaveViewController
        let nav = self.presentingViewController?.navigationController
        SaveVC.savenews = ResultNews[indexPath.row] as? [String : Any]
        nav?.pushViewController(SaveVC, animated: true)
    }
}
