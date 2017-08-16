//
//  QFWindowController.swift
//  QuickFunction
//
//  Created by Joshua Wu on 8/7/17.
//  Copyright © 2017 None. All rights reserved.
//

import Cocoa

class QFWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    @available(OSX 10.12.2, *)
    override func makeTouchBar() -> NSTouchBar? {
        guard let viewController = contentViewController as? ViewController else {
            return nil
        }
        return viewController.makeTouchBar()
    }

}
