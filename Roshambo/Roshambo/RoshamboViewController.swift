//
//  RoshamboViewController.swift
//  Roshambo
//
//  Created by Jess Le on 12/14/19.
//  Copyright © 2019 lovelejess. All rights reserved.
//

import UIKit

class RoshamboViewController: UIViewController {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.red
        label.text = "Choose Rock, Paper, or Scissors"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var rockButton: UIButton = {
        let button = UIButton()
        button.accessibilityIdentifier = "rock"
        button.setImage(UIImage(named: "rock"), for: .normal)
        button.addTarget(self, action: #selector(roshamboSelected), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var paperButton: UIButton = {
        let button = UIButton()
        button.accessibilityIdentifier = "paper"
        button.setImage(UIImage(named: "paper"), for: .normal)
        button.addTarget(self, action: #selector(roshamboSelected), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var scissorsButton: UIButton = {
        let button = UIButton()
        button.accessibilityIdentifier = "scissors"
        button.setImage(UIImage(named: "scissors"), for: .normal)
        button.addTarget(self, action: #selector(roshamboSelected), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let horizontalStackView = createHorizontalStackView()
        horizontalStackView.addArrangedSubview(rockButton)
        horizontalStackView.addArrangedSubview(paperButton)
        horizontalStackView.addArrangedSubview(scissorsButton)

        view.addSubview(horizontalStackView)
        view.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: horizontalStackView.topAnchor, constant: -20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            horizontalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            horizontalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc func roshamboSelected(_ sender: UIButton) {
        let imageName = sender.accessibilityIdentifier
        if let selectedType = getRoshamboType(for: imageName!) {
            let resultsViewController = ResultsViewController()
            resultsViewController.userSelectedType = selectedType
            present(resultsViewController, animated: true, completion: nil)
        }
    }

    func getRoshamboType(for type: String) -> RoshamboType? {
        return RoshamboType(rawValue: type)
    }

    func createHorizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
}

enum RoshamboType: String {
    case rock = "rock"
    case paper = "paper"
    case scissors = "scissors"
}
