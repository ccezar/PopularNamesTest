//
//  TableViewController.swift
//  PopularNames
//
//  Created by Caio Cezar Lopes dos Santos on 3/19/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    private var persons: [Person] = []
    private var viewedIDs: [String] = []

    // MARK: Class Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPersons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    func loadPersons() {
        guard let path = openFile(file: "99", type: "json") else { return loadException(reason: "Unable To Load") }
        guard let jsonData = NSData(contentsOfFile: path) else { return loadException(reason: "Unable To Transform") }
        
        var allEntries = [[String:Any]]()
        allEntries = try! JSONSerialization.jsonObject(with: jsonData as Data, options: []) as! [[String: Any]]

        for item in allEntries {
            if let id = item["id"] as? String, viewedIDs.contains(id) == false {
                persons.append(Person(element: item))
                viewedIDs.append(id)
            }
        }
    }
    
    private func openFile(file: String, type: String) -> String? {
        return Bundle.main.path(forResource: file, ofType: type) ?? nil
    }
    
    private func loadException(reason: String) {
        NSException(name: NSExceptionName(rawValue: "WithoutLibsViewController Error"), reason: reason, userInfo: nil).raise()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let vc = segue.destination as? DetailViewController, let cell = sender as? PersonTableViewCell {
                vc.person = cell.person
            }
        }
    }

    // MARK: TableViewDelegate
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PersonTableViewCell
        cell.person = persons[indexPath.item]
        cell.selectionStyle = .none
        
        return cell
    }
}

