//
//  ViewController.swift
//  CoreDataProject
//
//  Created by Lucas Moraes on 20/12/2017.
//  Copyright © 2017 LSolutions. All rights reserved.
//

import UIKit
import CoreData

class TableVC: UITableViewController {

    private let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
    
    private var data = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchResult()
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    // Delet Data by Row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let dataToDelete = data[indexPath.row]
            PersistenceService.context.delete(dataToDelete)
            PersistenceService.saveContext()
            fetchResult()
            tableView.reloadData()
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stb = UIStoryboard(name: "Main", bundle: nil)
        let vc = stb.instantiateViewController(withIdentifier: "EditDataVC") as! EditDataVC
        vc.recivedData = data[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].name
        cell.detailTextLabel?.text = data[indexPath.row].email
        return cell
    }
    
    // Pushing data from CoreData
    private func fetchResult() {
        do {
            let contact = try PersistenceService.context.fetch(fetchRequest) // <- this return [Contact]
            data = handleRetrivedData(with: contact)
        } catch  {
            AlertService.DefaultAlert(in: self, withMessage: "Some went wrong retriving your data \(error.localizedDescription)")
        }
    }

    // try to fix a bug, he brings me and empty Contact's values
    private func handleRetrivedData(with retrivedData:[Contact]) -> [Contact] {
        return retrivedData.filter { (value) -> Bool in
            value.name != nil
        }
    }
    
    private func updateNavBar() {
        if let navBar = self.navigationController?.navigationBar {
            navBar.topItem?.title = "CoreData Project"
            navBar.tintColor = UIColor.white
            if #available(iOS 11, *) {
                navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            } else  {}
            navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItem.Style.plain, target: self, action: #selector(addContact))
        }
    }

    // Perform pushViewController to AddDataVC
    @objc private func addContact() {
        let stb = UIStoryboard(name: "Main", bundle: nil)
        let vc = stb.instantiateViewController(withIdentifier: "AddDataVC") as! AddDataVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
