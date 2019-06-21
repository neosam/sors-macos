//
//  ViewController.swift
//  sors-macos
//
//  Created by Simon Goller on 16.06.19.
//  Copyright © 2019 Simon Goller. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let home = NSHomeDirectory()
        let doc = loadSorsDoc(path: home + "/.tasks.json")
        let root = doc.root_task_id()
        let rootTask = doc.get_task(id: root)
        let rootTitle = rootTask.get_title()
        print("Root Title")
        print(rootTitle)

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

