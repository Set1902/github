//
//  Models.swift
//  github
//
//  Created by Sergei Kovalev on 08.08.2022.
//

import Foundation
import UIKit
var login1: String = ""

class User: NSObject {
    
    //properties of a stock
    var name: String?
    var forks: Int?
    var watchers: Int?
    var description1: String?
    var image: String?

    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name and @price parameters
    
    init(name: String, forks: Int, watchers: Int, description: String, image: String) {
        
        self.name = name
        self.forks = forks
        self.watchers = watchers
        self.description1 = description
        self.image = image
        
    }
    
    
    //prints a stock's name and price
    
    

}


