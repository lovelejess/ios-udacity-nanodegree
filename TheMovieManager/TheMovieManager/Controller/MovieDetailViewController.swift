//
//  MovieDetailViewController.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var watchlistBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var favoriteBarButtonItem: UIBarButtonItem!
    
    var movie: Movie!
    
    var isWatchlist: Bool {
        return MovieModel.watchlist.contains(movie)
    }
    
    var isFavorite: Bool {
        return MovieModel.favorites.contains(movie)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = movie.title
        imageView?.image = UIImage(named: "PosterPlaceholder")
        TMDBClient.downloadPosterImage(posterPath: movie.posterPath ?? "", completion: handleDownloadedImageResponse(data:error:))
        toggleBarButton(watchlistBarButtonItem, enabled: isWatchlist)
        toggleBarButton(favoriteBarButtonItem, enabled: isFavorite)
        
    }
    
    @IBAction func watchlistButtonTapped(_ sender: UIBarButtonItem) {
        TMDBClient.markWatchlist(movieId: movie.id, watchlist: !isWatchlist, completion: handleWatchlistResponse(isSuccessful:error:))
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIBarButtonItem) {
        TMDBClient.markFavorite(movieId: movie.id, favorite: !isFavorite, completion: handleFavoriteResponse(isSuccessful:error:))
    }
    
    func toggleBarButton(_ button: UIBarButtonItem, enabled: Bool) {
        if enabled {
            button.tintColor = UIColor.primaryDark
        } else {
            button.tintColor = UIColor.gray
        }
    }

    func handleDownloadedImageResponse(data: Data?, error: Error?) {
        if let data = data {
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.imageView.image = image
            }
        } else {
            print("error: \(error?.localizedDescription)")
        }
        
        
    }
        
    func handleWatchlistResponse(isSuccessful: Bool, error: Error?) {
        if isSuccessful {
            if isWatchlist {
                print("before delete: \(MovieModel.watchlist.count)")
                MovieModel.watchlist = MovieModel.watchlist.filter() {$0 != movie}
                print("after delete: \(MovieModel.watchlist.count)")
            } else {
                MovieModel.watchlist.append(movie)
            }
            toggleBarButton(watchlistBarButtonItem, enabled: isWatchlist)
        }
        
    }
    
    func handleFavoriteResponse(isSuccessful: Bool, error: Error?) {
        if isSuccessful {
            if isFavorite {
                print("before delete: \(MovieModel.favorites.count)")
                MovieModel.favorites = MovieModel.favorites.filter() {$0 != movie}
                print("after delete: \(MovieModel.favorites.count)")
            } else {
                MovieModel.favorites.append(movie)
            }
            toggleBarButton(favoriteBarButtonItem, enabled: isFavorite)
        }
        
    }
    
}
