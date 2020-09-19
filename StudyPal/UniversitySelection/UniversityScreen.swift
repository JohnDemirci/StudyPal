//
//  UniversityScreen.swift
//  StudyPal
//
//  Created by John Demirci on 9/15/20.
//  Copyright © 2020 DemirciJohn. All rights reserved.
//

import UIKit
let universities = ["CSU CHANNEL ISLANDS",
                    "CSU LONG BEACH",
                    "CSU SACRAMENTO",
                    "CHAPMAN UNIVERSITY",
                    "ILLINOIS STATE UNIVERSITY",
                    "PORTLAND STATE UNIVERSITY",
                    "USC",
                    "UC LOS ANGELES",
                    "UC BERKELEY",
                    "LONG BEACH CITY COLLEGE"]


class UniversityScreen: UIViewController {
    
    private let tableView: UITableView = {
       let table = UITableView()
        table.register(UnivversityTableViewCell.self, forCellReuseIdentifier: UnivversityTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
 }

extension UniversityScreen: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        navigationController?.popViewController(animated: true)
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UnivversityTableViewCell.identifier,
                                                       for: indexPath) as? UnivversityTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(text: universities[indexPath.row])
        //cell.textLabel?.text = universities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        navigationController?.popViewController(animated: true)
    }
    
    
    
}


