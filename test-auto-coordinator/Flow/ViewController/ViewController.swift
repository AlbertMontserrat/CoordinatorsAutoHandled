//
//  ViewController.swift
//  test-auto-coordinator
//
//  Created by Albert Montserrat on 9/6/21.
//

import UIKit

class ViewController: UIViewController {

    let viewModel: ViewModelType

    let buttonPush: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapPush), for: .touchUpInside)
        button.setTitle("Push", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()

    let buttonPushNewFlow: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapPushNewFlow), for: .touchUpInside)
        button.setTitle("Push new flow", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()

    let buttonPresent: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapPresent), for: .touchUpInside)
        button.setTitle("Present", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        logging?("Init \(viewModel.titleText)", .darkGray)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        view.backgroundColor = .white

        let stackView = UIStackView(
            arrangedSubviews: [
                buttonPush,
                buttonPushNewFlow,
                buttonPresent
            ]
        )
        stackView.axis = .vertical

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
    }

    private func bindViewModel() {
        title = viewModel.titleText
    }

    @objc func didTapPush() {
        viewModel.didSelectPush()
    }

    @objc func didTapPushNewFlow() {
        viewModel.didSelectPushNewFlow()
    }

    @objc func didTapPresent() {
        viewModel.didSelectPresent()
    }

    deinit {
        logging?("Deinit \(viewModel.titleText)", .darkGray)
    }
}

