//
//  News.swift
//  homework1001
//
//  Created by maxinyu on 2021/5/19.
//  Copyright © 2021 mxy. All rights reserved.
//
import Foundation

//
class News:NSObject, Codable
{
    var title:String = ""
    var path:String = ""
    var passtime:String = ""
    var image:String = ""
    
    private enum CodingKeys: String, CodingKey{
        case title
        case path
        case passtime
        case image
    }
    
    init(title:String)
    {
        self.title = title
    }
    
    override var description: String {
        return "title:\(title)"
    }
}

class NewsResponse:NSObject, Codable
{
    var code:Int=0
    var result:[News] = []
    var message:String = ""
   
    private enum CodingKeys: String, CodingKey{
        case code
        case result
        case message
    }
}

class NewsManager
{
    static let shared:NewsManager = NewsManager()
    
    var news:[News] = []
    var curPage:Int = 1
    var pageSize = 10
    
    func fetchMore( complete:@escaping ()->Void) {
        curPage += 1
        fetchData(complete: complete)
    }
    
    func refresh( complete:@escaping  ()->Void)  {
        news.removeAll()
        curPage = 1
        fetchData(complete: complete)
    }
    
    private func fetchData(complete: @escaping ()->Void)
    {
        let url = URL(string: "http://zy.whu.edu.cn/news/api/news/getList?page=\(curPage)&count=\(pageSize)")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let data = data, let moreNews = try? JSONDecoder().decode(NewsResponse.self, from:data)
                {
                    moreNews.result.forEach{self.news.append($0)}
                    //print(moreNews.result)
                    Thread.sleep(forTimeInterval: 5)
                    complete()
            }
        }
        task.resume()
    }
}
