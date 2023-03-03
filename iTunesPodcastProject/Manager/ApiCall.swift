//
//  ApiCall.swift
//  iTunesPodcastProject
//
//  Created by Guy Adler on 27/02/2023.
//

import Foundation

enum ApiError {
    case badUrl(String)
    case FailedToGetData(String)
}

class ApiCaller {
    
    static let shared = ApiCaller()
    
}
