//
//  RepoViewController.swift
//  github
//
//  Created by Sergei Kovalev on 08.08.2022.
//

import UIKit
import FirebaseAuth
class RepoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FeedModelProtocol {

    
    @IBOutlet weak var stockResultFeed: UITableView!
    
    
    
    
    @IBOutlet weak var Lable: UILabel!
    
    
    var feedItems: NSArray = NSArray()
    var selectedStock : User = User()
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Lable.text = login1
        
        up1()
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        return feedItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Retrieve cell
        let cellIdentifier: String = "stockCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the stock to be shown
        let item: User = feedItems[indexPath.row] as! User
        // Configure our cell title made up of name and price
        var titleStr: String = item.name!
        //print(item.forks)
        //print("lll\(login1)")
        
        // Get references to labels of cell
        myCell.textLabel!.text = titleStr
        
        return myCell
    }
    
    
    
    func itemsDownloaded1(items: NSArray) {
        
        feedItems = items
        self.stockResultFeed.reloadData()
    }
    
    
    
    
    func up1 () {
        self.stockResultFeed.delegate = self
        self.stockResultFeed.dataSource = self
        
        let feedModel = FeedModel()
        feedModel.delegate = self
        feedModel.downloadItems()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "Show1" else {return}
        
        let navController = segue.destination as! UINavigationController
        
       let todoViewController = navController.topViewController as! DetailViewController
        guard let newIndexPath = stockResultFeed.indexPathForSelectedRow else {return}
        let selectedUser: User = feedItems[newIndexPath.row] as! User
       todoViewController.user = selectedUser
    }
    
    
    @IBAction func unwindToRepo(unwindSegue: UIStoryboardSegue) {

        
        
    }
    
    
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        
        
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
        
        
    }
    
    
    

}
