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
//    private let apiService = MockAPIService(result: .failure(MockAPIService.MockError.test))
    private let fanClubPeopleStorage: FanClubPeopleStorage = DefaultFanClubPeopleStorage()
    private let seenMoviesStorage: SeenMoviesStorage = DefaultSeenMoviesStorage()
    private let wishMoviesStorage: WishMoviesStorage = DefaultWishMoviesStorage()
    
    func makeMoviesHomeView() -> MoviesHomeView {
        let movieRepository = DefaultMoviesHomeRepository(apiService: apiService)
        let peopleRepository = DefaultPeopleRepository(apiService: apiService)
        let coordinator: MoviesHomeCoordinator = .init(
            repository: movieRepository,
            peopleRepository: peopleRepository,
            fanClubPeopleStorage: fanClubPeopleStorage,
            seenMoviesStorage: seenMoviesStorage,
            wishMoviesStorage: wishMoviesStorage
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
            fanClubPeopleStorage: fanClubPeopleStorage,
            seenMoviesStorage: seenMoviesStorage,
            wishMoviesStorage: wishMoviesStorage
        )
        let useCase = DefaultFanClubUseCase(repository: fanClubRepository, storage: fanClubPeopleStorage)
        let viewModel: FanClubViewModel = .init(useCase: useCase)
        return .init(coordinator: coordinator, viewModel: viewModel)
    }
    
    func makeDiscoverView() -> DiscoverView {
        let movieRepository = DefaultMoviesHomeRepository(apiService: apiService)
        let peopleRepository = DefaultPeopleRepository(apiService: apiService)
        let viewMoel = DiscoverViewModel(repository: movieRepository)
        let coordinator: DiscoverCoordinator = .init(
            repository: movieRepository,
            peopleRepository: peopleRepository,
            fanClubPeopleStorage: fanClubPeopleStorage,
            seenMoviesStorage: seenMoviesStorage,
            wishMoviesStorage: wishMoviesStorage
        )
        return DiscoverView(coordinator: coordinator, viewModel: viewMoel)
    }
    
    func makeMyListView() -> MyListView {
        let movieRepository = DefaultMoviesHomeRepository(apiService: apiService)
        let peopleRepository = DefaultPeopleRepository(apiService: apiService)
        let viewMoel = MyListViewModel(useCase: DefaultMyListUseCase(seenMoviesStorage: seenMoviesStorage, wishMoviesStorage: wishMoviesStorage))
        let coordinator: MyListCoordinator = .init(
            repository: movieRepository,
            peopleRepository: peopleRepository,
            fanClubPeopleStorage: fanClubPeopleStorage,
            seenMoviesStorage: seenMoviesStorage,
            wishMoviesStorage: wishMoviesStorage
        )
        return MyListView(coordinator: coordinator, viewModel: viewMoel)
    }
    
    func createStorageTables() {
        fanClubPeopleStorage.createTable()
        seenMoviesStorage.createTable()
        wishMoviesStorage.createTable()
    }
}
