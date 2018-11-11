//
//  AddDataVC.swift
//  CoreDataProject
//
//  Created by Lucas Moraes on 20/12/2017.
//  Copyright © 2017 LSolutions. All rights reserved.
//

import UIKit
import CoreData

class AddDataVC: UIViewController {
    
    @IBOutlet weak var nameTXF: UITextField!
    @IBOutlet weak var emailTXF: UITextField!
    @IBOutlet weak var ageTXF: UITextField!
    @IBOutlet weak var addBTN: CustomButton!
    
    private let contact = Contact(context: PersistenceService.context)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavBar()
    }
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated) }
  
    @IBAction func addContact(_ sender: UIButton) {
        
        if nameTXF.text == "" || emailTXF.text == "" || ageTXF.text == "" {
            AlertService.AlertWithAction(in: self, withMessage: "Don't leave any fields empty") {
                return
            }
        } else {
            self.contact.name = nameTXF.text
            self.contact.email = emailTXF.text
            self.contact.age = Int32(ageTXF.text!)!
            
            PersistenceService.saveContext()
            AlertService.AlertWithAction(in: self, withMessage: "Contact Saved") {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func updateNavBar() {
        if let navBar = self.navigationController?.navigationBar {
            navBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: self, action: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
