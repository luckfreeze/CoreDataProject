//
//  EditDataVC.swift
//  CoreDataProject
//
//  Created by Lucas Moraes on 21/12/2017.
//  Copyright © 2017 LSolutions. All rights reserved.
//

import UIKit
import CoreData

class EditDataVC: UIViewController {
    
    @IBOutlet weak var nameTXF: UITextField!
    @IBOutlet weak var emailTXF: UITextField!
    @IBOutlet weak var ageTXF: UITextField!
    
    private let contact = Contact(context: PersistenceService.context)
    
    var recivedData: Contact? // this variable hands with the data  AMAZING

    override func viewDidLoad() {
        super.viewDidLoad()
        getDataRecived()
        updateNavBar()
    }
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated) }
    
    private func updateNavBar() {
        if let navBar = self.navigationController?.navigationBar {
            navBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: nil)
            navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        }
    }
    
    private func getDataRecived() {
        if recivedData != nil {
            self.nameTXF.text = recivedData?.name
            self.emailTXF.text = recivedData?.email
            self.ageTXF.text = String(describing: recivedData!.age)
        }
    }
    
    @IBAction func updateContact(_ sender: UIButton) {
        
        if nameTXF.text == "" || emailTXF.text == "" || ageTXF.text == "" {
            AlertService.AlertWithAction(in: self, withMessage: "Don't leave any fields empty") {
                return
            }
        } else {
            self.recivedData?.name = nameTXF.text
            self.recivedData?.email = emailTXF.text
            self.recivedData?.age = Int32(ageTXF.text!)!
            
            PersistenceService.saveContext()
            AlertService.AlertWithAction(in: self, withMessage: "Contact Edited") {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
