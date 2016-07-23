//
//  GithubSettingViewController.swift
//  Github
//
//  Created by Ankit Jasuja on 7/22/16.
//  Copyright © 2016 Ankit Jasuja. All rights reserved.
//

import UIKit

class GithubSettingViewController: UIViewController {

    weak var delegate : GithubSettingsDelegate?
    
    @IBOutlet weak var starSlider: UISlider!
    @IBOutlet weak var forkSlider: UISlider!
    
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var forkCountLabel: UILabel!
    
    
    
    @IBOutlet weak var sortCriteriaControl: UISegmentedControl!
    @IBOutlet weak var sortOrderControl: UISegmentedControl!
    @IBOutlet weak var searchFieldControl: UISegmentedControl!
    
    
    @IBOutlet weak var languageFilterSwitch: UISwitch!
    
    var githubSearchSettings : GithubSearchSettings!
    
    @IBAction func onSaveButtonClick(sender: AnyObject) {
        let startCountValue = Int(starSlider.value)
        let forkCountValue = Int(forkSlider.value)
        
        githubSearchSettings.minimumStars = startCountValue
        githubSearchSettings.minimumForks = forkCountValue
        
        githubSearchSettings.language = "java"
        
        githubSearchSettings.sortOrder = sortOrder()
        githubSearchSettings.sortCriteria = sortCriteria()
        githubSearchSettings.searchFields = searchFields()
        
        self.delegate?.onSettingsSave(githubSearchSettings)
        dismissViewControllerAnimated(true, completion: nil)
        print("save button clicked ... ")
    }
    
    func searchFields() -> [SearchField] {
        var searchFields : [SearchField] = []
        let selectedIndex = searchFieldControl.selectedSegmentIndex
        if selectedIndex == 0 {
            searchFields.append(SearchField.Name)
        } else if selectedIndex == 1 {
            searchFields.append(SearchField.Description)
        } else {
            searchFields.append(SearchField.Readme)
        }
        return searchFields
    }
    
    func sortCriteria() -> SortCriteria {
        let selectedIndex = sortCriteriaControl.selectedSegmentIndex
        if selectedIndex == 0 {
            return SortCriteria.Stars
        } else {
            return SortCriteria.Forks
        }
    }
    
    func sortOrder() -> SortOrder {
        let selectedIndex = sortOrderControl.selectedSegmentIndex
        if selectedIndex == 0 {
            return SortOrder.Asc
        } else {
            return SortOrder.Desc
        }
    }
    
    @IBAction func onCancelButtonClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        print("cancel button clicked ... ")
    }
    
    @IBAction func onStarSliderChange(sender: AnyObject) {
        let startCountValue = Int(starSlider.value)
        starCountLabel.text = "\(startCountValue)"
    }
    
    @IBAction func onForkSliderChange(sender: AnyObject) {
        let forkCountValue = Int(forkSlider.value)
        forkCountLabel.text = "\(forkCountValue)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let startCount = githubSearchSettings.minimumStars ?? 0
        starCountLabel.text = "\(startCount)"
        starSlider.value = Float(startCount)

        let forkCount = githubSearchSettings.minimumForks ?? 0
        forkCountLabel.text = "\(forkCount)"
        forkSlider.value = Float(forkCount)
        
        switch githubSearchSettings.sortCriteria {
        case .Stars:
            sortCriteriaControl.selectedSegmentIndex = 0
        case .Forks :
            sortCriteriaControl.selectedSegmentIndex = 1
        }
        
        switch githubSearchSettings.sortOrder {
        case .Asc:
            sortOrderControl.selectedSegmentIndex = 0
        case .Desc :
            sortOrderControl.selectedSegmentIndex = 1
        }
        
        languageFilterSwitch.on = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("segue called ... ")
    }
}
