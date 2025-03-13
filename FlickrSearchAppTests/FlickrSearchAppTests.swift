//
//  FlickrSearchAppTests.swift
//  FlickrSearchAppTests
//
//  Created by Maheshbabu Somineni on 3/13/25.
//

import Testing
import Foundation
import XCTest

@testable import FlickrSearchApp

struct FlickrSearchAppTests {

    @Test func testFlickrPhotoParsing() {
        let json = """
                {
                    "title": "Sample Photo",
                    "media": {"m": "https://example.com/photo.jpg"},
                    "author": "John Doe",
                    "published": "2025-03-13T10:00:00Z",
                    "description": "Sample description"
                }
                """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let flickrItem = try? decoder.decode(FlickrItem.self, from: json)
        XCTAssertNotNil(flickrItem)
        XCTAssertEqual(flickrItem?.title, "Sample Photo")
        XCTAssertEqual(flickrItem?.media["m"], "https://example.com/photo.jpg")
    }
    
    @Test func testSearchQueryUpdatesResults() {
        let viewModel = FlickrViewModel()
        viewModel.searchQuery = "nature"
        XCTAssertFalse(viewModel.photos.isEmpty, "Search results should not be empty after query change")
    }

}
