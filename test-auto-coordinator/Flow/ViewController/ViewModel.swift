//
//  ViewModel.swift
//  test-auto-coordinator
//
//  Created by Albert Montserrat on 9/6/21.
//

import Foundation

protocol ViewModelDelegate {
    func didSelectPush()
    func didSelectPushNewFlow()
    func didSelectPresent()
}

protocol ViewModelType {
    var titleText: String { get }
    func didSelectPush()
    func didSelectPushNewFlow()
    func didSelectPresent()
}

class ViewModel {

    let delegate: ViewModelDelegate
    let counter: Int

    init(delegate: ViewModelDelegate, counter: Int) {
        self.delegate = delegate
        self.counter = counter
        logging?("Init View model \(counter)", .gray)
    }

    deinit {
        logging?("Deinit View model \(counter)", .gray)
    }
}

extension ViewModel: ViewModelType {
    var titleText: String {
        return "View controller \(counter)"
    }

    func didSelectPush() {
        delegate.didSelectPush()
    }

    func didSelectPushNewFlow() {
        delegate.didSelectPushNewFlow()
    }

    func didSelectPresent() {
        delegate.didSelectPresent()
    }
}
