//
//  ViewController.swift
//  ToDo
//
//  Created by nathan dotz on 7/21/17.
//  Copyright © 2017 Detroit Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate {

    struct ToDoItem {
        let done: Bool
        let added: Date
        let task: String
    }

    
    //MARK: Properties
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var toDoTable: UITableView!
    
    var toDoItems = [ToDoItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        taskTextField.delegate = self
        toDoTable.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Actions
    @IBAction func addToDoItemClicked(_ sender: UIButton) {
        addToDoItem()
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        taskTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        addToDoItem()
    }
    
    func addToDoItem() {
        if let task = taskTextField.text {
            let item = ToDoItem(done: false, added: Date(), task:task)
            toDoItems.append(item)
            taskTextField.text = ""
        }
    }
    
}

