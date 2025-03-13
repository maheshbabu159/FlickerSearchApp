//
//  FlickrPhoto.swift
//  FlickrSearchApp
//
//  Created by Maheshbabu Somineni on 3/13/25.
//
import Foundation

struct FlickrResponse: Codable {
    let items: [FlickrItem]
}

struct FlickrItem: Codable {
    let title: String
    let media: [String: String]
    let author: String
    let published: String
    let description: String
}

struct FlickrPhoto: Identifiable {
    let id = UUID()
    let title: String
    let imageUrl: String
    let author: String
    let publishedDate: String
    let description: String
    
    init(item: FlickrItem) {
        self.title = item.title
        self.imageUrl = item.media["m"] ?? ""
        self.author = item.author
        self.publishedDate = item.published
        self.description = item.description
    }
}
