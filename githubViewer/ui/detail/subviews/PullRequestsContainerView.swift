//
//  PullRequestsContainerView.swift
//  githubViewer
//
//  Created by Francis Beauchamp on 2018-07-10.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit


class PullRequestsContainerView: UIView {
    private let tableView = UITableView()
    private let placeholderLabel = UILabel()
    private var data: [PullRequestListItemViewData] = []
    init() {
        super.init(frame: .zero)
        
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PullRequestListViewCell.self, forCellReuseIdentifier: PullRequestListViewCell.reuseIdentifier)
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        addSubview(tableView)
        
        placeholderLabel.isHidden = false
        placeholderLabel.text = "Select a branch to see the it's pull requests."
        placeholderLabel.font = UIFont.boldSystemFont(ofSize: 24)
        placeholderLabel.textColor = UIColor.charcoal
        placeholderLabel.numberOfLines = 0
        addSubview(placeholderLabel)

        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tableView.pin.all()
        placeholderLabel.pin.all(20)
    }
    
    func configure(viewData: [PullRequestListItemViewData]) {
        placeholderLabel.text = "No pull request on this branch."
        placeholderLabel.sizeToFit()
        self.data = viewData
        tableView.reloadData()
        
        if data.isEmpty {
            placeholderLabel.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.placeholderLabel.alpha = 1
                self.tableView.alpha = 0
            }, completion: { (_) in
                self.tableView.isHidden = true
            })
        } else {
            tableView.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.placeholderLabel.alpha = 0
                self.tableView.alpha = 1
            }, completion: { (_) in
                self.placeholderLabel.isHidden = true
            })
        }
    }
}

extension PullRequestsContainerView: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PullRequestListViewCell.reuseIdentifier, for: indexPath) as! PullRequestListViewCell
        cell.configure(viewData: data[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Pull requests"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.charcoal
        label.backgroundColor = UIColor.white
        return label
    }
}

extension PullRequestsContainerView: UITableViewDataSource {
    
}
