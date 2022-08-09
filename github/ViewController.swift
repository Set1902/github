//
//  ViewController.swift
//  github
//
//  Created by Sergei Kovalev on 08.08.2022.
//

import UIKit
import FirebaseAuth
import Firebase
class ViewController: UIViewController {

    private func showCodeValidVC () {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "Check") as! RepoViewController
        self.present(dvc, animated: true)
    }
    
    @IBOutlet weak var button: UIButton!
    
    var provider = OAuthProvider(providerID: "github.com")
    
    let defaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let name = defaults.string(forKey: "login")
        
        if name == nil {
            login1 = name!
            showCodeValidVC()
        }
        
        
                
    }


    
    func hi() {
        provider.customParameters = [
          "allow_signup": "false"
        ]
        provider.scopes = ["user:email"]
        
        provider.getCredentialWith(nil) { credential, error in
              if error != nil {
                // Handle error.
              }
              if credential != nil {
                  Auth.auth().signIn(with: credential!) { [self] authResult, error in
                  if error != nil {
                    // Handle error.
                  }
                  // User is signed in.
                  // IdP data available in authResult.additionalUserInfo.profile.
                      
                      var p = authResult?.additionalUserInfo?.profile
                      
                      
                      

                      var login = p!["login"] as? String
                      
                      
                      
                      login1 = login!
                      
                      print(login1)
                      //UserDefaults.standard.set(login1, forKey: "Key")  //Integer
                      
                      self.defaults.set(login1, forKey: "login")
                      
                      guard let oauthCredential = authResult?.credential as? OAuthCredential else { return }
                      
                      self.showCodeValidVC()
                      
                  // GitHub OAuth access token can also be retrieved by:
                  // oauthCredential.accessToken
                  // GitHub OAuth ID token can be retrieved by calling:
                  // oauthCredential.idToken
                }
              }
            }

    }
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        
        
        hi()
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}

