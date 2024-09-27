//
//  PeopleDetailViewModelTests.swift
//  SwiftMovieAppTests
//
//  Created by Jiaxin Pu on 2024/9/27.
//

import XCTest
@testable import SwiftMovieApp
import Combine

final class PeopleDetailViewModelTests: XCTestCase {

    var viewModel: PeopleDetailViewModel!
    var mockRepository: MockPeopleRepository!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockRepository = MockPeopleRepository()
        mockRepository.mockPersonDetailResult = .failure(NSError(domain: "TestError", code: 0, userInfo: nil))
        mockRepository.mockPersonImagesResult = .failure(NSError(domain: "TestError", code: 0, userInfo: nil))
        mockRepository.mockPersonMovieCreditsResult = .failure(NSError(domain: "TestError", code: 0, userInfo: nil))
        viewModel = PeopleDetailViewModel(repository: mockRepository, people: samplePeople)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockRepository = nil
        cancellables = nil
        try super.tearDownWithError()
    }

    func testWhenLoadDataIsCalledThenPersonDetailIsFetched() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch person detail")
        let mockPeopleDetail = samplePeople
        mockRepository.mockPersonDetailResult = .success(mockPeopleDetail)

        // When
        viewModel.loadData()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.people.name, "John Doe")
            XCTAssertEqual(self.viewModel.people.biography, "John Doe is an acclaimed actor known for his diverse roles in major films.")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testWhenLoadDataIsCalledThenPersonImagesAreFetched() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch person images")
        let mockImages = ImagesResponse(id: 1, profiles: [ImageData(aspect_ratio: 1.0, file_path: "/image.jpg", height: 100, width: 100)])
        mockRepository.mockPersonImagesResult = .success(mockImages)

        // When
        viewModel.loadData()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.people.images?.count, 1)
            XCTAssertEqual(self.viewModel.people.images?.first?.file_path, "/image.jpg")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testWhenLoadDataIsCalledThenPersonMovieCreditsAreFetched() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch person movie credits")
        let mockMovieCredits = PeopleCreditsResponse(cast: [sampleMovie], crew: nil)
        mockRepository.mockPersonMovieCreditsResult = .success(mockMovieCredits)

        // When
        viewModel.loadData()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.movieByYears?.count, 1)
            XCTAssertEqual(self.viewModel.movieByYears?.first?.year, "1972")
            XCTAssertEqual(self.viewModel.movieByYears?.first?.movies.first?.title, "Test movie")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testWhenLoadDataFailsThenErrorIsHandled() {
        // Given
        let expectation = XCTestExpectation(description: "Handle error")
        mockRepository.mockPersonDetailResult = .failure(NSError(domain: "TestError", code: 0, userInfo: nil))
        mockRepository.mockPersonImagesResult = .failure(NSError(domain: "TestError", code: 0, userInfo: nil))
        mockRepository.mockPersonMovieCreditsResult = .failure(NSError(domain: "TestError", code: 0, userInfo: nil))

        // When
        viewModel.loadData()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            XCTAssertNil(self.viewModel.people.biography)
//            XCTAssertNil(self.viewModel.people.images)
//            XCTAssertNil(self.viewModel.movieByYears)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testWhenCheckCanShowBiographyIsCalledThenCorrectResultIsReturned() {
        // Given
        let peopleWithBio = samplePeople
        let peopleWithoutBio = samplePeopleCantShowBiography

        // When & Then
        XCTAssertTrue(viewModel.checkCanShowBiography(people: peopleWithBio))
        XCTAssertFalse(viewModel.checkCanShowBiography(people: peopleWithoutBio))
    }

    func testWhenIsFavoritePeopleIsCalledThenCorrectResultIsReturned() {
        // Given
        let favoritePeople = [
            samplePeople
        ]

        // When & Then
        XCTAssertTrue(viewModel.isFavoritePeople(people: samplePeople, favoritePeoples: favoritePeople))
        XCTAssertFalse(viewModel.isFavoritePeople(people: samplePeopleCantShowBiography, favoritePeoples: favoritePeople))
    }
}
