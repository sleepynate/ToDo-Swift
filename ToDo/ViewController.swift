//
//  ViewController.swift
//  ToDo
//
//  Created by nathan dotz on 7/21/17.
//  Copyright © 2017 Detroit Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    struct ToDoItem {
        var done: Bool
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
        toDoTable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Actions
    @IBAction func addToDoItemClicked(_ sender: UIButton) {
        addToDoItem(taskTextField.text)
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        taskTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        addToDoItem(taskTextField.text)
    }
    
    func addToDoItem(_ taskText: String?) {
        if let task = taskText {
            let item = ToDoItem(done: false, added: Date(), task:task)
            toDoItems.append(item)
            taskTextField.text = ""
            toDoTable.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return toDoItems.filter({item in !item.done}).count
        } else {
            return toDoItems.filter({item in item.done}).count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = toDoTable.dequeueReusableCell(withIdentifier: "reuseIdentifier", for:indexPath)
            as? ToDoItemTableViewCell else {
            fatalError("cell has wrong type")
        }
        let todo = toDoItems[indexPath.row]
        cell.taskLabel.text = todo.task
        cell.isCompleteSwitch.setOn(todo.done, animated: false)
        cell.onSwitchSelected = { uiSwitch in
            self.toDoItems[indexPath.row] = ToDoItem.init(done: uiSwitch.isOn, added: todo.added, task: todo.task)
        }
        return cell
    }
}

