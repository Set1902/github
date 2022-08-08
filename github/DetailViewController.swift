//
//  DetailViewController.swift
//  github
//
//  Created by Sergei Kovalev on 09.08.2022.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    
    @IBOutlet weak var ImageView: UIImageView!
    
    
    @IBOutlet weak var Opis: UILabel!
    
    
    @IBOutlet weak var Author: UILabel!
    
    
    @IBOutlet weak var forks: UILabel!
    
    
    @IBOutlet weak var watches: UILabel!
    
    
    var user: User?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        if let user1 = user {
            self.title = user1.name!
                        if user1.description1 == nil {
                Opis.text = "Описания нет"
            } else {
                Opis.text = user1.description1!

            }
            forks.text = String("forks: \(user1.forks!)")
            watches.text = String("watches: \(user1.watchers!)")
            
            setImage(from: user1.image!)

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

}
