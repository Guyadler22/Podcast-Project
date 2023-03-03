//
//  podcast.swift
//  iTunesPodcastProject
//
//  Created by Guy Adler on 27/02/2023.
//

import Foundation

struct Podcast:Codable {
    
    let resultCount: Int64
    
    var results:[PodcastResult]
}

struct PodcastResult:Codable {
        
    let artistName: String
    let trackName:String
    let artworkUrl100:String
    let releaseDate:String
        
}
