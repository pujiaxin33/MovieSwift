//
//  FanClubViewModelTests.swift
//  SwiftMovieAppTests
//
//  Created by Jiaxin Pu on 2024/9/27.
//

import XCTest
@testable import SwiftMovieApp
import Combine

final class FanClubViewModelTests: XCTestCase {

    var viewModel: FanClubViewModel!
    var mockRepository: MockFanClubRepository!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockRepository = MockFanClubRepository()
        viewModel = FanClubViewModel(repository: mockRepository)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockRepository = nil
        cancellables = nil
        try super.tearDownWithError()
    }

    func testLoadData() {
        // Given
        let expectation = XCTestExpectation(description: "Load data")
        let mockPeople = [samplePeople]
        mockRepository.mockResult = .success(PaginatedResponse(page: 1, total_results: 1, total_pages: 1, results: mockPeople))

        // When
        viewModel.loadData()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.peoples?.count, 1)
            XCTAssertEqual(self.viewModel.peoples?.first?.name, "John Doe")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testLoadDataFailure() {
        // Given
        let expectation = XCTestExpectation(description: "Load data failure")
        mockRepository.mockResult = .failure(NSError(domain: "TestError", code: 0, userInfo: nil))

        // When
        viewModel.loadData()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNil(self.viewModel.peoples)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
