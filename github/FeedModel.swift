//
//  FeedModel1.swift
//  github
//
//  Created by Sergei Kovalev on 08.08.2022.
//

import Foundation

protocol FeedModelProtocol: class {
    func itemsDownloaded1(items: NSArray)
}


class FeedModel: NSObject, URLSessionDataDelegate {
    
    
    
    weak var delegate: FeedModelProtocol!
    
    let urlPath = "https://api.github.com/users/\(login1)/repos"
    
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Error")
            }else {
                print("stocks downloaded")
                self.parseJSON(data!)
            }
            
        }
        
        task.resume()
    }

    func parseJSON(_ data:Data) {
            
            var jsonResult = NSArray()
            
            do{
                jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
                
            } catch let error as NSError {
                print(error)
                
            }
            
            var jsonElement = NSDictionary()
            let stocks = NSMutableArray()
            print(jsonResult)
            for i in 0 ..< jsonResult.count
            {
                
                jsonElement = jsonResult[i] as! NSDictionary
                
                let stock = User()
                
                //the following insures none of the JsonElement values are nil through optional binding
                  let name = jsonElement["name"] as? String
                    let forks = jsonElement["forks"] as? Int
                    let watchers = jsonElement["watchers"] as? Int
                    let description = jsonElement["description"] as? String
                let owner = jsonElement["owner"] as? NSDictionary
                let image = owner!["avatar_url"] as? String
                let login = owner!["login"] as? String
                
                    
                    stock.name = name
                    stock.forks = forks
                    stock.watchers = watchers
                    stock.description1 = description
                stock.image = image
                stock.login = login
                    
                   
                    
                
                
                stocks.add(stock)
                
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                print(self.delegate)
                self.delegate.itemsDownloaded1(items: stocks)
                
            })
        }
    }

