//
//  main.swift
//  DarkModeDiscovery
//
//  Created by Mikhail A. Zhigulin of Novosibirsk.
//
//  Unlicensed Free Software.
//

import Cocoa
import ConsolePerseusLogger

import class PerseusDarkMode.PerseusLogger
import class PerseusGeoKit.PerseusLogger

import struct PerseusDarkMode.LogMessage
import struct PerseusGeoKit.LogMessage

// swiftlint:disable type_name
typealias DM_LOG = PerseusDarkMode.PerseusLogger
typealias GEO_LOG = PerseusGeoKit.PerseusLogger
// swiftlint:enable type_name

// MARK: - The PerseusDarkMode Logger

func report(_ message: PerseusDarkMode.LogMessage) {
    let text = "[\(message.localTime.date)] [\(message.localTime.time)] \(message.text)"
    localReport.lastMessage = "SUB_DM: " + text
}

DM_LOG.customActionOnMessage = report(_:)
DM_LOG.output = .custom
// DM_LOG.turned = .off

// MARK: - The PerseusGeoKit Logger

func report(_ message: PerseusGeoKit.LogMessage) {
    let text = "[\(message.localTime.date)] [\(message.localTime.time)] \(message.text)"
    localReport.lastMessage = "SUB_GEO: " + text
}

GEO_LOG.customActionOnMessage = report(_:)
GEO_LOG.output = .custom
// GEO_LOG.turned = .off

// MARK: - The Logger

let localReport = ConsolePerseusLogger.PerseusLogger.Report()

log.customActionOnMessage = localReport.report(_:)
log.output = .custom
// log.turned = .off

// MARK: - The start line

log.message("The start line...", .info)

let globals = AppGlobals()

let app = NSApplication.shared
let appPurpose = NSClassFromString("TestingAppDelegate") as? NSObject.Type
let appDelegate = appPurpose?.init() ?? AppDelegate()

let mainMenu = NSNib(nibNamed: NSNib.Name("MainMenu"), bundle: nil)

Coordinator.start()

// MARK: - The app's run

log.message("The app is about to run...", .info)

/*

 .accessory

 The application doesn’t appear in the Dock and doesn’t have a menu bar, but it may be
 activated programmatically or by clicking on one of its windows.

 */

app.setActivationPolicy(.regular)
mainMenu?.instantiate(withOwner: app, topLevelObjects: nil)

Coordinator.mainWindowToFront()

app.delegate = appDelegate as? NSApplicationDelegate
app.activate(ignoringOtherApps: true)

app.run()
