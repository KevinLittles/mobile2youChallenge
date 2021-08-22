//
//  Service.swift
//  mobile2youChallenge
//
//  Created by Kevin Ribeiro on 22/08/21.
//

import Foundation
import Alamofire
import RxSwift

enum ServiceError: Error {
    case forbidden              //Status code 403
    case notFound               //Status code 404
    case conflict               //Status code 409
    case internalServerError    //Status code 500
}

protocol ServiceInfo {
    static var baseURL: String { get }
    static var key: String { get }
    static var path: [String] { get }
}

protocol ServiceRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

struct ServiceConstants {
    
    //The header fields
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    //The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
    }
}

class ServiceClient {
    
    //MARK: - The request function to get results in an Observable
    static func request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        //Create an RxSwift observable, which will be the one to call the request when subscribed to
        return Observable<T>.create { observer in
            //Trigger the HttpRequest using AlamoFire (AF)
            let request = AF.request(urlConvertible).responseDecodable { (response: AFDataResponse<T>) in
                //Check the result from Alamofire's response and check if it's a success or a failure
                
                switch response.result {
                case .success(let value):
                    //Everything is fine, return the value in onNext
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    //Something went wrong, switch on the status code and return the error
                    switch response.response?.statusCode {
                    case 403:
                        observer.onError(ServiceError.forbidden)
                    case 404:
                        observer.onError(ServiceError.notFound)
                    case 409:
                        observer.onError(ServiceError.conflict)
                    case 500:
                        observer.onError(ServiceError.internalServerError)
                    default:
                        observer.onError(error)
                    }
                }
            }
            
            //Finally, we return a disposable to stop the request
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
