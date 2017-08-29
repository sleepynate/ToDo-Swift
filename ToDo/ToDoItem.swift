//
//  ToDoItem.swift
//  ToDo
//
//  Created by nathan dotz on 8/15/17.
//  Copyright © 2017 Detroit Labs. All rights reserved.
//

import Foundation
import os.log

class ToDoItem : NSObject, NSCoding {
    
    let done: Bool
    let added: Date
    let task: String

    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("todos")
    
    
    init(done: Bool, added: Date, task: String) {
        self.done = done
        self.added = added
        self.task = task
    }
    
    //MARK: Types
    
    struct PropertyKey {
        static let done = "done"
        static let added = "added"
        static let task = "task"
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(done, forKey: PropertyKey.done)
        aCoder.encode(added, forKey: PropertyKey.added)
        aCoder.encode(task, forKey: PropertyKey.task)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        guard let done = aDecoder.decodeBool(forKey: PropertyKey.done) as? Bool else {
            os_log("Could not decode ToDoItem")
            return nil
        }
        let added = aDecoder.decodeObject(forKey: PropertyKey.added) as! Date
        let task = aDecoder.decodeObject(forKey: PropertyKey.task) as! String
        self.init(done: done, added: added, task: task)
    }
    
}
