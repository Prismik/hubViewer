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
    
    private var branches: [Github.Branch] = []

    init(repoName: String, branches: [Github.Branch]) {
        super.init(nibName: nil, bundle: nil)
        
        self.branches = branches
        title = repoName
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
    
}
