//
// Created by Ankit Jasuja on 7/21/16.
// Copyright (c) 2016 Ankit Jasuja. All rights reserved.
//

import Foundation
import AFNetworking

private let reposUrl = "https://api.github.com/search/repositories?q=swift"

class GithubClient  {

    let httpRequestOperationManager = AFHTTPRequestOperationManager()

    func getRepositories(successCallBack : (NSDictionary) -> Void) -> Void {
        var response : NSDictionary!
        httpRequestOperationManager.GET(
        reposUrl,
        parameters: nil,
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
    
    func getRepositoriesFromFile(successCallBack : (NSDictionary) -> Void) -> Void {        
        let fileContents : NSDictionary! = FileUtils.readFileContents("github-search", fileType: "json")
        successCallBack(fileContents)
    }

}