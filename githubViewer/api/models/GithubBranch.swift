//
//  GithubBranch.swift
//  githubViewer
//
//  Created by Francis Beauchamp on 2018-07-09.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Github {
    class Branch {
        let name: String
        let lastCommitSHA: String
        var lastCommitMessage: String = ""
        
        init?(json: JSON) {
            guard let name = json["name"].string else { return nil }
            guard let sha = json["commit"]["sha"].string else { return nil }

            self.name = name
            self.lastCommitSHA = sha
        }
    }
}
