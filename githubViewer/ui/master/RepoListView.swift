//
//  RepoListView.swift
//  githubViewer
//
//  Created by Francis Beauchamp on 2018-07-09.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

protocol RepoListViewDelegate: class {
    func didSelectRepo(atIndex index: Int)
}

class RepoListView: UIView {
    weak var delegate: RepoListViewDelegate?
    
    private let tableView = UITableView(frame: .zero)
    private var data: [RepoListItemViewData] = []
    init() {
        super.init(frame: .zero)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsHorizontalScrollIndicator = true
        tableView.register(RepoListViewCell.self, forCellReuseIdentifier: RepoListViewCell.reuseIdentifier)
        tableView.backgroundColor = UIColor.white
        addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewData: [RepoListItemViewData]) {
        data = viewData
        tableView.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tableView.pin.all()
    }
}

extension RepoListView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoListViewCell.reuseIdentifier, for: indexPath) as! RepoListViewCell
        cell.configure(viewData: data[indexPath.row])
        return cell
    }
}

extension RepoListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectRepo(atIndex: indexPath.row)
    }
}
