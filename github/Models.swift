//
//  Models.swift
//  github
//
//  Created by Sergei Kovalev on 08.08.2022.
//

import Foundation

var login1: String = ""

class User: NSObject {
    
    //properties of a stock
    var login: String?

    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name and @price parameters
    
    init(login: String) {
        
        self.login = login

        
    }
    
    
    //prints a stock's name and price
    
    

}


