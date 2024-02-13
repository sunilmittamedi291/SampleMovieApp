//
//  MovieViewModelTests.swift
//  MoviesSampleAppTests
//
//  Created by Sunil Kumar on 12/02/24.
//

import XCTest
import Combine
@testable import MoviesSampleApp

final class MovieViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    private var networkingMock: MovieMockService!
    private var viewModel: MoviesViewModel!
    
    override func setUpWithError() throws {
        
        networkingMock = MovieMockService()
        viewModel = MoviesViewModel(userService: networkingMock)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        networkingMock = nil
        viewModel = nil
    }
    
    
    func testGetMovies() {
        // Arrange
        let movieService = MovieMockService()
        
        let expectation = XCTestExpectation(description: "Movies fetched successfully")
        
        var receivedMovies: [Movie]?
        var receivedError: Error?
        
        // Act
        movieService.getMovies()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    receivedError = error
                    expectation.fulfill()
                }
            }, receiveValue: { movies in
                receivedMovies = movies
            })
            .store(in: &cancellables)
        
        // Wait for the expectation to be fulfilled or timeout after 5 seconds
        wait(for: [expectation], timeout: 5.0)
        
        // Assert
        XCTAssertNotNil(receivedMovies, "Movies should not be nil")
        XCTAssertNil(receivedError, "Error should be nil")
        XCTAssertEqual(receivedMovies?.count, 66, "Expected 66 movie to be fetched")
        XCTAssertEqual(receivedMovies?.first?.title, "The Treasure of the Sierra Madre", "Unexpected movie title")
        XCTAssertEqual(receivedMovies?.first?.imdbId, "tt0040897", "The imdbid should be tt0040897")
    }
    
    // Ensure that main thread is used for publishing values
    func testGetMoviesPublishesOnMainThread() {
        let movieService = MovieMockService()
        
        
        let expectation = XCTestExpectation(description: "Movies fetched on main thread")
        
        // Subscribe to the publisher and check if it's on the main thread
        movieService.getMovies()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { _ in
                XCTAssertTrue(Thread.isMainThread, "Publishing not happening on the main thread")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
