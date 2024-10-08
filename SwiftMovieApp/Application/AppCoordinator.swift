//
//  AppCoordinator.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/27.
//

import Foundation
import Networking

class AppCoordinator {
    private let apiService = DefaultAPIService.shared
    private let fanClubPeopleStorage: FanClubPeopleStorage = DefaultFanClubPeopleStorage()
    
    func makeMoviesHomeView() -> MoviesHomeView {
        let movieRepository = DefaultMoviesHomeRepository(apiService: apiService)
        let peopleRepository = DefaultPeopleRepository(apiService: apiService)
        let coordinator: MoviesHomeCoordinator = .init(
            repository: movieRepository,
            peopleRepository: peopleRepository,
            fanClubPeopleStorage: fanClubPeopleStorage
        )
        let viewModel: MoviesHomeViewModel = .init(repository: movieRepository)
        return .init(coordinator: coordinator, viewModel: viewModel)
    }
    
    func makeFanClubView() -> FanClubView {
        let movieRepository = DefaultMoviesHomeRepository(apiService: apiService)
        let peopleRepository = DefaultPeopleRepository(apiService: apiService)
        let fanClubRepository = DefaultFanClubRepository(apiService: apiService)
        let coordinator: FanClubCoordinator = .init(
            moviesRepository: movieRepository,
            fanClubRepository: fanClubRepository,
            peopleRepository: peopleRepository,
            fanClubPeopleStorage: fanClubPeopleStorage
        )
        let viewModel: FanClubViewModel = .init(repository: DefaultFanClubRepository(apiService: apiService), storage: fanClubPeopleStorage)
        return .init(coordinator: coordinator, viewModel: viewModel)
    }
    
    func createStorageTables() {
        fanClubPeopleStorage.createTable()
    }
}
