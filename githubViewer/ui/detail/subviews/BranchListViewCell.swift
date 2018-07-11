//
//  BranchListViewCell.swift
//  githubViewer
//
//  Created by Francis Beauchamp on 2018-07-10.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit
import PinLayout

struct BranchListItemViewData {
    let name: String
    let sha: String
    let message: String
    
    init(name: String, sha: String, message: String) {
        self.name = name
        self.sha = "commit \(sha)"
        self.message = message
    }
}

class BranchListViewCell: UITableViewCell {
    static let reuseIdentifier = "BranchListViewCellReuseIdentifier"

    private let nameLabel = UILabel()
    private let shaLabel = UILabel()
    private let messageLabel = UILabel()
    private let messageContainer = UIView()
    private let spacer = UIView()
    private let selectionOverlay = UIView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel.textColor = UIColor.charcoal
        addSubview(nameLabel)
        
        shaLabel.font = UIFont.systemFont(ofSize: 12)
        shaLabel.textColor = UIColor.charcoal.withAlphaComponent(0.7)
        addSubview(shaLabel)
        
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.textColor = UIColor.charcoal
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .white
        messageContainer.addSubview(messageLabel)

        messageContainer.backgroundColor = UIColor.charcoal
        addSubview(messageContainer)
        
        spacer.backgroundColor = UIColor.harleyOrange
        addSubview(spacer)

        selectionOverlay.backgroundColor = UIColor.charcoal
        selectionOverlay.alpha = 0
        addSubview(selectionOverlay)
        selectedBackgroundView = UIView()
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        nameLabel.pin.top(10).left(10).right(10)
        shaLabel.pin.below(of: nameLabel, aligned: .left).marginTop(5).right(10)
        
        let messageHeight = messageLabel.sizeThatFits(CGSize(width: frame.width - 20, height: .greatestFiniteMagnitude)).height + 20
        messageContainer.pin.below(of: shaLabel).marginTop(5).left().right().height(messageHeight)
        messageLabel.pin.all(10)
        spacer.pin.below(of: messageContainer, aligned: .left).horizontally().height(2)
        selectionOverlay.pin.all()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let nameHeight = nameLabel.sizeThatFits(size).height
        let shaHeight = shaLabel.sizeThatFits(size).height
        let messageHeight = messageLabel.sizeThatFits(CGSize(width: frame.width - 20, height: .greatestFiniteMagnitude)).height
        let height = 10 + nameHeight + 5 + shaHeight + 15 + messageHeight + 12
        return CGSize(width: frame.width, height: height)
    }

    func configure(viewData: BranchListItemViewData) {
        nameLabel.text = viewData.name
        nameLabel.sizeToFit()
        
        shaLabel.text = viewData.sha
        shaLabel.sizeToFit()

        messageLabel.text = viewData.message
        setNeedsLayout()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            self.selectionOverlay.alpha = selected ? 0.3 : 0
        })
    }
}
