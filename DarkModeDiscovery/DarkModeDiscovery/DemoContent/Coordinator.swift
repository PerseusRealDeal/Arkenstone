//
//  Coordinator.swift
//  DarkModeDiscovery
//
//  Created by Mikhail A. Zhigulin of Novosibirsk in 7534 (Mar 05, 2026.)
//
//  The year starts from the creation of the world according to a Slavic calendar.
//  September, the 1st of Slavic year. For instance, "Sep 01, 2025" is the beginning of 7534.
//
//  Unlicensed Free Software.
//

import Foundation
import ConsolePerseusLogger

class Coordinator {

    // MARK: - Screens

    lazy var screenMain = { () -> MainWindowController in
        return MainWindowController.storyboardInstance()
    }()

    lazy var screenLogger = { () -> LoggerWindowController in
        return LoggerWindowController.storyboardInstance()
    }()

    lazy var screenMap = { () -> MapWindowController in
        return MapWindowController.storyboardInstance()
    }()

    lazy var screenOptions = { () -> OptionsWindowController in
        return OptionsWindowController.storyboardInstance()
    }()

    // MARK: - Singletone

    static let shared = Coordinator()

    // MARK: - Initialization

    init() {
        log.message("[\(type(of: self))].\(#function)")
    }

    // MARK: - Contract

    static func start() {
        log.message("[\(type(of: self))].\(#function)")
    }

    static func mainWindowToFront() {
        shared.screenMain.window?.makeKeyAndOrderFront(nil)
    }
}
