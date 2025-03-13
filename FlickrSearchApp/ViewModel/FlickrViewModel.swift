//
//  FlickrViewModel.swift
//  FlickrSearchApp
//
//  Created by Maheshbabu Somineni on 3/13/25.
//
import SwiftUI

class FlickrViewModel: ObservableObject {
    @Published var searchQuery: String = "" {
        didSet {
            fetchPhotos()
        }
    }
    @Published var photos: [FlickrPhoto] = []
    @Published var isLoading: Bool = false
    
    func fetchPhotos() {
        guard !searchQuery.isEmpty else {
            photos = []
            return
        }
        
        let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(searchQuery)"
        guard let url = URL(string: urlString) else { return }
        
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let data = data {
                    do {
                        let response = try JSONDecoder().decode(FlickrResponse.self, from: data)
                        self.photos = response.items.map { FlickrPhoto(item: $0) }
                    } catch {
                        print("Failed to decode JSON: \(error)")
                    }
                }
            }
        }.resume()
    }
}
