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
        
        self.contact.name = nameTXF.text
        self.contact.email = emailTXF.text
        self.contact.age = Int32(ageTXF.text!)!
        
        PersistenceService.saveContext()
        showMessage(withMessage: "Contact Saved")
    }
    
    private func updateNavBar() {
        if let navBar = self.navigationController?.navigationBar {
            navBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        }
    }
    
    private func showMessage(withMessage message: String) {
        
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default) { (_) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
