//
//  ViewController.swift
//  ToDo
//
//  Created by nathan dotz on 7/21/17.
//  Copyright © 2017 Detroit Labs. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
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
        
        if let saved = loadToDos() {
            toDoItems += saved
        }
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
            saveToDos()
            toDoTable.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            let count = toDoItems.filter({item in !item.done}).count
            print("count for section 0 was \(count)")
            return count
        } else {
            let count = toDoItems.filter({item in item.done}).count
            print("count for section 1 was \(count)")
            return count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = toDoTable.dequeueReusableCell(withIdentifier: "reuseIdentifier", for:indexPath)
            as? ToDoItemTableViewCell else {
            fatalError("cell has wrong type")
        }
        let todo = toDoItems.filter({item in indexPath.section == 0 ? !item.done : item.done})[indexPath.row]
        cell.taskLabel.text = todo.task
        cell.isCompleteSwitch.setOn(todo.done, animated: false)
        cell.onSwitchSelected = { uiSwitch in
            let isDone = uiSwitch.isOn
            let section = isDone ? 1 : 0
            let moveTo = IndexPath.init(row: self.toDoTable.numberOfRows(inSection: section), section: section)
            self.toDoItems[indexPath.row] = ToDoItem.init(done: isDone, added: todo.added, task: todo.task)
            self.toDoTable.beginUpdates()
            print("moving from \(indexPath) to \(moveTo)")
            self.toDoTable.moveRow(at: indexPath, to: moveTo)
            self.toDoTable.endUpdates()
        }
        return cell
    }
    
    //MARK: Private Methods
    private func saveToDos() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(toDoItems, toFile: ToDoItem.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("ToDos successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadToDos() -> [ToDoItem]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: ToDoItem.ArchiveURL.path) as? [ToDoItem]
    }
}

