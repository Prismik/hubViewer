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
    let message: String
    let statusColor: UIColor
    
    init(number: Int, name: String, message: String, status: Github.PullRequest.Status) {
        self.number = "Pull request #\(number)"
        self.name = name
        self.message = message
        self.statusColor = {
            switch status {
            case .unknown:
                return UIColor.charcoal
            case .approved:
                return UIColor.rgb(r: 80, g: 250, b: 123)
            case .open, .pending:
                return UIColor.rgb(r: 241, g: 251, b: 139)
            case .rejected:
                return UIColor.rgb(r: 246, g: 67, b: 70)
            }
        }()
    }
}

class PullRequestListViewCell: UITableViewCell {
    static let reuseIdentifier = "PullRequestListViewCellReuseIdentifier"

    private let numberLabel = UILabel()
    private let nameLabel = UILabel()
    private let messageLabel = UILabel()
    private let statusIndicator = UIView()
    private let spacer = UIView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        numberLabel.font = UIFont.boldSystemFont(ofSize: 14)
        numberLabel.textColor = UIColor.white.withAlphaComponent(0.7)
        addSubview(numberLabel)
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel.textColor = UIColor.white
        addSubview(nameLabel)
        
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.textColor = UIColor.white
        messageLabel.numberOfLines = 0
        addSubview(messageLabel)
        
        statusIndicator.layer.cornerRadius = 5
        addSubview(statusIndicator)
        
        spacer.backgroundColor = UIColor.harleyOrange
        addSubview(spacer)

        backgroundColor = UIColor.charcoal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(viewData: PullRequestListItemViewData) {
        numberLabel.text = viewData.number
        numberLabel.sizeToFit()
        
        nameLabel.text = viewData.name
        nameLabel.sizeToFit()
        
        messageLabel.text = viewData.message
        messageLabel.sizeToFit()
        statusIndicator.backgroundColor = viewData.statusColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        numberLabel.pin.top(10).left(10).right(30)
        nameLabel.pin.below(of: numberLabel, aligned: .left).marginTop(5).right(30)
        messageLabel.pin.below(of: nameLabel, aligned: .left).marginTop(5).right(30)
        spacer.pin.bottom().horizontally().height(2)
        statusIndicator.pin.right(10).size(10).vCenter()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let numberHeight = numberLabel.sizeThatFits(CGSize(width: size.width - 25, height: size.height)).height
        let nameHeight = nameLabel.sizeThatFits(CGSize(width: size.width - 25, height: size.height)).height
        let messageHeight = messageLabel.sizeThatFits(CGSize(width: size.width - 25, height: size.height)).height
        return CGSize(width: size.width, height: 10 + numberHeight + 5 + nameHeight + 5 + messageHeight + 12)
    }
}
