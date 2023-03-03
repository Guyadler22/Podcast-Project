//
//  ApiCaller2.swift
//  iTunesPodcastProject
//
//  Created by Guy Adler on 27/02/2023.
//

import Foundation
import Alamofire

enum ApiError:Error {
    case badUrl(String)
    case FailedToGetData(String)
}

typealias ApiCallback = (Result<Podcast, Error>) -> Void

class ApiCaller2 {
    
    static let shared = ApiCaller2()
    
    func requestUrl(model:String) -> String {
        return "https://itunes.apple.com/search?entity=podcast&term=\(model)"
    }
    
    func itunesSearchRequest(_ term:String, completion: @escaping ApiCallback) {
        if let term = term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = requestUrl(model:term) // add the term to the url
            request(urlString: url, completion: completion)
        }
    }
    
    func request(urlString:String, completion: @escaping ApiCallback)  {
        AF.request(urlString,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: nil,
                   interceptor: nil,
                   requestModifier: nil)
            .responseData { (responesData) in
                guard let data = responesData.data else {
                    return
                    
                }
                do {
                    let podcast = try JSONDecoder().decode(Podcast.self, from: data)
                    
                    completion(.success(podcast))
                } catch{
                    completion(.failure(ApiError.FailedToGetData("The data recived is undifined")))
                    return
                }
            }
            .resume()
    }
}
