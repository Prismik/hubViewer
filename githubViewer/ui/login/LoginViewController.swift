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
    func authenticate(crendentials: GithubUserCredentials) {
        Github.authenticate(with: crendentials, handler: { (success: Bool) in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                print("sadface")
            }
        })
    }
}
