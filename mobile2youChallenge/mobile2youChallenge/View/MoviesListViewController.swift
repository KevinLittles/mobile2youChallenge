//
//  MoviesListViewController.swift
//  mobile2youChallenge
//
//  Created by Kevin Ribeiro on 22/08/21.
//

import UIKit
import RxSwift

class MoviesListViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        testingService()
        
    }

    override func loadView() {
        
    }
    
    func testingService() {
        ServiceClient.getMovieDetails(id: 18)
            .observe(on: MainScheduler.instance)
            .subscribe { movieDetails in
                print(movieDetails)
            } onError: { error in
                switch error {
                case ServiceError.conflict:
                    print("Conflict error")
                case ServiceError.forbidden:
                    print("Forbidden error")
                case ServiceError.notFound:
                    print("Not found error")
                default:
                    print("Unknown error:", error)

                }
            }
            .disposed(by: disposeBag)

       print("------------------------------------")
        
        ServiceClient.getSimilarMovies(id: 18)
            .observe(on: MainScheduler.instance)
            .subscribe { similarMovies in
                print(similarMovies)
            } onError: { error in
                switch error {
                case ServiceError.conflict:
                    print("Conflict error")
                case ServiceError.forbidden:
                    print("Forbidden error")
                case ServiceError.notFound:
                    print("Not found error")
                default:
                    print("Unknown error:", error)

                }
            }
            .disposed(by: disposeBag)
    }

}

extension MoviesListViewController: MoviesListViewModelDelegate {
    
}
