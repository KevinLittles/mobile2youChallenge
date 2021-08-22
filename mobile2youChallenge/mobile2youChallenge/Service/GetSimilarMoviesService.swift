//
//  File.swift
//  mobile2youChallenge
//
//  Created by Kevin Ribeiro on 22/08/21.
//

import Foundation
import Alamofire
import RxSwift

struct GetSimilarMoviesServiceInfo: ServiceInfo {
    static var baseURL = "https://api.themoviedb.org"
    static var key = "483af41ca0f764080dd86c3a2794c9f6"
    static var path = ["/3/movie/","/similar"]
}

extension ServiceClient {
    static func getSimilarMovies(id: Int) -> Observable<SimilarMovies> {
        return request(GetSimilarMoviesServiceRouter.getSimilarMovies(id: id))
    }
}

enum GetSimilarMoviesServiceRouter: ServiceRouter, URLRequestConvertible {

    case getSimilarMovies(id: Int)
    
    func asURLRequest() throws -> URLRequest {
        let url = try GetSimilarMoviesServiceInfo.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue(ServiceConstants.ContentType.json.rawValue, forHTTPHeaderField: ServiceConstants.HttpHeaderField.acceptType.rawValue)
        urlRequest.setValue(ServiceConstants.ContentType.json.rawValue, forHTTPHeaderField: ServiceConstants.HttpHeaderField.contentType.rawValue)
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    

    internal var method: HTTPMethod {
        switch self {
        case .getSimilarMovies:
            return .get
        }
    }
    
    internal var path: String {
        switch self {
        case .getSimilarMovies(let id):
            return GetSimilarMoviesServiceInfo.path[0] + String(id) + GetSimilarMoviesServiceInfo.path[1]
        }
    }
    
    internal var parameters: Parameters? {
        switch self {
        case .getSimilarMovies:
            //A dictionary of the key (From the constants file) and its value is returned
            return ["api_key" : GetSimilarMoviesServiceInfo.key]
        }
    }
}
