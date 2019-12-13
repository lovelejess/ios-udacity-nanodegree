//
//  ViewController.swift
//  ColorSliders
//
//  Created by Jess Le on 12/11/19.
//  Copyright © 2019 lovelejess. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    
    lazy var redLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.red
        label.text = "Red"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var greenLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.green
        label.text = "Green"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var blueLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.blue
        label.text = "Blue"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var colorView: UIView = {
       let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var redSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.addTarget(self, action: #selector(onSliderValueUpdated), for: .valueChanged)
        return slider
    }()
    
    lazy var greenSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.addTarget(self, action: #selector(onSliderValueUpdated), for: .valueChanged)
        return slider
    }()
    
    lazy var blueSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.addTarget(self, action: #selector(onSliderValueUpdated), for: .valueChanged)
        
        return slider
    }()

    @objc func onSliderValueUpdated(sender: UISlider) {
        red = CGFloat(redSlider.value)
        green = CGFloat(greenSlider.value)
        blue = CGFloat(blueSlider.value)
        colorView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black

        let redHorizontalStackView = createHorizontalStackView()
        redHorizontalStackView.addArrangedSubview(redLabel)
        redHorizontalStackView.addArrangedSubview(redSlider)
        
        let greenHorizontalStackView = createHorizontalStackView()
        greenHorizontalStackView.addArrangedSubview(greenLabel)
        greenHorizontalStackView.addArrangedSubview(greenSlider)
        
        let blueHorizontalStackView = createHorizontalStackView()
        blueHorizontalStackView.addArrangedSubview(blueLabel)
        blueHorizontalStackView.addArrangedSubview(blueSlider)

        let verticalStackView = createStackView()
        verticalStackView.addArrangedSubview(redHorizontalStackView)
        verticalStackView.addArrangedSubview(greenHorizontalStackView)
        verticalStackView.addArrangedSubview(blueHorizontalStackView)
        view.addSubview(verticalStackView)
        view.addSubview(colorView)

        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
            verticalStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
            verticalStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
            colorView.heightAnchor.constraint(equalToConstant: 200),
            colorView.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 100),
            colorView.leadingAnchor.constraint(equalTo: verticalStackView.layoutMarginsGuide.leadingAnchor, constant: 20),
            colorView.trailingAnchor.constraint(equalTo: verticalStackView.layoutMarginsGuide.trailingAnchor, constant: -20),
        ])
    }

    func createHorizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 50
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
}

