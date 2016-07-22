//
// Created by Ankit Jasuja on 7/21/16.
// Copyright (c) 2016 Ankit Jasuja. All rights reserved.
//

import Foundation

class GithubRepository : CustomStringConvertible {

var name : String?
    var login : String?
    var avatarUrl : String?
    var stars : Int?
    var forks : Int?
    var repoDescription : String?
    var language : String?

    init(githubResponse : NSDictionary) {
        if let name = githubResponse["name"] as? String {
            self.name = name
        }
        if let stars = githubResponse["stargazers_count"] as? Int {
            self.stars = stars
        }
        if let forks = githubResponse["forks"] as? Int {
            self.forks = forks
        }
        if let ownerResponse = githubResponse["owner"] as? NSDictionary {
            if let login = ownerResponse["login"] as? String {
                self.login = login
            }
            if let avatarUrl = ownerResponse["avatar_url"] as? String {
                self.avatarUrl = avatarUrl
            }
        }
        if let repoDescription = githubResponse["description"] as? String {
            self.repoDescription = repoDescription
        }
        if let language = githubResponse["language"] as? String {
            self.language = language
        }
    }

    static func getRepositories(searchTerm : String, completion: ([GithubRepository]) -> Void) {
        var githubRepositories : [GithubRepository] = []
        let githubClient = GithubClient()
        /* getting repositories from mocked data file */
//        githubClient.getRepositoriesFromFile { (fileContents) in
//            let totalCount = fileContents["total_count"] as? Int
//            print(totalCount)
//            let items = fileContents["items"] as! [NSDictionary]
//            //            print(items)
//            for item in items {
//                let githubRepository: GithubRepository = GithubRepository(githubResponse: item)
//                githubRepositories.append(githubRepository)
//            }
//            completion(githubRepositories)
//        }
        /* getting repositories from network call */
        githubClient.getRepositories(searchTerm, successCallBack: { (fileContents) in
            let totalCount = fileContents["total_count"] as? Int
            print(totalCount)
            let items = fileContents["items"] as! [NSDictionary]
            for item in items {
                let githubRepository: GithubRepository = GithubRepository(githubResponse: item)
                githubRepositories.append(githubRepository)
            }
            completion(githubRepositories)
        })
//        githubClient.getRepositories (searchTerm, { (fileContents) in
//                let totalCount = fileContents["total_count"] as? Int
//                print(totalCount)
//                let items = fileContents["items"] as! [NSDictionary]
//                for item in items {
//                    let githubRepository: GithubRepository = GithubRepository(githubResponse: item)
//                    githubRepositories.append(githubRepository)
//                }
//            completion(githubRepositories)
//        })
    }

    // Creates a text representation of a GitHub repo
    var description: String {
        return "[Name: \(self.name!)]" +
                "\n\t[Stars: \(self.stars!)]" +
                "\n\t[Forks: \(self.forks!)]" +
                "\n\t[Login: \(self.login!)]" +
                "\n\t[Avatar: \(self.avatarUrl!)]" +
                "\n\t[Description: \(self.repoDescription ?? "")]" +
                "\n\t[Description: \(self.language ?? "")]"
                "\n"
    }
}