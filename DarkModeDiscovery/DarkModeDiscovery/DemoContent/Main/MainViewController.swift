//
//  MainViewController.swift
//  DarkModeDiscovery
//
//  Created by Mikhail A. Zhigulin of Novosibirsk.
//
//  Unlicensed Free Software.
//

import Cocoa

class MainViewController: NSViewController {

    @IBOutlet weak var splitView: NSSplitView!
    @IBOutlet weak var leftSplitWidthConstraint: NSLayoutConstraint!

    var companionListViewController: CompanionListViewController? {
        didSet {
            companionListViewController?.companionList = companions
        }
    }

    var companionViewController: CompanionViewController? {
        didSet {
            companionListViewController?.companionListSelectionHandler = { companion in
                self.companionViewController?.companion = companion
            }
        }
    }

    lazy var companions: [Companion] = {
        guard let fileURL = Bundle.main.url(forResource: "companions", withExtension: "json"),
            let data = try? Data(contentsOf: fileURL)
            else { return [] }

        return (try? JSONDecoder().decode([Companion].self, from: data)) ?? []
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let width = leftSplitWidthConstraint.constant
        splitView.setPosition(width, ofDividerAt: 0)
    }

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {

        switch segue.destinationController {

        case let companionListViewController as CompanionListViewController:
            self.companionListViewController = companionListViewController

        case let companionViewController as CompanionViewController:
            self.companionViewController = companionViewController

        default:
            break
        }
    }
}
