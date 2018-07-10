//
//  Github.swift
//  githubViewer
//
//  Created by Francis Beauchamp on 2018-07-09.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

// This would have persistance and other github related coordinations
class Github {
    enum Endpoints {
        case authenticate
        case repos
        case branches(owner: String, repo: String)
        case commit(owner: String, repo: String, sha: String)
        case pullRequests(owner: String, repo: String)
        
        private static let baseUrl: String = "https://api.github.com"
        var url: URL? {
            switch self {
            case .authenticate:
                return URL(string: "\(GithubEndpoints.baseUrl)/user")
            case .repos:
                return URL(string: "\(GithubEndpoints.baseUrl)/user/repos")
            case .branches(let owner, let repo):
                return URL(string: "\(GithubEndpoints.baseUrl)/repos/\(owner)/\(repo)/branches")
            case .commit(let owner, let repo, let sha):
                return URL(string: "\(GithubEndpoints.baseUrl)/repos/\(owner)/\(repo)/commits/\(sha)")
            case .pullRequests(let owner, let repo):
                return URL(string: "\(GithubEndpoints.baseUrl)/repos/\(owner)/\(repo)/pulls")
            }
        }
    }

    enum RepoType {
        case forkedRepo
        case privateRepo
        case publicRepo
        
        var image: UIImage? {
            switch self {
            case .forkedRepo:
                return UIImage(named: "forked")
            case .privateRepo:
                return UIImage(named: "private")
            case .publicRepo:
                return UIImage(named: "public")
            }
        }
    }

    private static let service = GithubHttpService()

    static var authenticated: Bool {
        return service.authenticated
    }
    
    static var user: String?
    
    class func authenticate(with credentials: GithubUserCredentials, handler: @escaping (_ success: Bool) -> Void) {
        service.authenticate(with: credentials, handler: handler)
    }
    
    class func repos(handler: @escaping ([Github.Repo]) -> Void) {
        service.repos(handler: handler)
    }
    
    class func branches(in repo: Github.Repo, handler: @escaping ([Github.Branch]) -> Void) {
        service.branches(repoName: repo.name, owner: repo.owner, handler: { (_ branchesData: [Github.Branch]) in
            let tasks = DispatchGroup()

            for branch in branchesData {
                tasks.enter()
                service.commit(repoName: repo.name, owner: repo.owner, sha: branch.lastCommitSHA, handler: { (_
                    commit: Github.Commit?) in
                    branch.lastCommitMessage = commit?.message ?? ""
                    tasks.leave()
                })
            }
            
            tasks.notify(queue: DispatchQueue.main, execute: {
                handler(branchesData)
            })
        })
        
    }
    
    class func pullRequests(handler: @escaping ([Github.PullRequest]) -> Void) {
        
    }
}
