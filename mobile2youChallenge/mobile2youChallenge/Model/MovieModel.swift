//
//  MovieModel.swift
//  mobile2youChallenge
//
//  Created by Kevin Ribeiro on 22/08/21.
//

import Foundation

// MARK: - Model
struct MovieModel {
    let id: Int
    let backdropPath: String?
    let title: String
    let voteCount: Int
    let popularity: Double
    
    let genresNames: String
    let releaseDate: String
}
