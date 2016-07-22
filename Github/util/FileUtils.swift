//
// Created by Ankit Jasuja on 7/21/16.
// Copyright (c) 2016 Ankit Jasuja. All rights reserved.
//

import Foundation
class FileUtils {


    static func readFileContents(fileName: String, fileType: String) -> NSDictionary? {
        let filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: fileType)
        if let data = NSData(contentsOfFile:filePath!) {
            return try! NSJSONSerialization.JSONObjectWithData(data, options:[]) as? NSDictionary
        }
        return NSDictionary()
    }

}