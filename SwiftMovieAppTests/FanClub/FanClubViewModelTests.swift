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
    var mockUseCase: MockFanClubUseCase!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockUseCase = MockFanClubUseCase()
        viewModel = FanClubViewModel(useCase: mockUseCase)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockUseCase = nil
        cancellables = nil
        try super.tearDownWithError()
    }

    func testWhenLoadDataIsCalledThenPeopleAreFetched() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch popular persons")
        let mockPeople = [samplePeople]
        mockUseCase.mockResult = .success(PaginatedResponse(page: 1, total_results: 1, total_pages: 1, results: mockPeople))

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

    func testWhenLoadDataIsCalledThenLoadingStateIsHandled() {
        // Given
        let expectation = XCTestExpectation(description: "Handle loading state")
        let mockPeople = [samplePeople]
        mockUseCase.mockResult = .success(PaginatedResponse(page: 1, total_results: 1, total_pages: 1, results: mockPeople))

        // When
        viewModel.loadData()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertFalse(self.viewModel.isLoading)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testWhenLoadDataFailsThenErrorIsHandled() {
        // Given
        let expectation = XCTestExpectation(description: "Handle error")
        mockUseCase.mockResult = .failure(NSError(domain: "TestError", code: 0, userInfo: nil))

        // When
        viewModel.loadData()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNil(self.viewModel.peoples)
            XCTAssertNotNil(self.viewModel.toast)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testWhenLoadDataIsCalledThenCurrentPageIsIncremented() {
        // Given
        let expectation = XCTestExpectation(description: "Increment current page")
        let mockPeople = [samplePeople]
        mockUseCase.mockResult = .success(PaginatedResponse(page: 1, total_results: 1, total_pages: 1, results: mockPeople))

        // When
        viewModel.loadData()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.currentPage, 2)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testWhenLoadDataIsCalledMultipleTimesThenPeopleAreAppended() {
        // Given
        let expectation = XCTestExpectation(description: "Append people on multiple loads")
        let mockPeopleFirstLoad = [samplePeople]
        let mockPeopleSecondLoad = [samplePeople]
        mockUseCase.mockResult = .success(PaginatedResponse(page: 1, total_results: 1, total_pages: 1, results: mockPeopleFirstLoad))

        // First load
        viewModel.loadData()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.peoples?.count, 1)

            // Second load
            self.mockUseCase.mockResult = .success(PaginatedResponse(page: 2, total_results: 1, total_pages: 1, results: mockPeopleSecondLoad))
            self.viewModel.loadData()

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                XCTAssertEqual(self.viewModel.peoples?.count, 2)
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
