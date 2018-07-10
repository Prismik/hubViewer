//
//  PullRequestListViewCell.swift
//  githubViewer
//
//  Created by Francis Beauchamp on 2018-07-10.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

struct PullRequestListItemViewData {
    
}

class PullRequestListViewCell: UITableViewCell {
    static let reuseIdentifier = "PullRequestListViewCellReuseIdentifier"

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(viewData: PullRequestListItemViewData) {
        
    }
}
