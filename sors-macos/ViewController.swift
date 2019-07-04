//
//  ViewController.swift
//  sors-macos
//
//  Created by Simon Goller on 16.06.19.
//  Copyright © 2019 Simon Goller. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSOutlineViewDataSource, NSOutlineViewDelegate {

    /*@IBOutlet weak var taskTitleLabel: NSTextField!
    @IBOutlet weak var taskBodyLabel: NSTextField!*/
    @IBOutlet weak var taskTitleLabel: NSTextField!
    @IBOutlet weak var taskBodyLabel: NSTextField!
    @IBOutlet weak var outlineView: NSOutlineView!
    var doc: SorsDoc!
    var selectedId: SorsId!
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if doc == nil {
            return 0
        }
        if item == nil {
            return 1;
            /*let rootId = doc.root_task_id()
            let rootTask = doc.get_task(id: rootId)
            return rootTask.getChildrenCount() as Int*/
        }
        if let taskId = item as? SorsId {
            let task = doc.get_task(id: taskId)
            return task.getChildrenCount()
        }
        return 0
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        if let taskId = item as? SorsId {
            let task = doc.get_task(id: taskId)
            return task.getChildrenCount() > 0
        }
        return true
        
    }
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        let titleCellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "TitleCell")
        if let taskId = item as? SorsId {
            let task = doc.get_task(id: taskId)
            if let cell = outlineView.makeView(withIdentifier: titleCellIdentifier, owner: nil) as? NSTableCellView {
                    cell.textField?.stringValue = task.getTitle()
                    cell.textField?.sizeToFit()
                    return cell
            }
        }
        return nil
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        /*if let feed = item as? Feed {
            return feed.children[index]
        }*/
        if let taskId = item as? SorsId {
            let task = doc.get_task(id: taskId)
            return task.getChild(i: index)
        }
        return doc.root_task_id()
        
        //return feeds[index]
    }
    
    func outlineViewSelectionDidChange(_ notification: Notification) {
        guard let outlineView = notification.object as? NSOutlineView else {
            return
        }
        let selectedIndex = outlineView.selectedRow
        if let taskId = outlineView.item(atRow: selectedIndex) as? SorsId {
            selectedId = taskId
            displayTaks()
        }
    }
    
    /*func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        // 3
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "titleCell"), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = "Hello"
            //cell.imageView?.image = image ?? nil
            debugPrint("Add cell")
            return cell
        }
        return nil
    }*/
    
    func displayTaks() {
        let rootTask = doc.get_task(id: selectedId)
        let rootTitle = rootTask.getTitle()
        taskTitleLabel.stringValue = rootTitle
        taskBodyLabel.stringValue = rootTask.getBody()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let home = NSHomeDirectory()
        doc = loadSorsDoc(path: home + "/.tasks.json")
        selectedId = doc.root_task_id()
        displayTaks()
        outlineView.dataSource = self
        outlineView.delegate = self
    }

    @IBAction func onUpdateTask(_ sender: Any) {
        doc.update_body(id: selectedId, body: taskBodyLabel.stringValue)
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

