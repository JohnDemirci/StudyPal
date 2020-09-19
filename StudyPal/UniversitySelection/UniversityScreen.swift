//
//  UniversityScreen.swift
//  StudyPal
//
//  Created by John Demirci on 9/15/20.
//  Copyright © 2020 DemirciJohn. All rights reserved.
//

import UIKit



class UniversityScreen: UIViewController {
    
    var delegate : UniversityDelegate!
    var filteredUniversities = [String]()
    lazy var searchController : UISearchController = {
        let search = UISearchController()
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type Your University"
        search.searchBar.sizeToFit()
        search.searchBar.searchBarStyle = .prominent
        search.searchBar.delegate = self
        return search
    }()
    
    private let tableView: UITableView = {
       let table = UITableView()
        table.register(UnivversityTableViewCell.self, forCellReuseIdentifier: UnivversityTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = appColor
        view.backgroundColor = appColor
        navigationItem.searchController = searchController
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
 }

extension UniversityScreen: UITableViewDataSource, UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        navigationController?.popViewController(animated: true)
//        return nil
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering() {
            return filteredUniversities.count
        }
        return universities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UnivversityTableViewCell.identifier,
                                                       for: indexPath) as? UnivversityTableViewCell else { return UITableViewCell() }
        
        
        var currentUniversity: String
        if isFiltering() {
            currentUniversity = filteredUniversities[indexPath.row]
            cell.configure(text: currentUniversity)
        } else {
            cell.configure(text: universities[indexPath.row])
        }
        
        //cell.textLabel?.text = universities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(universities[indexPath.row])
        
        if isFiltering() {
            delegate.retractUni(uniName: filteredUniversities[indexPath.row])
        } else {
            delegate.retractUni(uniName: universities[indexPath.row])
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    
}


extension UniversityScreen: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContent(searchText: searchBar.text!)
    }
}

extension UniversityScreen: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContent(searchText: searchBar.text!)
    }
}


extension UniversityScreen {
    func filterContent (searchText: String) {
        filteredUniversities = universities.filter({ (str: String) -> Bool in
            
            if isSearchBarEmpty() {
                filteredUniversities = universities
                return false
            } else {
                return str.lowercased().contains(searchText.lowercased())
            }
        })
        tableView.reloadData()
    }
    
    func isSearchBarEmpty () -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
}


extension UniversityScreen {
    func isFiltering() -> Bool {
        return searchController.isActive && !isSearchBarEmpty()
    }
}
