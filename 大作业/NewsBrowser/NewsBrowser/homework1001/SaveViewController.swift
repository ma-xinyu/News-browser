//
//  SaveViewController.swift
//  homework1001
//
//  Created by maxinyu on 2021/5/25.
//  Copyright © 2021 mxy. All rights reserved.
//

import UIKit
import WebKit

class SaveViewController: UIViewController {

    var savenews:[String:Any]?

    @IBOutlet weak var SaveNewWeb: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let SaveNew = self.savenews
        {
            let SaveUrl = SaveNew["path"] as! String
            SaveNewWeb.load(NSURLRequest(url: NSURL(string: SaveUrl) as! URL) as URLRequest)
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
