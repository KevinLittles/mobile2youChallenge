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
