//
//  HAServiceProsTableViewController.swift
//  HAInterview
//
//  Created by Pauga, Justin on 12/26/18.
//  Copyright © 2018 Pauga. All rights reserved.
//

import UIKit

class HAServiceProsTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var servicePros : [HAServicePro] = []
    var serviceProSearchResults : [HAServicePro] = []
    let searchController = UISearchController(searchResultsController: nil)
    var specialties = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPros()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Pros"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }

    // MARK: - Table view data source

    func loadPros() {
        let path = Bundle.main.path(forResource: "pro_data", ofType: "json")!
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: path))
        do {
            let jsonresult: [[String: AnyObject]] = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [[String: AnyObject]]
            for pro in jsonresult {
                servicePros.append(HAServicePro(dictionary: pro))
            }
        } catch {
            print("Something went wrong getting JSON data")
        }
        
        servicePros.sort(by: ({ $0.companyName! < $1.companyName! }))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return numberOfProsInSection(section)
        if isFiltering() {
            return serviceProSearchResults.count
        }
        
        return servicePros.count
    }
    
    func numberOfProsInSection(_ section: Int) -> Int {
       
        var count : Int = 0
        var pros : [HAServicePro]
        
        if isFiltering() {
            pros = serviceProSearchResults
        } else {
            pros = servicePros
        }
        
        for pro in pros {
            if let specialty = pro.specialty {
                if specialty.lowercased() == specialties[section].lowercased() {
                    count = count + 1
                }
            }
        }
        
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HAServiceProCell", for: indexPath)
        let pro : HAServicePro
        if isFiltering() {
            pro = serviceProSearchResults[indexPath.row]
        } else {
            pro = servicePros[indexPath.row]
        }
        cell.textLabel?.text = pro.companyName
        guard let ratings = Int(pro.ratingCount!),  let compositeRating = Double(pro.compositeRating!) else { return cell}
        
        if ratings == 0 {
            cell.detailTextLabel?.textColor = .black
            cell.detailTextLabel?.text = "References Available"
        } else {
            if compositeRating < 3.0 {
                cell.detailTextLabel?.textColor = .red
            }
            else if compositeRating >= 3.0 && compositeRating < 4.0 {
                cell.detailTextLabel?.textColor = .orange
            }
            else {
                cell.detailTextLabel?.textColor = .green
            }
            
            cell.detailTextLabel?.text = "Ratings: \(compositeRating) | \(ratings) rating(s)"
        }
        return cell
    
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            let indexPath = tableView.indexPathForSelectedRow!
            let pro : HAServicePro
            if isFiltering() {
                pro = serviceProSearchResults[indexPath.row]
            } else {
                pro = servicePros[indexPath.row]
            }
            let proDetailsViewController = segue.destination as! HAServiceProDetailViewController
            
            proDetailsViewController.servicePro = pro
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        self.serviceProSearchResults = self.servicePros.filter({( servicePro : HAServicePro) -> Bool in
            return servicePro.companyName!.lowercased().contains(searchText.lowercased()) || servicePro.specialty!.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    

}

extension HAServiceProsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.filterContentForSearchText(searchController.searchBar.text!)
    }
}
