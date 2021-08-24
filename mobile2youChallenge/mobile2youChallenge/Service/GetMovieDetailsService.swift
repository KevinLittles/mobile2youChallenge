//
//  File.swift
//  mobile2youChallenge
//
//  Created by Kevin Ribeiro on 22/08/21.
//

import Foundation
import Alamofire
import RxSwift

struct GetMovieDetailsServiceInfo: ServiceInfo {
    static var baseURL = "https://api.themoviedb.org"
    static var key = "483af41ca0f764080dd86c3a2794c9f6"
    static var path = ["/3/movie/"]
}

extension ServiceClient {
    static func getMovieDetails(id: Int) -> Observable<MovieDetails> {
        return request(GetMovieDetailsServiceRouter.getMovieDetails(id: id))
    }
    
}

enum GetMovieDetailsServiceRouter: ServiceRouter, URLRequestConvertible {

    case getMovieDetails(id: Int)
    
    func asURLRequest() throws -> URLRequest {
        let url = try GetMovieDetailsServiceInfo.baseURL.asURL()
        
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
        case .getMovieDetails:
            return .get
        }
    }
    
    internal var path: String {
        switch self {
        case .getMovieDetails(let id):
            return GetMovieDetailsServiceInfo.path[0] + String(id)
        }
    }
    
    internal var parameters: Parameters? {
        switch self {
        case .getMovieDetails:

            return ["api_key" : GetMovieDetailsServiceInfo.key]
        }
    }
}
