//
//  NetworkManager.swift
//  FlickrSearchApp
//
//  Created by Maheshbabu Somineni on 3/13/25.
//
import Foundation

class NetworkManager {
    func fetchPhotos(for query: String, completion: @escaping (Result<[FlickrPhoto], Error>) -> Void) {
        let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(query)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 500, userInfo: nil)))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(FlickrResponse.self, from: data)
                let photos = response.items.map { FlickrPhoto(item: $0) }
                completion(.success(photos))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
