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
    class PullRequest {
        enum Status: String {
            case unknown = "unknown"
            case open = "open"
            case pending = "PENDING"
            case approved = "APPROVE"
            case rejected = "REQUEST_CHANGES"
        }
        
        let number: Int
        let name: String
        let message: String
        private(set) var status: Github.PullRequest.Status = .unknown
        private let stateValue: String
        
        init?(json: JSON) {
            guard let number = json["number"].int else { return nil }
            guard let title = json["title"].string else { return nil }
            guard let message = json["body"].string else { return nil }
            guard let state = json["state"].string else { return nil }

            self.number = number
            self.name = title
            self.message = message
            self.stateValue = state
        }
        
        // Github does not make it straightforward to get the PR status. We must go fetch the reviews and then
        // mix the state from the PR with the status from the last review.
        func computeStatus(review: Github.Review?) {
            if let state = Github.PullRequest.Status(rawValue: stateValue), state == .open {
                self.status = state
                return
            }

            guard let review = review else {
                self.status = .open
                return
            }
            
            self.status = review.status
        }
    }
}
