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

    let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
    
    var data = [Contact]()
    
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let dataToDelete = data[indexPath.row]
            PersistenceService.context.delete(dataToDelete)
            PersistenceService.saveContext()
        }
        fetchResult()
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stb = UIStoryboard(name: "Main", bundle: nil)
        let vc = stb.instantiateViewController(withIdentifier: "EditDataVC") as! EditDataVC
        vc.recivedData = data[indexPath.row]
        print(data[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].name
        cell.detailTextLabel?.text = data[indexPath.row].email
        return cell
    }
    
    private func fetchResult() {
        do {
            let contact = try PersistenceService.context.fetch(fetchRequest)
            handleRetrivedData(with: contact)
        } catch  {
            showMessage(with: "Some went wrong retriving your data \(error.localizedDescription)")
        }
    }

    private func handleRetrivedData(with retrivedData:[Contact]) {
        var realData = [Contact]()
        for x in 0..<retrivedData.count {
            if retrivedData[x].name != nil {
                realData.append(retrivedData[x])
            }
        }
        data = realData
    }
    
    private func updateNavBar() {
        if let navBar = self.navigationController?.navigationBar {
            navBar.topItem?.title = "CoreData Project"
            navBar.tintColor = UIColor.white
            navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            navBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.plain, target: self, action: #selector(addContact))
        }
    }

    // Perform pushViewController to AddDataVC
    @objc private func addContact() {
        let stb = UIStoryboard(name: "Main", bundle: nil)
        let vc = stb.instantiateViewController(withIdentifier: "AddDataVC") as! AddDataVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showMessage(with message: String) {
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
