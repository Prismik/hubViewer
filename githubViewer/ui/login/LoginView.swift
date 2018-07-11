//
//  LoginView.swift
//  githubViewer
//
//  Created by Francis Beauchamp on 2018-07-09.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit
import PinLayout

protocol LoginViewDelegate: class {
    func authenticate(crendentials: Github.UserCredentials)
}

class LoginView: UIView {
    weak var delegate: LoginViewDelegate?
    
    private let logoImage = UIImageView(image: UIImage(named: "default")?.withRenderingMode(.alwaysTemplate))
    private let usernameLabel = UILabel()
    private let usernameInput = TextField(frame: .zero)
    
    private let passwordLabel = UILabel()
    private let passwordInput = TextField(frame: .zero)
    private let connectButton = UIButton(frame: .zero)
    
    init() {
        super.init(frame: .zero)
        
        logoImage.contentMode = .scaleAspectFit
        logoImage.tintColor = .white
        addSubview(logoImage)

        usernameLabel.text = "Username"
        usernameLabel.textColor = .white
        usernameLabel.font = UIFont.systemFont(ofSize: 16)
        usernameLabel.sizeToFit()
        addSubview(usernameLabel)
        
        usernameInput.backgroundColor = UIColor.white
        usernameInput.layer.cornerRadius = 3
        usernameInput.textColor = UIColor.charcoal
        usernameInput.delegate = self
        usernameInput.tag = 0
        usernameInput.returnKeyType = .next
        addSubview(usernameInput)
        
        passwordLabel.text = "Password"
        passwordLabel.textColor = .white
        passwordLabel.font = UIFont.systemFont(ofSize: 16)
        passwordLabel.sizeToFit()
        addSubview(passwordLabel)
        
        passwordInput.isSecureTextEntry = true
        passwordInput.backgroundColor = UIColor.white
        passwordInput.layer.cornerRadius = 3
        passwordInput.textColor = UIColor.charcoal
        passwordInput.delegate = self
        passwordInput.tag = 1
        passwordInput.returnKeyType = .done
        addSubview(passwordInput)
        
        connectButton.setTitleColor(UIColor.white, for: .normal)
        connectButton.setTitle("Connect", for: .normal)
        connectButton.addTarget(self, action: #selector(didTapConnect), for: UIControlEvents.touchUpInside)
        addSubview(connectButton)
        
        backgroundColor = UIColor.charcoal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        logoImage.pin.top(125).hCenter().size(48)

        usernameInput.pin.center().width(175).height(26)
        usernameLabel.pin.above(of: usernameInput, aligned: .left).marginBottom(10)
        
        passwordLabel.pin.below(of: usernameInput, aligned: .left).marginTop(10)
        passwordInput.pin.below(of: passwordLabel, aligned: .left).marginTop(10).width(175).height(26)

        connectButton.pin.bottom(25).width(150).height(32).hCenter()
    }
    
    @objc
    func didTapConnect() {
        guard let username = usernameInput.text, let password = passwordInput.text else { return }
        delegate?.authenticate(crendentials: Github.UserCredentials(username: username, password: password))
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let textTag = textField.tag + 1
        guard let nextResponder = viewWithTag(textTag) else {
            endEditing(true)
            return true
        }
        
        nextResponder.becomeFirstResponder()
        return true
    }
}
