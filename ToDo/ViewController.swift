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
    
    let dataSource = ToDoDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        taskTextField.delegate = self
        toDoTable.delegate = self
        toDoTable.dataSource = self
        
        dataSource.load()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
            dataSource.add(task)
            taskTextField.text = ""
            toDoTable.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return dataSource.countNotDone()
        } else {
            return dataSource.countDone()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = toDoTable.dequeueReusableCell(withIdentifier: "reuseIdentifier", for:indexPath)
            as? ToDoItemTableViewCell else {
            fatalError("cell has wrong type")
        }
        let todo = (indexPath.section == 0 ? dataSource.notDone() : dataSource.done())[indexPath.row]
        
        cell.taskLabel.text = todo.task
        cell.isCompleteSwitch.setOn(todo.done, animated: false)
        cell.onSwitchSelected = { uiSwitch in
            let isDone = uiSwitch.isOn
            if(isDone) {
                self.dataSource.finish(todo)
            } else {
                self.dataSource.start(todo)
            }
            self.toDoTable.reloadData()
        }
        return cell
    }
    
}

