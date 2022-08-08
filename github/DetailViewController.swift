//
//  DetailViewController.swift
//  github
//
//  Created by Sergei Kovalev on 09.08.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    
    @IBOutlet weak var Nasv: UILabel!
    
    @IBOutlet weak var Opis: UILabel!
    
    
    
    
    
    
    
    
    var user: User?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        if let user = user {
            
            
            
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
