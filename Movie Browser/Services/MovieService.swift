//
//  MovieService.swift
//  Movie Browser
//
//  Created by Ken Nyame on 7/18/21.
//

import Foundation

enum MovieAPI  {
    static let baseUrl: String = "https://api.themoviedb.org/3"
    static let imageDBBaseUrl: String = "https://image.tmdb.org/t/p/original"
    static let apiKey: String = "2a61185ef6a27f400fd92820ad9e8537"
    enum EndPoints {
        static let searchMovie = "/search/movie"
    }
}

protocol MovieService_Protocol {
    func searchMovie(query: String, completion: @escaping (Result<[Movie], Error>) -> Void)
}

class MovieService: MovieService_Protocol {
    
    private let httpManager: HTTPManager
    private let jsonDecoder: JSONDecoder
    
    init(httpManager: HTTPManager = HTTPManager.shared) {
        self.httpManager = httpManager
        self.jsonDecoder = JSONDecoder()
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    struct MoviesResponseBody: Codable {
            let results: [Movie]
    }
    
    func searchMovie(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let urlEncodedString = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        let urlString = String(
            format: "%@%@?api_key=%@&query=%@",
            MovieAPI.baseUrl,
            MovieAPI.EndPoints.searchMovie,
            MovieAPI.apiKey,
            urlEncodedString
        )

        httpManager.get(urlString: urlString) { result in
                switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                completion(Result(catching: { try self.jsonDecoder.decode(MoviesResponseBody.self, from: data).results }))
            }
        }
    }
}

