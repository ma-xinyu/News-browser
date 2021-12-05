//
//  Test.swift
//  homework1001
//
//  Created by maxinyu on 2021/5/24.
//  Copyright © 2021 mxy. All rights reserved.
//

import Foundation

class Test
{
    static func initDB()
    {
        let sqlite = SQLiteManager.sharedInstance
        
        if !sqlite.openDB() { return }
        
        let createSql = "CREATE TABLE IF NOT EXISTS news('id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, " +
        "'title' TEXT,'path' TEXT,'time' TEXT);"
        
        if !sqlite.execNoneQuerySQL(sql: createSql) { sqlite.closeDB(); return }
        
        /*let cleanAllStu = "DELETE FROM news"
        if !sqlite.execNoneQuerySQL(sql: cleanAllStu) { sqlite.closeDB(); return }*/
        
        let resetStu = "DELETE FROM sqlite_sequence WHERE name = 'news';"
        if !sqlite.execNoneQuerySQL(sql: resetStu) { sqlite.closeDB(); return }
        
        /*let stu0 = "INSERT INTO news(title,path,time) VALUES('111','zhangsan@whu.edu.cn','2000');"
        let stu1 = "INSERT INTO news(title,path,time) VALUES('李四','lisi@whu.edu.cn','2001');"
        if !sqlite.execNoneQuerySQL(sql: stu0) { sqlite.closeDB(); return }
        if !sqlite.execNoneQuerySQL(sql: stu1) { sqlite.closeDB(); return }*/
        
        sqlite.closeDB()
    }
    
    static func GetAllNews()->AnyObject
    {
        var myArray:Array<Any> = []
        
        let sqlite = SQLiteManager.sharedInstance
        
        if !sqlite.openDB() { print("error") }
        
        let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM news")
        
        for row in queryResult!
        {
            myArray.append(row)
        }
        return myArray as AnyObject
    }
    
    static func DeleteNew(idI:String)
    {
        let sqlite = SQLiteManager.sharedInstance
        
        if !sqlite.openDB() { return }
        
        if !sqlite.execNoneQuerySQL(sql: "DELETE FROM news WHERE id = '\(idI)'") { sqlite.closeDB(); return }
        
        sqlite.closeDB()
    }
    
    static func SaveNew(titleIn:String,pathIn:String,timeIn:String)
    {
        let sqlite = SQLiteManager.sharedInstance
        
        if !sqlite.openDB() { return }
        
        let new = "INSERT INTO news(title,path,time) VALUES('\(titleIn)','\(pathIn)','\(timeIn)');"
        if !sqlite.execNoneQuerySQL(sql: new) { sqlite.closeDB(); return }
        
        sqlite.closeDB();
    }
}
