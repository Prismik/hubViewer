//
//  RepoDetailView.swift
//  githubViewer
//
//  Created by Francis Beauchamp on 2018-07-09.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit
import PinLayout

protocol RepoDetailViewDelegate: class {
    func didSelectBranch(atIndex index: Int)
}

class RepoDetailView: UIView {
    weak var delegate: RepoDetailViewDelegate?
    
    private let branchesTableView = UITableView()
    private let pullRequestsContainer = PullRequestsContainerView()
    private var data: [BranchListItemViewData] = []

    private let sizingCell = BranchListViewCell(style: .default, reuseIdentifier: BranchListViewCell.reuseIdentifier)
    init() {
        super.init(frame: .zero)
        
        branchesTableView.dataSource = self
        branchesTableView.delegate = self
        branchesTableView.showsHorizontalScrollIndicator = true
        branchesTableView.rowHeight = UITableViewAutomaticDimension
        branchesTableView.estimatedRowHeight = UITableViewAutomaticDimension
        branchesTableView.register(BranchListViewCell.self, forCellReuseIdentifier: BranchListViewCell.reuseIdentifier)
        branchesTableView.backgroundColor = UIColor.white
        addSubview(branchesTableView)
        
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewData: [BranchListItemViewData]) {
        self.data = viewData
        branchesTableView.reloadData()
    }
    
    func loadPullRequestsDetails(viewData: [PullRequestListItemViewData]) {
        pullRequestsContainer.configure(viewData: viewData)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        branchesTableView.pin.top(10).left(10).right(10).height(60%)
    }
}

extension RepoDetailView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BranchListViewCell.reuseIdentifier, for: indexPath) as! BranchListViewCell
        cell.configure(viewData: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        sizingCell.configure(viewData: data[indexPath.row])
        return sizingCell.sizeThatFits(branchesTableView.frame.size).height
    }
}

extension RepoDetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectBranch(atIndex: indexPath.row)
    }
}
