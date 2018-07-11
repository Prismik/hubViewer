//
//  LoginViewController.swift
//  githubViewer
//
//  Created by Francis Beauchamp on 2018-07-09.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    var mainView: LoginView {
        return view as! LoginView
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let loginView = LoginView()
        loginView.delegate = self
        view = loginView
    }
}

extension LoginViewController: LoginViewDelegate {
    func authenticate(crendentials: Github.UserCredentials) {
        Github.authenticate(with: crendentials, handler: { [weak self] (success: Bool) in
            guard let strongSelf = self else { return }
            if success {
                strongSelf.dismiss(animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Invalid credentials", message: "We could not access your Github information with the credentials you provided. Please try again.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                strongSelf.present(alert, animated: true, completion: nil)
            }
        })
    }
}
