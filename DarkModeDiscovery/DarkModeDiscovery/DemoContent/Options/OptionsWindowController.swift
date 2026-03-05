//
//  OptionsWindowController.swift, Options.storyboard
//  DarkModeDiscovery
//
//  Created by Mikhail A. Zhigulin of Novosibirsk.
//
//  Unlicensed Free Software.
//

import Cocoa
import ConsolePerseusLogger
import PerseusDarkMode

extension OptionsWindowController {

    class func storyboardInstance() -> OptionsWindowController {

        let storyboard = NSStoryboard(name: String(describing: self), bundle: nil)
        let screen = storyboard.instantiateInitialController() as? OptionsWindowController

        // Do default setup; don't set any parameter causing loadView up, breaks unit tests

        // screen?.modalTransitionStyle = UIModalTransitionStyle.partialCurl
        // screen?.view.backgroundColor = UIColor.yellow

        return screen ?? OptionsWindowController()
    }
}

class OptionsWindowController: NSWindowController, NSWindowDelegate {

    override func windowDidLoad() {
        super.windowDidLoad()

        self.window?.title = "Options..."

        // Connect to Dark Mode explicitly
        DarkModeAgent.register(stakeholder: self, selector: #selector(makeUp))
        makeUp()// That's for now, call if not the first, main, screen.
    }

    @objc private func makeUp() {

        log.message("[\(type(of: self))].\(#function), DarkMode: \(DarkMode.style)")

        // view.layer?.backgroundColor = NSColor.perseusBlue.cgColor

        self.window?.appearance = DARK_APPEARANCE_DEFAULT_IN_USE

        /*
        if isHighSierra {
            self.window?.appearance = DarkModeAgent.DarkModeUserChoice == .on ?
            DARK_APPEARANCE_DEFAULT_IN_USE : LIGHT_APPEARANCE_DEFAULT_IN_USE
        }
        */
    }
}
