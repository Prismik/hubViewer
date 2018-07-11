//
//  GithubApiTests.swift
//  githubViewerTests
//
//  Created by Francis Beauchamp on 2018-07-09.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import XCTest
@testable import githubViewer

// Test our integration of Github API
class GithubApiTests: XCTestCase {
    // Use any test account and you'd like to use here
    private let testCredentials = Github.UserCredentials(username: "YOUR_USERNAME", password: "YOUR_PASSWORD")
    private let testBadCredentials = Github.UserCredentials(username: "Cred1", password: "fakpwd")
    private let testRepo = Github.Repo(name: "hubViewer", forked: false, isPrivate: false, owner: "Prismik")

    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAuthenticate() {
        Github.authenticate(with: testCredentials, handler: { (_ success: Bool) in
            XCTAssertTrue(success)
        })
        
        Github.authenticate(with: testBadCredentials, handler: { (_ success: Bool) in
            XCTAssertFalse(success)
            XCTAssertTrue(Github.user == self.testCredentials.username)
        })
    }
    
    func testGetRepos() {
        Github.repos { (_ repos: [Github.Repo]) in
            XCTAssertFalse(repos.isEmpty)
        }
    }
    
    func testGetBranches() {
        Github.branches(in: testRepo) { (_ branches: [Github.Branch]) in
            XCTAssertFalse(branches.isEmpty)
        }
    }
    
    func testGetPullRequests() {
        Github.pullRequests(in: testRepo, branch: "master") { (_ pullRequests: [Github.PullRequest]) in
            XCTAssertFalse(pullRequests.isEmpty)
        }
        
        Github.pullRequests(in: testRepo, branch: "pr-test") { (_ pullRequests: [Github.PullRequest]) in
            XCTAssertTrue(pullRequests.isEmpty)
        }
    }
}
