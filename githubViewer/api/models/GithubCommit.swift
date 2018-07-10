//
//  GithubCommit.swift
//  githubViewer
//
//  Created by Francis Beauchamp on 2018-07-10.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

extension Github {
    struct Commit {
        let sha: String
        let message: String
        
        init?(json: JSON) {
            guard let sha = json["sha"].string else { return nil }
            guard let message = json["commit"]["message"].string else { return nil }
            
            self.sha = sha
            self.message = message
        }
    }
}
