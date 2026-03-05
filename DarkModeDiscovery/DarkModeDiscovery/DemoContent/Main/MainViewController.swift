//
//  MainViewController.swift
//  DarkModeDiscovery
//
//  Created by Mikhail A. Zhigulin of Novosibirsk.
//
//  Unlicensed Free Software.
//

import Cocoa

import ConsolePerseusLogger
import PerseusDarkMode

class MainViewController: NSViewController {

    // MARK: - Presenter

    var presenter: MainViewPresenter?

    // MARK: - Life Circle

    override func viewDidAppear() {
        super.viewDidAppear()

        presenter?.viewDidAppear()
    }

    // MARK: - Outlets

    @IBOutlet weak var splitView: NSSplitView!
    @IBOutlet weak var leftSplitWidthConstraint: NSLayoutConstraint!

    // MARK: - SubViewControllers

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

// MARK: - MVP View

extension MainViewController: MainViewDelegate {

    // MARK: - MainViewDelegate

    func onViewDidAppear() {
        log.message("[\(type(of: self))].\(#function)")
    }

    // MARK: - MVPViewDelegate

    func setupUI() {

        log.message("[\(type(of: self))].\(#function)")

        view.wantsLayer = true

        // report.messageDelegate = labelGreeting
        // labelGreeting.messageTextColor = .perseusYellow
    }

    func makeUp() {

        log.message("[\(type(of: self))].\(#function), DarkMode: \(DarkMode.style)")

        // view.layer?.backgroundColor = NSColor.perseusBlue.cgColor

        view.window?.title = DarkMode.style == .dark ? "Erebor" : "The Lonely Mountain"

        if isHighSierra {
            view.window?.appearance = DarkModeAgent.DarkModeUserChoice == .on ?
            DARK_APPEARANCE_DEFAULT_IN_USE : LIGHT_APPEARANCE_DEFAULT_IN_USE
        }
    }
}
