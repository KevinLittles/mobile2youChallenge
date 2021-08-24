//
//  MoviesListViewModel.swift
//  mobile2youChallenge
//
//  Created by Kevin Ribeiro on 22/08/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol MoviesListViewModelDelegate {
    func didChangeIsMovieLiked()
}

class MoviesListViewModel {
    
    let disposeBag = DisposeBag()
    
    var movieId: Int = 18 //movie chosed
    var isMovieLiked: Bool = false
    var delegate: MoviesListViewModelDelegate?
   
    func getSimilarMoviesDetails() -> Observable<[MovieDetails]> {
        let lastMovieId = self.movieId
        
        return getSimilarMovies().flatMap { movies -> Observable<[MovieDetails]> in
            var movieDetailsArray = [Observable<MovieDetails>]()

            for movie in movies.results {
                self.movieId = movie.id
                
                movieDetailsArray.append(self.getPrincipalMovie())
            }
            
            self.movieId = lastMovieId
            
            let combinedArray = Observable.combineLatest(movieDetailsArray)

            return combinedArray
        }

    }
    
    func getPrincipalMovie() -> Observable<MovieDetails> {
        return ServiceClient.getMovieDetails(id: movieId)
    }
    
    func getSimilarMovies() -> Observable<SimilarMovies> {
        
        return ServiceClient.getSimilarMovies(id: movieId)
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
    
    func changeIsMovieLiked() {
        isMovieLiked = !isMovieLiked
        delegate?.didChangeIsMovieLiked()
    }
}

