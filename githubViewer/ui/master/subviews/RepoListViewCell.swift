//
//  RepoListViewCell.swift
//  githubViewer
//
//  Created by Francis Beauchamp on 2018-07-09.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

struct RepoListItemViewData {
    let mainImage: UIImage?
    let name: String
    let repoTypeImage: UIImage?
    
    init(mainImage: UIImage?, name: String, repoType: Github.Repo.Types) {
        self.mainImage = mainImage
        self.name = name
        self.repoTypeImage = {
            switch repoType {
            case .forkedRepo:
                return UIImage(named: "forked")
            case .privateRepo:
                return UIImage(named: "private")
            case .publicRepo:
                return UIImage(named: "public")
            }
        }()
    }
}

class RepoListViewCell: UITableViewCell {
    static let reuseIdentifier = "RepoListViewCellReuseIdentifier"

    private let mainImageView = UIImageView()
    private let nameLabel = UILabel()
    private let typeImageView = UIImageView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        mainImageView.contentMode = .scaleAspectFit
        addSubview(mainImageView)
        
        nameLabel.textColor = UIColor.charcoal
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        addSubview(nameLabel)
        
        typeImageView.contentMode = .scaleAspectFit
        addSubview(typeImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewData: RepoListItemViewData) {
        mainImageView.image = viewData.mainImage ?? UIImage(named: "default")
        nameLabel.text = viewData.name
        nameLabel.sizeToFit()
        typeImageView.image = viewData.repoTypeImage
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        mainImageView.pin.vCenter().left(12).width(frame.height - 24).height(frame.height - 24)
        nameLabel.pin.right(of: mainImageView, aligned: .bottom).marginLeft(5)
        typeImageView.pin.vCenter().right(12).size(16)
    }
}
