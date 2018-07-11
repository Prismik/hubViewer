//
//  RepoDetailViewController.swift
//  githubViewer
//
//  Created by Francis Beauchamp on 2018-07-09.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit


class RepoDetailViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    var mainView: RepoDetailView {
        return view as! RepoDetailView
    }
    
    private var branches: [Github.Branch]
    private var repo: Github.Repo?
    init(repo: Github.Repo?, branches: [Github.Branch]) {
        self.branches = branches
        self.repo = repo
        super.init(nibName: nil, bundle: nil)
        
        
        title = repo?.name ?? ""
        extendedLayoutIncludesOpaqueBars = true
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
        edgesForExtendedLayout = []
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let detailView = RepoDetailView()
        detailView.delegate = self
        view = detailView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainView.configure(viewData: branches.map({
            return BranchListItemViewData(name: $0.name, sha: $0.lastCommitSHA, message: $0.lastCommitMessage)
        }))
    }
}

extension RepoDetailViewController: RepoDetailViewDelegate {
    func didSelectBranch(atIndex index: Int) {
        guard let repo = repo else { return }
        let branch = branches[index]
        Github.pullRequests(in: repo, branch: branch.name, handler: { [weak self] (_ pullRequests: [Github.PullRequest]) in
            let viewData: [PullRequestListItemViewData] = pullRequests.map({
                return PullRequestListItemViewData(number: $0.number, name: $0.name, message: $0.message, status: $0.status)
            })
            self?.mainView.loadPullRequestsDetails(viewData: viewData)
        })
    }
}
