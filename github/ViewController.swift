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
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
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
                  Auth.auth().signIn(with: credential!) { authResult, error in
                  if error != nil {
                    // Handle error.
                  }
                  // User is signed in.
                  // IdP data available in authResult.additionalUserInfo.profile.
                      
                      var p = authResult?.additionalUserInfo?.profile
                      
                      
                      

                      var login = p!["login"] as? String
                      
                      
                      
                      login1 = login!
                      
                      print(login1)
                      
                      
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

