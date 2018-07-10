//
//  RepoListViewController.swift
//  githubViewer
//
//  Created by Francis Beauchamp on 2018-07-09.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

class RepoListViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var mainView: RepoListView {
        return view as! RepoListView
    }

    private var data: [Github.Repo] = []

    init() {
        super.init(nibName: nil, bundle: nil)
        
        title = "Repos"
        edgesForExtendedLayout = []
        navigationController?.navigationBar.isTranslucent = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let listView = RepoListView()
        listView.delegate = self
        view = listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        splitViewController?.preferredDisplayMode = .allVisible
        splitViewController?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Github.repos(handler: { [weak self] (_ data: [Github.Repo]) in
            guard let strongSelf = self else { return }
            strongSelf.data = data
            DispatchQueue.main.async {
                let viewData: [RepoListItemViewData] = data.map({
                    let repoType: Github.Repo.Types
                    if $0.forked {
                        repoType = .forkedRepo
                    } else {
                        repoType = $0.isPrivate ? .privateRepo : .publicRepo
                    }
                    return RepoListItemViewData(mainImage: nil, name: $0.name, repoType: repoType)
                })
                strongSelf.mainView.configure(viewData: viewData)
            }
        })
    }
}

extension RepoListViewController: RepoListViewDelegate {
    func didSelectRepo(atIndex index: Int) {
        let repo = data[index]
        Github.branches(in: repo, handler: { [weak self] (_ data: [Github.Branch]) in
            guard let strongSelf = self else { return }
            let detailViewController = RepoDetailViewController(repo: repo, branches: data)
            strongSelf.splitViewController?.showDetailViewController(detailViewController, sender: self)
        })
        
    }
}

extension RepoListViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
