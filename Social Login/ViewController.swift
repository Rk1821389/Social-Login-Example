//
//  ViewController.swift
//  Social Login
//
//  Created by Manoj kumar on 31/01/23.
//

import UIKit
import FacebookLogin

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
    
    @IBAction func pressedLogin(_ sender: UIButton) {
        
        SocialLoginManager.shared.loginWithFacebook(vc: self) { [weak self] (success, error) in
            guard let self else { return }
            
            if let error {
                //Handle Error
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            if success {
                //Login Success
                SocialLoginManager.shared.fetchProfile { [weak self] (profile, error) in
                   
                    guard let self else { return }
                   
                    if let error {
                        //Handle Error
                        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        return
                    }
                    
                    
                    if let profile {
                        print(profile.firstName)
                        print(profile.lastName)
                        print(profile.email)
                        print(profile.imageURL)
                        print(profile.birthday)
                    }
                    
                }
                
                
            } else {
                //Login cancelled
                let alertController = UIAlertController(title: "Cancelled", message: "Login was cancelled", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
}

