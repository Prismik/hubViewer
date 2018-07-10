//
//  GithubRepo.swift
//  githubViewer
//
//  Created by Francis Beauchamp on 2018-07-09.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Github {
    struct Repo {
        let name: String
        let forked: Bool
        let isPrivate: Bool
        let owner: String

        init?(json: JSON) {
            guard let name = json["name"].string else { return nil }
            guard let forked = json["fork"].bool else { return nil }
            guard let isPrivate = json["private"].bool else { return nil }
            guard let owner = json["owner"]["login"].string else { return nil }

            self.name = name
            self.forked = forked
            self.isPrivate = isPrivate
            self.owner = owner
        }
    }
}
