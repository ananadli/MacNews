//
//  MNMacNewsAPI.swift
//  MacNews
//
//  Created by Anan Suliman on 03/05/2021.
//

import Foundation
import Combine

//This Agent is a promise-based HTTP client. It fulfills and configures requests by passing a single URLRequest object to it. - Automatically transforms JSON data into a Codable value and returns an AnyPublisher instance -
struct Agent {

    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    

    func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

// API End-Point implementation
enum MNMacNewsAPI {
    static let agent = Agent()
    static let base = URL(string: "https://public-macnews-sample.s3-eu-west-1.amazonaws.com")!

    //Get All articals at once
    static func getAllArticles() -> AnyPublisher<MNArticleResponse, Error> {

        var request = URLRequest(url: base.appendingPathComponent("/articles.json"))
        request.cachePolicy = .reloadRevalidatingCacheData

      
        return agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    // Get the content for a particular artical (**Mind The Cash Policy**)
    static func getArticleContent(article : MNArticleModel) -> AnyPublisher<MNArticleContentModelResponse, Error> {

        var request = URLRequest(url: base.appendingPathComponent(article.idPath))
        request.cachePolicy = .reloadRevalidatingCacheData // This cash policy is also utilized for offline reading and bookmarking articles.

        return agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    
}
