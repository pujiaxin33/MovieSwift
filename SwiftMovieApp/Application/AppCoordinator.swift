//
//  AppCoordinator.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/27.
//

import Foundation
import Networking

class AppCoordinator {
    private let apiClient = DefaultAPIClient.shared
    private let moviesRepository: MoviesRepository
    private let peopleRepository: PeopleRepository
    private let fanClubRepository: FanClubRepository
    private let fanClubPeopleStorage: FanClubPeopleStorage = DefaultFanClubPeopleStorage()
    private let seenMoviesStorage: SeenMoviesStorage = DefaultSeenMoviesStorage()
    private let wishMoviesStorage: WishMoviesStorage = DefaultWishMoviesStorage()
    private let uiModuleCoordinator: UIModuleCoordinator
    
    init() {
        self.moviesRepository = DefaultMoviesRepository(apiClient: apiClient)
        self.peopleRepository = DefaultPeopleRepository(apiClient: apiClient)
        self.fanClubRepository = DefaultFanClubRepository(apiClient: apiClient)
        self.uiModuleCoordinator = .init(
            repository: moviesRepository,
            peopleRepository: peopleRepository,
            fanClubPeopleStorage: fanClubPeopleStorage,
            seenMoviesStorage: seenMoviesStorage,
            wishMoviesStorage: wishMoviesStorage
        )
    }
    
    func makeMoviesHomeView() -> MoviesHomeView {
        let viewModel: MoviesHomeViewModel = .init(repository: moviesRepository)
        return .init(coordinator: uiModuleCoordinator, viewModel: viewModel)
    }
    
    func makeFanClubView() -> FanClubView {
        let useCase = DefaultFanClubUseCase(repository: fanClubRepository, storage: fanClubPeopleStorage)
        let viewModel: FanClubViewModel = .init(useCase: useCase)
        return .init(coordinator: uiModuleCoordinator, viewModel: viewModel)
    }
    
    func makeDiscoverView() -> DiscoverView {
        let viewMoel = DiscoverViewModel(repository: moviesRepository)
        return DiscoverView(coordinator: uiModuleCoordinator, viewModel: viewMoel)
    }
    
    func makeMyListView() -> MyListView {
        let useCase = DefaultMyListUseCase(seenMoviesStorage: seenMoviesStorage, wishMoviesStorage: wishMoviesStorage)
        let viewMoel = MyListViewModel(useCase: useCase)
        return MyListView(coordinator: uiModuleCoordinator, viewModel: viewMoel)
    }
    
    func createStorageTables() {
        fanClubPeopleStorage.createTable()
        seenMoviesStorage.createTable()
        wishMoviesStorage.createTable()
    }
}
