//
//  SimilarMovies.swift
//  mobile2youChallenge
//
//  Created by Kevin Ribeiro on 22/08/21.
//

import Foundation

// MARK: - SimilarMovies
struct SimilarMovies: Codable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview, releaseDate: String
    let posterPath: String?
    let popularity: Double
    let title: String
    let video: Bool
    let voteAverage, voteCount: Double 

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case popularity, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
