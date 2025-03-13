//
//  SearchBar.swift
//  FlickrSearchApp
//
//  Created by Maheshbabu Somineni on 3/13/25.
//
import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        TextField("Search images...", text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
    }
}
