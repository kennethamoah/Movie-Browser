//
//  MoviesViewModel.swift
//  Movie Browser
//
//  Created by Ken Nyame on 7/19/21.
//

import Foundation

class MovieViewModel {
    // MARK: - Initialization
    init(model: [Movie]? = nil) {
        if let inputModel = model {
            movies = inputModel
        }
    }
    var movies = [Movie]()
}

extension MovieViewModel {
    func fetchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        MovieService().searchMovie(query: query) {[unowned self] result in
            switch result {
            case .success(let movies):
                self.movies = movies
                print(movies)
                completion(.success(movies))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
