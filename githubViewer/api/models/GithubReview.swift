//
//  GithubReview.swift
//  githubViewer
//
//  Created by Francis Beauchamp on 2018-07-10.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import SwiftyJSON

extension Github {
    struct Review {
        let status: Github.PullRequest.Status
        
        init?(json: JSON) {
            guard let status = json["state"].string else { return nil }
            guard let statusEnumValue = Github.PullRequest.Status(rawValue: status) else { return nil }
            
            self.status = statusEnumValue
        }
    }
}
