//
//  ViewController.swift
//  Randog
//
//  Created by Jess Le on 2/11/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dogImage: UIImageView!
    @IBOutlet weak var dogPickerView: UIPickerView!

    var breeds: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        dogPickerView.delegate = self
        dogPickerView.dataSource = self

        DogAPI.requestBreedsList { (breeds, error) in
            self.handleBreedsResponse(breeds: breeds, error: error)
        }
    }
    
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.dogImage.image = image
        }
    }
    
    func handleRandomImageResponse(dogImageData: DogImage?, error: Error?) {
        guard let imageURL = URL(string: dogImageData?.message ?? "") else {
            return
        }
        DogAPI.requestImageFile(url: imageURL) { (image, error) in
            self.handleImageFileResponse(image: image, error: error)
        }
    }
    
    func handleBreedsResponse(breeds: [String], error: Error?) {
        self.breeds = breeds
        DispatchQueue.main.async {
            self.dogPickerView.reloadAllComponents()
        }
    }
}
    
extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DogAPI.requestRandomImage(breed: breeds[row]) { (dogImageData, error) in
            self.handleRandomImageResponse(dogImageData: dogImageData, error: error)
        }
    }
    
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    
}
