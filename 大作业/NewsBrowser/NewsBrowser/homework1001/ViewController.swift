//
//  ViewController.swift
//  homework1001
//
//  Created by maxinyu on 2021/5/11.
//  Copyright © 2021 mxy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let defaults = UserDefaults.standard
    
    @IBOutlet weak var name_preference: UITextField!
    @IBOutlet weak var password_preference: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaults.set("2019302080309", forKey: "username")
        name_preference.text = defaults.string(forKey: "username")
        // Do any additional setup after loading the view.
        password_preference.isSecureTextEntry = true
        
    }
    
    
    @IBAction func UserLogin(_ sender: Any) {
        if name_preference.text == "2019302080309" && password_preference.text == "123"
                {
                    let mainBoard:UIStoryboard! = UIStoryboard(name:"User",bundle:nil)
                    let VCMain = mainBoard!.instantiateViewController(withIdentifier:"vcUser")
                    
                    UIApplication.shared.windows[0].rootViewController = VCMain
                }
                else
                {
                    let p = UIAlertController(title:"登录失败",message:"用户名或密码错误",preferredStyle: .alert)
                    p.addAction(UIAlertAction(title:"确认", style: .default,
                    handler:{(
                      act:UIAlertAction) in
                      self.password_preference.text = ""}
                      ))
                    present(p, animated:false, completion: nil)
                }
            }
        
    }
