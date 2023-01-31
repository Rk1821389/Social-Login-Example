//
//  SocialLoginManager.swift
//  Social Login
//
//  Created by Manoj kumar on 31/01/23.
//

import FacebookCore
import FacebookLogin
//import FBSDKCoreKit
//import FBSDKLoginKit

class SocialLoginManager {
    
    static let shared = SocialLoginManager()
    private init() { }
    
    weak var vc: ViewController?
    
    func loginWithFacebook(vc: ViewController, completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        self.vc = vc
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: vc) { [weak self] (result, error) in
            guard let self else { return }
            if let error {
                completion(false, error)
                return
            }
            
            completion(result?.isCancelled == false, nil)
            self.vc = nil
        }
    }
    
    func fetchProfile(completion: @escaping (Profile?, Error?) -> Void) {
        Profile.loadCurrentProfile { [weak self] (profile, error) in
            guard let self else { return }
            if error == nil {
                completion(profile, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
}
