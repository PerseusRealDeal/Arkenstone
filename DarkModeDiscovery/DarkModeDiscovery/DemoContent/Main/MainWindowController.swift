//
//  MainWindowController.swift, MainWindowController.storyboard
//  DarkModeDiscovery
//
//  Created by Mikhail A. Zhigulin of Novosibirsk.
//
//  Unlicensed Free Software.
//

import Cocoa

import ConsolePerseusLogger
import PerseusDarkMode

extension MainWindowController {

    class func storyboardInstance() -> MainWindowController {

        let storyboard = NSStoryboard(name: String(describing: self), bundle: nil)
        let screen = storyboard.instantiateInitialController() as? MainWindowController

        if let vc = screen?.contentViewController as? MainViewController {
            vc.presenter = MainViewPresenter(view: vc)
            vc.presenter?.viewDidLoad()
        }

        // Do default setup; don't set any parameter causing loadView up, breaks unit tests

        // screen?.modalTransitionStyle = UIModalTransitionStyle.partialCurl
        // screen?.view.backgroundColor = UIColor.yellow

        return screen ?? MainWindowController()
    }
}

class MainWindowController: NSWindowController, NSWindowDelegate {

    override func windowDidLoad() {
        super.windowDidLoad()

        log.message("[\(type(of: self))].\(#function)")

        if let window = self.window {
            window.delegate = self
        } else {
            log.message("[\(type(of: self))].\(#function) window instance is nil", .error)
        }
    }

    // MARK: - Actions

    @IBAction func showOptions(_ sender: NSMenuItem) {
        Coordinator.shared.screenOptions.showWindow(sender)
    }

    @IBAction func showMap(_ sender: NSMenuItem) {
        Coordinator.shared.screenMap.showWindow(sender)
    }

    @IBAction func showLogger(_ sender: Any) {
        Coordinator.shared.screenLogger.showWindow(sender)
    }

    // MARK: - NSWindowDelegate

    func windowWillClose(_ notification: Notification) {
        log.message("[\(type(of: self))].\(#function)")
        AppGlobals.quitTheApp()
    }

    func windowShouldClose(_ sender: NSWindow) -> Bool {
        log.message("[\(type(of: self))].\(#function)", .info)
        return true
    }
}
