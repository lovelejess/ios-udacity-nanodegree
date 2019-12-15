//
//  ResultsViewController.swift
//  Roshambo
//
//  Created by Jess Le on 12/14/19.
//  Copyright © 2019 lovelejess. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    var userSelectedType: RoshamboType!
    public var roshamboTypes: [String] = ["paper", "rock", "scissors"]

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var resultsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.cyan
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var playAgainButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play again!", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(playAgain), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let verticalStackView = createVerticalStackView()
        verticalStackView.addArrangedSubview(imageView)
        verticalStackView.addArrangedSubview(resultsLabel)
        verticalStackView.addArrangedSubview(playAgainButton)

        view.addSubview(verticalStackView)

        NSLayoutConstraint.activate([
            verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        displayResults()
    }

    func displayResults() {
        let generatedType = generateRandomType()
        let matchup = "\(userSelectedType.rawValue) vs. \(generatedType.rawValue)"
        switch(userSelectedType, generatedType) {
            case let (user, opponent) where user == opponent:
                resultsLabel.textColor = .purple
                resultsLabel.text = "\(matchup): it's a tie!"
                imageView.image = UIImage(named:"tie")
            case (.rock, .scissors), (.paper, .rock), (.scissors, .paper):
                resultsLabel.text = "You win with \(matchup)!"
                resultsLabel.textColor = .green
                imageView.image = UIImage(named:"\(userSelectedType.rawValue)-\(generatedType.rawValue)")
            default:
                resultsLabel.text = "You lose with \(matchup) :(."
                resultsLabel.textColor = .orange
                imageView.image = UIImage(named:"\(generatedType.rawValue)-\(userSelectedType.rawValue)")
            }
    }

    func generateRandomType() -> RoshamboType {
        let random = roshamboTypes[Int(arc4random_uniform(3))]
        return RoshamboType(rawValue: random)!
    }

    func createVerticalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

    @objc func playAgain() {
        self.dismiss(animated: true, completion: nil)
    }
}
