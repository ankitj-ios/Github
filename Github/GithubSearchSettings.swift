//
//  GithubSearchSettings.swift
//  Github
//
//  Created by Ankit Jasuja on 7/22/16.
//  Copyright © 2016 Ankit Jasuja. All rights reserved.
//

import Foundation

enum SortOrder:String {
    case Asc = "asc", Desc = "desc"
    
}

enum SortCriteria : String {
    case Stars="stars", Forks="forks"
}

enum SearchField : String {
    case Name="name", Description="description", Readme="readme"
}
class GithubSearchSettings: CustomStringConvertible {
    
    var searchQueryTerm : String?
    var language : String?
    var minimumStars : Int?
    var minimumForks : Int?
    var sortOrder : SortOrder
    var sortCriteria : SortCriteria
    var searchFields : [SearchField] = []
    
    init() {
        searchQueryTerm = "codepath"
        language = "swift"
        minimumStars = 0
        minimumForks = 0
        sortOrder = .Desc
        sortCriteria = .Stars
        searchFields.append(.Name)
        print("initializing github search settings ... ")
        print(self)
    }
    
    var description: String {
        var objectDescription : String = ">>>>>>>>>>"
        objectDescription += "\n\t" + searchQueryTerm!
        objectDescription += "\n\t" + language!
        objectDescription += "\n\t" + String(minimumStars ?? 0)
        objectDescription += "\n\t" + String(minimumForks ?? 0)
        objectDescription += "\n\t" + sortOrder.rawValue
        objectDescription += "\n\t" + sortCriteria.rawValue
        var searchFields = ""
        for searchField in self.searchFields {
        searchFields += searchField.rawValue + ","
        }
        objectDescription += "\n\t" + searchFields
        objectDescription += "\n" + "<<<<<<<<<<<<"
        return objectDescription;
    }
}
