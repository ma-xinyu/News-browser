//
//  UIImageViewExtension.swift
//  homework1001
//
//  Created by maxinyu on 2021/5/19.
//  Copyright © 2021 mxy. All rights reserved.
//

import UIKit

extension UIImageView{
    
    func downloadAsyncFrom(url:String){
        
        let urlNet = URL(string:url)
        let task = URLSession.shared.dataTask(with: urlNet!)
        {
            (data,response,error)in
            if let nsd = data{
                DispatchQueue.main.async {
                    self.image = UIImage(data:nsd,scale:1)
                    self.contentMode = .scaleAspectFit
                }
            }
        }
        task.resume()
    }
}
