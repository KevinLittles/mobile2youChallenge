//
//  MoviesListViewModel.swift
//  mobile2youChallenge
//
//  Created by Kevin Ribeiro on 22/08/21.
//

import Foundation
import RxSwift

protocol MoviesListViewModelDelegate {
    func didChangeIsMovieLiked()
}

struct MoviesListViewModel {
    
    let movieIdInDisplay: Int = 18 //movie chosed
    var isMovieLiked: Bool = false
    var delegate: MoviesListViewModelDelegate?
   
    func getPrincipalMovie() -> Observable<MovieDetails> {
        return ServiceClient.getMovieDetails(id: movieIdInDisplay)
    }
    
    func getSimilarMovies() -> Observable<SimilarMovies> {
        return ServiceClient.getSimilarMovies(id: movieIdInDisplay)
    }
    
    func getImageByPath(path: String) -> UIImage {
        if let url = URL(string: "https://image.tmdb.org/t/p/original" + path) {
        
            do {
                let imageData: Data = try Data(contentsOf: url)
                return UIImage(data: imageData as Data) ?? UIImage(systemName: "film")!
            } catch {
                print(error)
            }
        }
        
        return UIImage(systemName: "film")!
    }
    
    mutating func changeIsMovieLiked() {
        isMovieLiked = !isMovieLiked
        delegate?.didChangeIsMovieLiked()
    }
}

