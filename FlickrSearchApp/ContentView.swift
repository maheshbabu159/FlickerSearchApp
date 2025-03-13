//
//  ContentView.swift
//  FlickrSearchApp
//
//  Created by Maheshbabu Somineni on 3/13/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FlickrViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $viewModel.searchQuery)
                    .accessibilityLabel("Search images")
                    .accessibilityHint("Enter keywords to search Flickr images")
                
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                        .accessibilityLabel("Loading images")
                }
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                        ForEach(viewModel.photos, id: \..id) { photo in
                            NavigationLink(destination: DetailView(photo: photo)) {
                                AsyncImage(url: URL(string: photo.imageUrl)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                        .accessibilityLabel("Loading image thumbnail")
                                }
                                .frame(width: 100, height: 100)
                                .cornerRadius(8)
                                .accessibilityLabel(photo.title)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Flickr Search")
            .accessibilityAddTraits(.isHeader)
        }
    }
}

#Preview {
    ContentView()
}
