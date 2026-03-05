//
//  CompanionCollectionViewItem.swift, CompanionCollectionViewItem.xib
//  DarkModeDiscovery
//
//  Created by Mikhail A. Zhigulin of Novosibirsk.
//
//  Unlicensed Free Software.
//

import Cocoa
import PerseusDarkMode

class CompanionCollectionViewItem: NSCollectionViewItem {

    private let theDarknessTrigger = DarkModeObserver()

    override var isSelected: Bool {
        didSet {
            super.isSelected = isSelected

            imageView?.layer?.borderWidth = isSelected ? 5.0 : 0.0
            makeUp()
        }
    }

    var companion: Companion? {
        didSet {
            guard isViewLoaded else { return }

            updateData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        theDarknessTrigger.action = { _ in self.makeUp() }

        makeUp()
        updateData()
    }

    func updateData() {
        guard let friend = self.companion else { return }

        textField?.stringValue = friend.name
        imageView?.image = NSImage(named: friend.iconName)
    }

    private func makeUp() {
        imageView?.layer?.borderColor = NSColor.customChosenOne.cgColor
        textField?.textColor = isSelected ?
            .customLabel : (DarkMode.style == .light ? .white : .black)
    }
}
