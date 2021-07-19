//
//  ViewController.swift
//  Movie Browser
//
//  Created by Ken Nyame on 7/18/21.
//

import UIKit

final class MoviesViewController: UIViewController {

    private let viewModel: MovieViewModel = MovieViewModel()
    lazy var movieView = MovieView()

    override func loadView() {
        view = movieView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieView.tableView.dataSource = self
        movieView.tableView.delegate = self
        movieView.searchBar.delegate = self
    }
    
    private func searchMovie(query: String) {
        showSpinner()
        viewModel.fetchMovies(query: query) {[unowned self] movies in
            DispatchQueue.main.async {
                self.hideSpinner()
                self.update()
            }
        }
    }
    
    private func update() {
        movieView.tableView.reloadData()
    }
    
    private func showSpinner() {
        movieView.activityIndicatorView.startAnimating()
    }
    
    private func hideSpinner() {
        self.movieView.activityIndicatorView.stopAnimating()
    }
}

extension MoviesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text, !query.replacingOccurrences(of: " ", with: "").isEmpty {
            searchMovie(query: query)
        }
        else {
            viewModel.movies.removeAll()
            self.update()
        }
        searchBar.resignFirstResponder()
    }
}

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let movieCell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell {
            movieCell.posterImageView.image = nil

            let movie = viewModel.movies[indexPath.row]
            movieCell.movie = movie
            return movieCell
        }
        return UITableViewCell()
    }
}

extension MoviesViewController: UITableViewDelegate {
}


