//
//  DetailViewController.swift
//  homework1001
//
//  Created by maxinyu on 2021/5/19.
//  Copyright © 2021 mxy. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var news:News?
    @IBOutlet weak var NewWeb: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Test.initDB()
        if let new = self.news
        {
            NewWeb.load(NSURLRequest(url: NSURL(string: new.path)! as URL) as URLRequest)
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func SaveButton(_ sender: Any) {
        Test.SaveNew(titleIn: news!.title, pathIn: news!.path, timeIn: news!.passtime)
        let saveNews = Test.GetAllNews() as! Array<Any>
        //print(saveNews)
        let nav = tabBarController?.viewControllers?[1] as? UINavigationController
        nav?.tabBarItem.badgeValue = "\(saveNews.count)"    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
