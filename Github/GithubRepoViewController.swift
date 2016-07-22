//
//  GithubRepoViewController.swift
//  Github
//
//  Created by Ankit Jasuja on 7/21/16.
//  Copyright © 2016 Ankit Jasuja. All rights reserved.
//

import UIKit

class GithubRepoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var repositoriesTableView: UITableView!
    
    var githubRepositories : [GithubRepository]! = [GithubRepository]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        print("view loaded ... ")

//        var githubRepositories : [GithubRepository] = []
//        var fileContents : NSDictionary? = FileUtils.readFileContents("github-search", fileType: "json")
//
//        if let fileContents = fileContents {
//            let totalCount = fileContents["total_count"] as? Int
//            print(totalCount)
//            let items = fileContents["items"] as! [NSDictionary]
//            print(items)
//            for item in items {
//                var githubRepository: GithubRepository = GithubRepository(githubResponse: item)
//                githubRepositories.append(githubRepository)
//            }
//        }
        GithubRepository.getRepositories { (githubRepositories) in
            self.githubRepositories = githubRepositories
            print("=== count : \(self.githubRepositories.count)")
//            print(githubRepositories)
            self.repositoriesTableView.reloadData()
        }
        
        /* for table view */
        self.repositoriesTableView.dataSource = self
        self.repositoriesTableView.delegate = self
        
        /* for auto layout */
        self.repositoriesTableView.rowHeight = UITableViewAutomaticDimension
        self.repositoriesTableView.estimatedRowHeight = 120

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return githubRepositories.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let githubRepositoryCell = tableView.dequeueReusableCellWithIdentifier("GithubRepositoryCell", forIndexPath: indexPath) as! GithubRepositoryCell
        githubRepositoryCell.backgroundColor = UIColor.clearColor()
        let githubRepository = githubRepositories[indexPath.row]
        print(githubRepository.login!)
        print(githubRepository.name!)
        print(String(githubRepository.stars!))
        print(String(githubRepository.forks!))
        githubRepositoryCell.loginLabel.text = githubRepository.login!
        githubRepositoryCell.nameLabel.text = githubRepository.name!
        githubRepositoryCell.starCountLabel.text = String(githubRepository.stars!)
        githubRepositoryCell.forkCountLabel.text = String(githubRepository.forks!)
        githubRepositoryCell.descriptionLabel.text = githubRepository.repoDescription ?? ""
        githubRepositoryCell.languageLabel.text = githubRepository.language
        let avatarUrl : String! = githubRepository.avatarUrl
        let avatarImageRequest = NSURLRequest(URL: NSURL(string: avatarUrl!)!)
        githubRepositoryCell.avatarImageView.setImageWithURLRequest(avatarImageRequest, placeholderImage: nil, success: { (avatarImageRequest, avatarImageResponse, image) in
                githubRepositoryCell.avatarImageView.image = image
//                githubRepositoryCell.avatarImageView.layer.masksToBounds = false
//                githubRepositoryCell.avatarImageView.layer.borderWidth = 2
//                githubRepositoryCell.avatarImageView.layer.cornerRadius = githubRepositoryCell.avatarImageView.frame.height/2
//                githubRepositoryCell.avatarImageView.clipsToBounds = true
            }) { (avatarImageRequest, avatarImageResponse, error) in
                print("failed during avatar image fetch ... ")
        }
        return githubRepositoryCell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
