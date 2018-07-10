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
    private var data: [PullRequestListItemViewData] = []
    init() {
        super.init(frame: .zero)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PullRequestListViewCell.self, forCellReuseIdentifier: PullRequestListViewCell.reuseIdentifier)
        tableView.backgroundColor = .white
        addSubview(tableView)
        
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tableView.pin.all()
    }
    
    func configure(viewData: [PullRequestListItemViewData]) {
        self.data = viewData
        tableView.reloadData()
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
}

extension PullRequestsContainerView: UITableViewDataSource {
    
}
