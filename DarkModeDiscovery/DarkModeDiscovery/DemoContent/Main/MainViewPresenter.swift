//
//  MainViewPresenter.swift
//  Arkenstone
//
//  Created by Perseus on 05.03.2026.
//  Copyright © 2026 PerseusRealDeal. All rights reserved.
//

import Foundation

import ConsolePerseusLogger
import PerseusDarkMode

// MARK: - MainWindow Communication

protocol MainViewDelegate: MVPViewDelegate {
    func onViewDidAppear()
}

// MARK: - MainWindow Business Logic

class MainViewPresenter: MVPPresenter {

    // MARK: - Initialization

    init(view: MainViewDelegate) {
        super.init(view: view)
    }

    // MARK: - Life Circle

    func viewDidLoad() {

        log.message("[\(type(of: self))].\(#function)")

        view?.setupUI()
        view?.makeUp()
    }

    func viewDidAppear() {
        log.message("[\(type(of: self))].\(#function)")
        (view as? MainViewDelegate)?.onViewDidAppear()
    }

    // MARK: - Contract

    // MARK: - Realization (private methods)
}
