//
//  MemeMeCollectionViewController.swift
//  MemeMe
//
//  Created by Jess Le on 1/18/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import UIKit

class MemeMeCollectionViewController: UICollectionViewController {

    private let space:CGFloat = 12.0
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 12, left: 12, bottom: 8, right: 8)

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    private let reuseIdentifier = "MemeMeCollectionViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(MemeMeCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        let paddingSpace = 12 * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: widthPerItem, height: widthPerItem)

        self.collectionView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }

    @objc func generateMemeMe() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let memeMeViewController = storyboard.instantiateViewController(withIdentifier: "MemeMeViewController") as! MemeMeViewController
        self.navigationController?.pushViewController(memeMeViewController, animated: true)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = memes.count
        return count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let meme = memes[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeMeCollectionViewCell
        cell.memeImage.image = meme.memedImage

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = MemeMeDetailsViewController()
        viewController.memeImageView.image = memes[indexPath.row].memedImage
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MemeMeCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}
