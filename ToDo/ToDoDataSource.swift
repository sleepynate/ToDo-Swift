//
//  ToDoDataSource.swift
//  ToDo
//
//  Created by nathan dotz on 8/29/17.
//  Copyright © 2017 Detroit Labs. All rights reserved.
//

import Foundation
import os.log

class ToDoDataSource {
    
    var toDoItems = [ToDoItem]()
    
    func load() {
        if let items = NSKeyedUnarchiver.unarchiveObject(withFile: ToDoItem.ArchiveURL.path) as? [ToDoItem] {
            toDoItems = items
        }
    }

    func add(_ task: String) {
        let item = ToDoItem(done: false, added: Date(), task: task)
        toDoItems.append(item)
        save()
    }
    
    func finish(_ toDo: ToDoItem) {
        if let idx = toDoItems.index(of: toDo) {
            toDoItems[idx] = ToDoItem.init(done: true, added: toDo.added, task: toDo.task)
            save()
        } else {
            os_log("Could not find ToDo item to finish")
        }
    }

    func start(_ toDo: ToDoItem) {
        if let idx = toDoItems.index(of: toDo) {
            toDoItems[idx] = ToDoItem.init(done: false, added: toDo.added, task: toDo.task)
            save()
        } else {
            os_log("Could not find ToDo item to start")
        }
    }

    
    func done() -> [ToDoItem] {
        return toDoItems.filter { $0.done }
    }
    
    func notDone() -> [ToDoItem] {
        return toDoItems.filter { !$0.done }
    }
    
    func countDone() -> Int {
        return done().count
    }
    
    func countNotDone() -> Int {
        return notDone().count
    }
    
    private func save() {
        let success = NSKeyedArchiver.archiveRootObject(toDoItems, toFile: ToDoItem.ArchiveURL.path)
        if (success) {
            os_log("ToDos successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
}
