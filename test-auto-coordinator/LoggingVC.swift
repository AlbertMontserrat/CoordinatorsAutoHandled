//
//  LoggingVC.swift
//  test-auto-coordinator
//
//  Created by Albert Montserrat on 9/6/21.
//

import UIKit

class LoggingVC: UIViewController {

    let dateFormatter = DateFormatter()

    lazy var loggingCallback: (String, UIColor) -> Void = { [weak self] text, color in
        self?.appendLabel(with: text, color: color)
    }

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }

    func appendLabel(with text: String, color: UIColor) {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = color
        label.text = "\(nowDate()) - \(text)"
        stackView.addArrangedSubview(label)

        if stackView.arrangedSubviews.count > 30 {
            let view = stackView.arrangedSubviews[0]
            stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }

    func nowDate() -> String {
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: Date())
    }
}
