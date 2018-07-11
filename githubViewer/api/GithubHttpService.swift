//
//  GithubHttpService.swift
//  githubViewer
//
//  Created by Francis Beauchamp on 2018-07-09.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import Foundation
import SwiftyJSON

class GithubHttpService: NSObject {    
    var authenticated: Bool {
        return false
    }
    
    private let config = URLSessionConfiguration.default
    private lazy var session: URLSession = {
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()
    fileprivate var credentials: URLCredential?
    
    override init() {
        super.init()
    }

    private var authorizationHeader: String {
        guard let user = credentials?.user, let password = credentials?.password else { return "" }
        let credentialData = "\(user):\(password)".data(using: .utf8)!
        return credentialData.base64EncodedString()
    }
    
    private func prepareRequest(forUrl url: URL, params: [String: String] = [:]) -> URLRequest {
        var request: URLRequest
        if !params.isEmpty, var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            urlComponents.queryItems = params.map({ (key, value) -> URLQueryItem in
                return URLQueryItem(name: key, value: value)
            })
            
            request = URLRequest(url: urlComponents.url ?? url)
        } else {
            request = URLRequest(url: url)
        }

        request.setValue("Basic \(authorizationHeader)", forHTTPHeaderField: "Authorization")

        return request
    }

    // Does not work with 2FA for now
    func authenticate(with credentials: Github.UserCredentials, handler: @escaping (_ success: Bool) -> Void ) {
        guard let url = Github.Endpoints.authenticate.url else { return }
        self.credentials = URLCredential(user: credentials.username, password: credentials.password,
                                         persistence: URLCredential.Persistence.forSession)

        let completionHandler = {(data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard error == nil, let _ = data, let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                
                self.credentials = nil
                handler(false)
                return
            }

            Github.user = credentials.username
            handler(true)
        }
        
        session.dataTask(with: prepareRequest(forUrl: url), completionHandler: completionHandler).resume()
    }
    
    // Get the repos for the currently authenticated user
    func repos(handler: @escaping (_ data: [Github.Repo]) -> Void) {
        guard let url = Github.Endpoints.repos.url else { return }
        let completionHandler = {(data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard error == nil, let data = data, let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                    
                handler([])
                return
            }
            do {
                let json = try JSON(data: data)
                var parsedData: [Github.Repo] = []
                for (_, subJson):(String, JSON) in json {
                    if let repo = Github.Repo(json: subJson) {
                        parsedData.append(repo)
                    }
                }

                handler(parsedData)
            } catch {
                print("error")
                handler([])
            }
        }

        session.dataTask(with: prepareRequest(forUrl: url), completionHandler: completionHandler).resume()
    }
    
    func branches(repoName: String, owner: String, handler: @escaping(_ data: [Github.Branch]) -> Void) {
        guard let url = Github.Endpoints.branches(owner: owner, repo: repoName).url else { return }
        let completionHandler = {(data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard error == nil, let data = data, let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                    handler([])
                    return
            }
            do {
                let json = try JSON(data: data)
                var parsedData: [Github.Branch] = []
                for (_, subJson):(String, JSON) in json {
                    if let branch = Github.Branch(json: subJson) {
                        parsedData.append(branch)
                    }
                }
                
                handler(parsedData)
            } catch {
                print("error")
                handler([])
            }
        }
        
        session.dataTask(with: prepareRequest(forUrl: url), completionHandler: completionHandler).resume()
    }
    
    func commit(repoName: String, owner: String, sha: String, handler: @escaping(_ data: Github.Commit?) -> Void) {
        guard let url = Github.Endpoints.commit(owner: owner, repo: repoName, sha: sha).url else { return }
        let completionHandler = {(data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard error == nil, let data = data, let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                    handler(nil)
                    return
            }
            do {
                let json = try JSON(data: data)
                handler(Github.Commit(json: json))
            } catch {
                print("error")
                handler(nil)
            }
        }
        
        session.dataTask(with: prepareRequest(forUrl: url), completionHandler: completionHandler).resume()
    }
    
    func pullRequests(repoName: String, owner: String, branch: String? = nil, handler: @escaping(_ data: [Github.PullRequest]) -> Void) {
        guard let url = Github.Endpoints.pullRequests(owner: owner, repo: repoName).url else { return }
        let completionHandler = {(data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard error == nil, let data = data, let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                    handler([])
                    return
            }
            do {
                let json = try JSON(data: data)
                var parsedData: [Github.PullRequest] = []
                for (_, subJson):(String, JSON) in json {
                    if let pullRequest = Github.PullRequest(json: subJson) {
                        parsedData.append(pullRequest)
                    }
                }
                
                handler(parsedData)
            } catch {
                print("error")
                handler([])
            }
        }

        let params: [String: String] = branch == nil ? [:] : ["base": branch!]
        session.dataTask(with: prepareRequest(forUrl: url, params: params), completionHandler: completionHandler).resume()
    }
    
    // reviews
    func reviews(repoName: String, owner: String, number: Int, handler: @escaping(_ data: [Github.Review]) -> Void) {
        guard let url = Github.Endpoints.reviews(owner: owner, repo: repoName, number: number).url else { return }
        let completionHandler = {(data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard error == nil, let data = data, let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                    handler([])
                    return
            }
            do {
                let json = try JSON(data: data)
                var parsedData: [Github.Review] = []
                for (_, subJson):(String, JSON) in json {
                    if let pullRequest = Github.Review(json: subJson) {
                        parsedData.append(pullRequest)
                    }
                }
                handler(parsedData)
            } catch {
                print("error")
                handler([])
            }
        }

        session.dataTask(with: prepareRequest(forUrl: url), completionHandler: completionHandler).resume()
    }
}

extension GithubHttpService: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, credentials)
    }
}
