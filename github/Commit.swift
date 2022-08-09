//
//  Commit.swift
//  github
//
//  Created by Sergei Kovalev on 09.08.2022.
//

import Foundation




class Commit: NSObject {
    
    //properties of a stock
    var sha: String?
    var comMess: String?
    var Author: String?
    var Date: String?


    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name and @price parameters
    
    init(sha: String, comMess: String, Author: String, Date: String) {
        
        self.sha = sha
        self.comMess = comMess
        self.Author = Author
        self.Date = Date

        
    }
    
    
    //prints a stock's name and price
    
    

}
