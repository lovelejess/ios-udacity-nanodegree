//
//  PhotoAlbumViewController.swift
//  VirtualTourist
//
//  Created by Jess Le on 5/2/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import UIKit
import Combine


class PhotoAlbumViewController: UIViewController, UICollectionViewDelegate {

    typealias DataSource = UICollectionViewDiffableDataSource<Section, Photo>
    private var subscribers = Set<AnyCancellable>()

    var dataSource: DataSource! = nil
    var collectionView: UICollectionView! = nil
    public var viewModel: PhotoAlbumViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
        viewModel.getPhotos()

        viewModel.$photos.receive(on: DispatchQueue.main)
            .sink(receiveValue: { photos in
                print("Response: \(photos)")
                self.updatePhotos(photos: photos)
                })
            .store(in: &subscribers)
    }
}

// MARK: Configuration
extension PhotoAlbumViewController {
    func configureCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: Cells.photoCollectionViewCell.rawValue)
        self.collectionView = collectionView
    }

    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, photo: Photo) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Cells.photoCollectionViewCell.rawValue,
                for: indexPath) as? PhotoCollectionViewCell else { fatalError("Could not create PhotoCollectionViewCell") }
            cell.configure(photo: self.viewModel.photos[indexPath.row])
            return cell
        }

        setUpInitialData()
    }
    
    private func setUpInitialData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Photo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.photos)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, Photo> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Photo>()
        snapshot.appendSections([Section.main])
        func addItems(_ photo: Photo) {
            snapshot.appendItems([photo])
        }
        return snapshot
    }

    func updatePhotos(photos: [Photo]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Photo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(photos)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

}

enum Cells: String {
    case photoCollectionViewCell
}

enum Section {
  case main
}
