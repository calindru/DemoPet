//
//  APIService.swift
//  DemoPet
//
//  Created by Calin Drule on 11.02.2024.
//

import Foundation
import RxSwift

protocol APIServiceProtocol {
    func fetch<T: Decodable>(request: URLRequest) -> Observable<T>
    func fetch<T: Decodable, U: Encodable>(request: URLRequest, body: U) -> Observable<T>
}

extension TokenData {
    var authorization: String {
        token_type + " "  + access_token
    }
}

class APIService: APIServiceProtocol {
    private var session: URLSession = URLSession.shared
    private var token: TokenData?
    private let disposeBag = DisposeBag()
    
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
        var request = request
        
        if let token = token {
            authorized(request: &request, token: token)
        }
        
        return Observable.create { observer in
            let task = self.session.dataTask(with: request) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401 {
                    // Handle token refresh or authentication failure
                    _ = self.authenticate().flatMap { newToken -> Observable<T> in
                        // Update request with new token
                        var newRequest = request
                        self.authorized(request: &newRequest, token: newToken)
                        
                        // Retry the request with the new token
                        return self.session.rx.request(newRequest)
                    }.subscribe(observer)
                } else if let error = error {
                    observer.onError(error)
                } else if let data = data, let decoded = try? JSONDecoder().decode(T.self, from: data) {
                    observer.onNext(decoded)
                    observer.onCompleted()
                } else {
                    observer.onError(RxError.unknown)
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func authenticate() -> Observable<TokenData> {
        let tokenBody = TokenBody(client_id: APIConstants.apiKey, client_secret: APIConstants.apiSecret)
        return fetch(request: .build(for: .getToken, method: .post), body: tokenBody)
    }
        
    private func authorized(request: inout URLRequest, token: TokenData) {
        request.setValue(token.authorization, forHTTPHeaderField: "Authorization")
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
