//
//  ViewController.swift
//  ClickCounter
//
//  Created by Jess Le on 12/9/19.
//  Copyright © 2019 lovelejess. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var count: Int = 0
    
    lazy var incrementButton: UIButton = {
        let button = UIButton()
        button.setImage(.add, for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(incrementCount), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    lazy var duplicateCounterLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var decrementButton: UIButton = {
        let button = UIButton()
        button.setImage(.remove, for: .normal)
        button.setTitleColor(.cyan, for: .normal)
        button.addTarget(self, action: #selector(decrementCount), for: .touchUpInside)

        // DO NOT FORGET TO SET THIS LINE TO FALSE OTHERWISE AUTOLAYOUT DOESNT WORK
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var backgroundButton: UIButton = {
        let button = UIButton()
        button.setImage(.actions, for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.addTarget(self, action: #selector(changeBackgroundColor), for: .touchUpInside)

        // DO NOT FORGET TO SET THIS LINE TO FALSE OTHERWISE AUTOLAYOUT DOESNT WORK
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let horizontalButtonStack = createStackView()
        horizontalButtonStack.axis = .horizontal
        horizontalButtonStack.addArrangedSubview(incrementButton)
        horizontalButtonStack.addArrangedSubview(decrementButton)
        
        let horizontalLabelStack = createStackView()
        horizontalLabelStack.axis = .horizontal
        horizontalLabelStack.addArrangedSubview(counterLabel)
        horizontalLabelStack.addArrangedSubview(duplicateCounterLabel)

        let horizontalBackgroundButtonStack = createStackView()
        horizontalBackgroundButtonStack.axis = .horizontal
        horizontalBackgroundButtonStack.addArrangedSubview(backgroundButton)

        let verticalStack = createStackView()
        verticalStack.axis = .vertical
        verticalStack.spacing = 5
        verticalStack.addArrangedSubview(horizontalLabelStack)
        verticalStack.addArrangedSubview(horizontalButtonStack)
        verticalStack.addArrangedSubview(horizontalBackgroundButtonStack)
        view.addSubview(verticalStack)

        NSLayoutConstraint.activate([
            verticalStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            verticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStack.heightAnchor.constraint(equalToConstant: 200),
            verticalStack.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc func incrementCount() {
        count+=1
        counterLabel.text = "\(count)"
        duplicateCounterLabel.text = "\(count)"
    }

    @objc func decrementCount() {
        count-=1
        counterLabel.text = "\(count)"
        duplicateCounterLabel.text = "\(count)"
    }

    @objc func changeBackgroundColor() {
        let colors: [UIColor] = [.blue, .green, .brown, .purple, .white, .cyan, .gray, .red, .orange, .yellow]
        view.backgroundColor = colors.randomElement()!
    }
}

