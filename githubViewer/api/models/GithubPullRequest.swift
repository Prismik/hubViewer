//
//  GithubPullRequest.swift
//  githubViewer
//
//  Created by Francis Beauchamp on 2018-07-09.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Github {
    struct PullRequest {
        enum Status: String {
            case open = "open"
            case pending = "PENDING"
            case approved = "APPROVE"
            case rejected = "REQUEST_CHANGES"
        }
        
        let number: Int
        let name: String
        let message: String
        let status: Github.PullRequest.Status
        
        init?(PRJson: JSON, reviewsJSON: JSON) {
            guard let number = PRJson["number"].int else { return nil }
            guard let title = PRJson["title"].string else { return nil }
            guard let message = PRJson["body"].string else { return nil }
            guard let state = PRJson["state"].string else { return nil }

            self.number = number
            self.name = title
            self.message = message
            self.status = Github.PullRequest.parseStatus(value: state, reviews: reviewsJSON)
        }
        
        private static func parseStatus(value: String, reviews: JSON) -> Github.PullRequest.Status {
            if let state = Github.PullRequest.Status(rawValue: value), state == .open {
                return state
            }
            
            // this one is different, we must see the last review and check if it is approved or not
            guard let reviews = reviews.array, let lastReview = reviews.last else { return .open }
            let reviewStatus = lastReview["state"].stringValue
            guard let state = Github.PullRequest.Status(rawValue: reviewStatus) else { return .pending }
            return state
        }
    }
}
