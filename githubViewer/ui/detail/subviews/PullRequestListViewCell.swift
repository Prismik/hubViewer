//
//  PullRequestListViewCell.swift
//  githubViewer
//
//  Created by Francis Beauchamp on 2018-07-10.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

struct PullRequestListItemViewData {
    let number: String
    let name: String
}

class PullRequestListViewCell: UITableViewCell {
    static let reuseIdentifier = "PullRequestListViewCellReuseIdentifier"

    private let numberLabel = UILabel()
    private let nameLabel = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        numberLabel.font = UIFont.systemFont(ofSize: 12)
        numberLabel.textColor = UIColor.charcoal
        addSubview(numberLabel)
        
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.textColor = UIColor.charcoal
        addSubview(nameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(viewData: PullRequestListItemViewData) {
        numberLabel.text = viewData.number
        numberLabel.sizeToFit()
        
        nameLabel.text = viewData.name
        nameLabel.sizeToFit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        numberLabel.pin.vCenter().left(10)
        nameLabel.pin.below(of: numberLabel).marginTop(5)
    }
}
