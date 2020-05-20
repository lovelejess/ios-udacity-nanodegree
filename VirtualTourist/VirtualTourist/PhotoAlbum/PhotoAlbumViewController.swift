//
//  PhotoAlbumViewController.swift
//  VirtualTourist
//
//  Created by Jess Le on 5/2/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import UIKit

class PhotoAlbumViewController: UICollectionViewController {

    public var viewModel: PhotoAlbumViewModel?
    private let space:CGFloat = 12.0
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 12, left: 12, bottom: 8, right: 8)

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: Cells.photoCollectionViewCell.rawValue)

        let paddingSpace = 12 * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: widthPerItem, height: widthPerItem)
    }

   
}

// MARK: UICollectionViewDataSource
extension PhotoAlbumViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.photoCollectionViewCell.rawValue, for: indexPath) as! PhotoCollectionViewCell
        return cell
        
    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let viewController = MemeMeDetailsViewController()
//        viewController.memeImageView.image = memes[indexPath.row].memedImage
//        navigationController?.pushViewController(viewController, animated: true)
//    }
}

extension PhotoAlbumViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}


enum Cells: String {
    case photoCollectionViewCell

}
