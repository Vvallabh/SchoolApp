//
//  ViewController.swift
//  19900926-Vishnupriya-NYCSchools
//
//  Created by V  on 9/12/18.
//  Copyright © 2018 V . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tablView: UITableView!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   
    var schoolList:[[String:String]]?
    
    var schoolDetails:[SchoolDetail]?
    
    var selectedDetail : SchoolDetail?
    
    var selectedSchool : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        activityIndicator.startAnimating()
        tablView.register(UINib.init(nibName: "HeaderView", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "Header")
        NetworkManager().getSchools { [weak self] (success, schools)  in

            self?.schoolList = schools
            
            NetworkManager().getSchoolDetails { [weak self] (success, details) in
                
                self?.schoolDetails   = details

                DispatchQueue.main.async { [weak self] in
                    self?.tablView.reloadData()
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource,HeaderViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {

        if let schools = schoolList {
            return schools.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let school = schoolList![section]["school_name"]
        if selectedSchool?.caseInsensitiveCompare(school!) == .orderedSame {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCellId", for: indexPath) as? SchoolDetailCell else {
            return  UITableViewCell()
        }
        cell.detail = selectedDetail
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
       guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as? HeaderView else {
            return UIView()
        }
        header.title = schoolList![section]["school_name"]
        header.delegate = self
         if selectedSchool != nil && header.title?.caseInsensitiveCompare(selectedSchool!) == .orderedSame {
            header.isExpanded  = true
        }
        else {
            header.isExpanded  = false
        }
        return header
  
    }

    func headerView(_ header: HeaderView?, didExpand expand: Bool, school: String?) {
        if expand {
            
            selectedDetail = (schoolDetails?.filter({ (detail) -> Bool in
                if detail.schoolName.caseInsensitiveCompare(school!) == .orderedSame {
                    return true
                }
                return false
                
            }))?.first
            
           
            if selectedDetail != nil {
                
                if selectedSchool != nil {
                    let section = findIndex(name: selectedSchool!)
                    if  section > 0 {
                        let deleteIndex = IndexPath.init(row: 0, section: section)
                        tablView.deleteRows(at: [deleteIndex], with: UITableViewRowAnimation.fade)
                        
                    }
                }
                selectedSchool = school
                let section = findIndex(name: school!)

                if  section > 0 {
                    let index = IndexPath.init(row: 0, section: section)
                    tablView.insertRows(at: [index], with: UITableViewRowAnimation.fade)
                }
            }
        }
        else {
            if selectedDetail != nil {
                selectedSchool = nil
                let section = findIndex(name: school!)
                if  section > 0 {
                    let deleteIndex = IndexPath.init(row: 0, section: section)
                    tablView.deleteRows(at: [deleteIndex], with: UITableViewRowAnimation.fade)
                }
            }
   
        }
    }

    func findIndex(name:String) -> Int {
        var section = -1
        var found = false
        for dict in schoolList! {
            section += 1
            if dict["school_name"]?.caseInsensitiveCompare(name) == .orderedSame {
                found = true
                break;
            }
        }
        return found ? section : -1
    }
}
