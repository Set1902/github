//
//  DetailViewController.swift
//  github
//
//  Created by Sergei Kovalev on 09.08.2022.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    
    var feedItems: NSArray = NSArray()
    
    @IBOutlet weak var stockResult: UITableView!
    
    
    
    
    
    @IBOutlet weak var ImageView: UIImageView!
    
    
    @IBOutlet weak var Opis: UILabel!
    
    
    @IBOutlet weak var Author: UILabel!
    
    
    @IBOutlet weak var forks: UILabel!
    
    
    @IBOutlet weak var watches: UILabel!
    
    
    var user: User?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.stockResult.dataSource = self
        if let user1 = user {
            getCommits(user: user1)
            self.title = user1.name!
                        if user1.description1 == nil {
                Opis.text = "Описания нет"
            } else {
                Opis.text = user1.description1!

            }
            forks.text = String("forks: \(user1.forks!)")
            watches.text = String("watches: \(user1.watchers!)")
            Author.text = "Author: \(login1)"
            
            setImage(from: user1.image!)

        }
        
        
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        return feedItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Retrieve cell
        let cellIdentifier: String = "Shew"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        
        let item: Commit = feedItems[indexPath.row] as! Commit
        

        
        
        // Get references to labels of cell
        myCell.textLabel!.text = item.sha!
        
        return myCell
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.ImageView.image = image
            }
        }
    }
    
    
    
    
    
    
    func getCommits(user: User) {
        
        
        
        let urlPath = "https://api.github.com/repos/\(user.login!)/\(user.name!)/commits"
        

            
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
                
                let stock = Commit()
                
                //the following insures none of the JsonElement values are nil through optional binding
                  let sha = jsonElement["sha"] as? String
                    let commit = jsonElement["commit"] as? NSDictionary
                let message = commit!["message"] as? String
                    let author = commit!["author"] as? NSDictionary
                let name = author!["name"] as? String
                let date = author!["date"] as? String
                
                    
                stock.sha = sha
                stock.comMess = message
                stock.Author = name
                stock.Date = date
                    
                    
                   
                    
                
                
                stocks.add(stock)
                
            }
            
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.itemsDownloaded(items: stocks)
            
        })
            
        }
    
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        self.stockResult.reloadData()
    }
    

}
