//
//  DetailView.swift
//  FlickrSearchApp
//
//  Created by Maheshbabu Somineni on 3/13/25.
//
import SwiftUI

struct DetailView: View {
    let photo: FlickrPhoto
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: photo.imageUrl)) { phase in
                if let image = phase.image {
                    image.resizable()
                } else if phase.error != nil {
                    Color.red // Placeholder for failed image load
                } else {
                    ProgressView()
                        .accessibilityLabel("Loading full image")

                }
            }
            .frame(width: 100, height: 100)
            .cornerRadius(8)
            
            Text(photo.title)
                .font(.headline)
                .padding()
                .accessibilityLabel("Title: \(photo.title)")
            
            Text(photo.author)
                .font(.subheadline)
                .accessibilityLabel("Author: \(photo.author)")
            
            Text(photo.publishedDate)
                .font(.caption)
                .foregroundColor(.gray)
                .accessibilityLabel("Published on: \(photo.publishedDate)")
        }
        .padding()
    }
}
