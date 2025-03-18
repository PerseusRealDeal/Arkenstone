//
//  LocationVC.swift
//  Arkenstone
//
//  Created by Mikhail Zhigulin in 7533 (18.03.2025).
//
//  Copyright © 7531 - 7533 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7531 - 7533 PerseusRealDeal
//
//  Licensed under the special license. See LICENSE file.
//  All rights reserved.
//

import Cocoa

class LocationViewController: NSViewController {

    override func viewDidAppear() {
        super.viewDidAppear()

        self.view.wantsLayer = true
        // self.view.layer?.backgroundColor = NSColor.blue.cgColor

        self.parent?.view.window?.title = self.title!
    }
}
