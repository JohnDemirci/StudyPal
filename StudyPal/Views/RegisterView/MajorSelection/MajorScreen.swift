//
//  UniversityScreen.swift
//  StudyPal
//
//  Created by John Demirci on 9/15/20.
//  Copyright © 2020 DemirciJohn. All rights reserved.
//

import UIKit


/*
    University Screen is a table view listing all the universities in the syste
*/
class MajorScreen: UIViewController {
    /*
     once the university clicks on their univerrsity
     we wan to collect that data and pass it to the parent view
     note that universityScreen is the child view of register screen
     we declared our University Delegate protocol and now we are using it to retreive data
     */
    var delegate : MajorDelegate!
    /*
     filtered universities is the array which we are goin to use
     if the user has entered a text in the searchbar
     */
    var filteredMajors = [String]()
    /*
     we are creating a searchController so that the user can filter out their university
     we want to create this as a lazy variable because the user may not opt to use this searchbar and we can save our memory by declaring it as a lazy variable
     */
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
    // initilization of our tableview
    private let tableView: UITableView = {
       let table = UITableView()
        // we are creating a custom cell and attatching that cell into our table view
        // the custom cell has its own swift file
        // you can find the UnivversityTableViewCell.identifier inside that file
        table.register(MajorTableViewCell.self, forCellReuseIdentifier: MajorTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = appColor
        view.backgroundColor = appColor
        // adding the searchController to the navigation bar
        navigationItem.searchController = searchController
        // inserting the table view into our screen
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // attaching our table view all over our screen
        tableView.frame = view.bounds
    }
    
 }
/*
 ************************************************
 *********** TABLE VIEW EXTENSION ***************
 ************************************************
 */
extension MajorScreen: UITableViewDataSource, UITableViewDelegate {
    /*
     when the user filters the table by using the searchbar we want to give
     a different number of rows based on the search result
     that is why we check if it is being filtered
     if the answer is yes then we return the amount of values we have in filteredUniversities array
     if the answer is no then we return the whole universities array
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredMajors.count
        }
        return majors.count
    }
    
    // setting upthe row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    // this is our cell function for each cell in the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // creating and setting up the cell based on our cusom cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MajorTableViewCell.identifier,
                                                       for: indexPath) as? MajorTableViewCell else { return UITableViewCell() }
        
        // each cell will hvae a value and that value can be this
        // current university if the searchbar is used to filter out elements
        var currentMajor: String
        if isFiltering() {
            // we are calling the configure function that was implementedd in the cell file
            // it basicallt adds the text tot he cell
            currentMajor = filteredMajors[indexPath.row]
            cell.configure(text: currentMajor)
        } else {
            cell.configure(text: majors[indexPath.row])
        }
        // returning the cell
        return cell
    }
    
    // after the user clicks the cell that contains the name of their university
    // we want to grab that university and send it back to the previous view where it can be used
    // afterwards we are done with this view so we are popping from the view stack
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering() {
            delegate.retractMajor(majorName: filteredMajors[indexPath.row])
        } else {
            delegate.retractMajor(majorName: majors[indexPath.row])
        }
        navigationController?.popViewController(animated: true)
    }
}


extension MajorScreen: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContent(searchText: searchBar.text!)
    }
}

// UPDATING THE SEARCHBAR RESULTS
extension MajorScreen: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContent(searchText: searchBar.text!)
    }
}


extension MajorScreen {
    func filterContent (searchText: String) {
        // when the user enters some text on the searchbar we want to filter that and compare it with
        // what we have in the universities array
        filteredMajors = majors.filter({ (str: String) -> Bool in
            if isSearchBarEmpty() {
                // if searchbar is empty then set filtered universities to the whole universities array
                // since nothing is added to filter out
                filteredMajors = majors
                return false
            } else {
                return str.lowercased().contains(searchText.lowercased())
            }
        })
        // reloading the table
        tableView.reloadData()
    }
    // check if search abr is empty
    func isSearchBarEmpty () -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
}

// checking if the searchbar is active
extension MajorScreen {
    func isFiltering() -> Bool {
        return searchController.isActive && !isSearchBarEmpty()
    }
}

