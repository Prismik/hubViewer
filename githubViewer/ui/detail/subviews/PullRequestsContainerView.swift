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
        addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    func configure() {
        
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
        return tableView.dequeueReusableCell(withIdentifier: <#T##String#>, for: indexPath)
    }
}

extension PullRequestsContainerView: UITableViewDataSource {
    
}
