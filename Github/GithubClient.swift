//

// Created by Ankit Jasuja on 7/21/16.
// Copyright (c) 2016 Ankit Jasuja. All rights reserved.
//

import Foundation
import AFNetworking

private let reposUrl = "https://api.github.com/search/repositories"

class GithubClient  {

    let httpRequestOperationManager = AFHTTPRequestOperationManager()

    func getRepositories(githubSearchSettings : GithubSearchSettings, successCallBack : (NSDictionary) -> Void) -> Void {
        let params : [String: String] = createParameters(githubSearchSettings)
//        let reposUrlWithSearchTerm = reposUrl + "?q=" + searchTerm + "&stars>1000"
//        print(reposUrlWithSearchTerm)
        var response : NSDictionary!
        httpRequestOperationManager.GET(
        reposUrl,
        parameters: params,
        success: {
            (httpRequestOperation, httpResponseObject) -> Void in
                response = httpResponseObject as! NSDictionary
                successCallBack(response)
        },
        failure: {
            (httpRequestOperation, error) -> Void in
                print(error)
                response = NSDictionary()
        })
    }
    
    func createParameters(githubSearchSettings :  GithubSearchSettings) -> [String: String] {
        print(githubSearchSettings)
        var parameters : [String:String] = [:]
        
        var query = githubSearchSettings.searchQueryTerm ?? ""
        var searchFields : String = ""
        for searchField in githubSearchSettings.searchFields {
            searchFields += searchField.rawValue + ","
        }
        
        let minimumStars : Int = githubSearchSettings.minimumStars ?? 0
        let minimumForks : Int = githubSearchSettings.minimumForks ?? 0
        let language : String = githubSearchSettings.language ?? "java"
        
        query = query + " in:\(searchFields)"
        query = query + " stars:>\(minimumStars)"
        query = query + " forks:>\(minimumForks)"
        query = query + " language:\(language)"
        
        parameters["q"] = query
        parameters["sort"] = githubSearchSettings.sortCriteria.rawValue;
        parameters["order"] = githubSearchSettings.sortOrder.rawValue;
        return parameters
    }
    func getRepositoriesFromFile(successCallBack : (NSDictionary) -> Void) -> Void {        
        let fileContents : NSDictionary! = FileUtils.readFileContents("github-search", fileType: "json")
        successCallBack(fileContents)
    }

}