//
//  sors.swift
//  sors-macos
//
//  Created by Simon Goller on 19.06.19.
//  Copyright © 2019 Simon Goller. All rights reserved.
//

import Foundation

struct SorsId {
    var id: OpaquePointer
    
    init(id: OpaquePointer) {
        self.id = id
    }
}

struct SorsTask {
    var task: OpaquePointer
    
    init(task: OpaquePointer) {
        self.task = task
    }
    
    func get_title() -> String {
        let cStringTitle = sors_task_title(self.task)!
        return String.init(cString: cStringTitle)
        
    }
}

class SorsDoc {
    var doc: OpaquePointer
    
    init(doc: OpaquePointer) {
        self.doc = doc
    }
    
    func root_task_id() -> SorsId {
        let id = sors_doc_root_id(self.doc)
        return SorsId(id: id!)
    }
    
    func get_task(id: SorsId) -> SorsTask {
        let task = sors_doc_get_task(self.doc, id.id)
        return SorsTask(task: task!)
    }
}

func loadSorsDoc(path: String) -> SorsDoc {
    let pathNsString = (path as NSString).utf8String
    //let unsafeString = UnsafeMutablePointer<Int8>(pathNsString!)
    return SorsDoc(doc: sors_doc_load(pathNsString))
}
