//
//  Movie.swift
//  Movie Browser
//
//  Created by Ken Nyame on 7/18/21.
//

import Foundation

struct Movie: Codable {
    let title: String
    let overview: String
    let posterPath: String?
}
