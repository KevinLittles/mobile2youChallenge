//
//  ViewCodeConfiguration.swift
//  mobile2youChallenge
//
//  Created by Kevin Ribeiro on 22/08/21.
//

import Foundation

protocol ViewCodeConfiguration {
    func buildHierarchy()
    func setupAutoLayout()
    func confirugateViews()
}

extension ViewCodeConfiguration {
    
    func configurateView() {}
    
    func apllyViewCode() {
        buildHierarchy()
        setupAutoLayout()
        confirugateViews()
    }
}

//ServiceClient.getMovieDetails(id: 18)
//    .observe(on: MainScheduler.instance)
//    .subscribe { movieDetails in
//        print(movieDetails)
//    } onError: { error in
//        switch error {
//        case ServiceError.conflict:
//            print("Conflict error")
//        case ServiceError.forbidden:
//            print("Forbidden error")
//        case ServiceError.notFound:
//            print("Not found error")
//        default:
//            print("Unknown error:", error)
//
//        }
//    }
//    .disposed(by: disposeBag)
