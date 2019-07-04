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

    
    func getTitle() -> String {
        let cStringTitle = sors_task_title(self.task)!
        return String.init(cString: cStringTitle)
    }
    
    func getBody() -> String {
        let cStringBody = sors_task_body(self.task)!
        return String.init(cString: cStringBody)
    }
    
    func getChildrenCount() -> Int {
        Int(sors_task_children_count(self.task))
    }
    
    func getChild(i: Int) -> SorsId {
        SorsId(id: sors_task_children_get(self.task, Int32(i)))
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
    
    func update_title(id: SorsId, title: String) {
        let titleNsString = (title as NSString).utf8String
        let new_doc = sors_doc_update_task_title(self.doc, id.id, titleNsString)
        self.doc = new_doc!
    }
    
    func update_body(id: SorsId, body: String) {
        let bodyNsString = (body as NSString).utf8String
        let new_doc = sors_doc_update_task_body(self.doc, id.id, bodyNsString)
        self.doc = new_doc!
    }
}

func loadSorsDoc(path: String) -> SorsDoc {
    let pathNsString = (path as NSString).utf8String
    //let unsafeString = UnsafeMutablePointer<Int8>(pathNsString!)
    return SorsDoc(doc: sors_doc_load(pathNsString))
}
