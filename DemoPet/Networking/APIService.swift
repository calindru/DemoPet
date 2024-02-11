//
//  APIService.swift
//  DemoPet
//
//  Created by Calin Drule on 11.02.2024.
//

import Foundation
import OAuthRxSwift
import OAuthSwift
import RxSwift

protocol APIServiceProtocol {
    func fetch<T: Decodable>(request: URLRequest) -> Observable<T>
    func fetch<T: Decodable, U: Encodable>(request: URLRequest, body: U) -> Observable<T>
}

class APIService: APIServiceProtocol {
    private var session: URLSession = URLSession.shared
    
    func fetch<T: Decodable, U: Encodable>(request: URLRequest, body: U) -> Observable<T> {
        var request = request
        
        do {
            request.httpBody = try URLQueryEncoder().encode(body)
        } catch {
            return Observable.error(APIError.encodingFailed)
        }
        
        return fetch(request: request)
    }
    
    func fetch<T: Decodable>(request: URLRequest) -> Observable<T> {
        session.rx.request(request)
//        oauthSwift.rx.authorize(withCallbackURL: request.url, scope: "", state: "")
        
//        return Observable.create { observer in
//            self.oauthSwift.getAccessToken { token, error in
//                guard let accessToken = token else {
//                    observer.onError(error ?? NSError(domain: "OAuthError", code: -1, userInfo: nil))
//                    return
//                }
//                
//                var request = URLRequest(url: url)
//                request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//                
//                let task = URLSession.shared.dataTask(with: request) { data, response, error in
//                    if let error = error {
//                        observer.onError(error)
//                    } else if let data = data {
//                        observer.onNext(data)
//                        observer.onCompleted()
//                    } else {
//                        observer.onError(NSError(domain: "DataError", code: -2, userInfo: nil))
//                    }
//                }
//                task.resume()
//            }
//            
//            return Disposables.create()
        
    }
    
    func authenticate() -> Observable<TokenData> {
        let tokenBody = TokenBody(client_id: APIConstants.apiKey, client_secret: APIConstants.apiSecret)
        return fetch(request: .build(for: .getToken, method: .post), body: tokenBody)
    }
}

extension Reactive where Base: URLSession {
    func request<T: Decodable>(_ request: URLRequest) -> Observable<T> {
        Observable.create { observer in
            let task = self.base.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer.onError(error)
                } else if let data = data {
                    do {
                        let object = try JSONDecoder().decode(T.self, from: data)
                        observer.onNext(object)
                        observer.onCompleted()
                    }
                    catch {
                        observer.onError(error)
                    }
                } else {
                    observer.onError(APIError.noDataReceived)
                }
            }
            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

extension URLRequest {
    static func build(for endpoint: APIEndpoint, method: HTTPMethod = .get) -> URLRequest {
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = method.rawValue
        
        return request
    }
}
