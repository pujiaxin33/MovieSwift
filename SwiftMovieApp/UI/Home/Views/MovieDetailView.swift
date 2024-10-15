//
//  MovieDetail.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import SwiftUI
import Networking

struct MovieDetailView: View {
    @State var viewModel: MovieDetailViewModel
    @State private var isAlertShowing: Bool = false
    @Environment(\.navigation) private var navigation
    
    var body: some View {
        let _ = Self._printChanges()
        List {
            headerSection
            
            bottomSection
        }
        .navigationTitle(viewModel.movie.title)
        .navigationDestination(for: [Review].self, destination: { (reviews) in
            MovieReviewsView(reviews: reviews)
        })
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("", systemImage: "text.badge.plus") {
                    isAlertShowing = true
                }
            }
        }
        .confirmationDialog("alert title", isPresented: $isAlertShowing, actions: {
            Button(role: viewModel.isInWishlist ? .destructive : nil) {
                if viewModel.isInWishlist {
                    viewModel.removeFromWishList()
                } else {
                    viewModel.addToWishList()
                }
            } label: {
                Text(viewModel.isInWishlist ? "Remove from wishlist" : "Add to wishlist")
            }
            
            Button(role: viewModel.isInSeenlist ? .destructive : nil) {
                if viewModel.isInSeenlist {
                    viewModel.removeFromSeenList()
                } else {
                    viewModel.addToSeenList()
                }
            } label: {
                Text(viewModel.isInSeenlist ? "Remove from seenlist" : "Add to seenlist")
            }
            
            Button(role: .cancel) {
            } label: {
                Text("Cancel")
            }
        }, message: {
            Text("Add or remove to list")
        })
//        .sheet(isPresented: $isAlertShowing, content: {
//            Button {
//                viewModel.addToWishList()
//            } label: {
//                Text("Add to wishlist")
//            }
//            
//            Button {
//                viewModel.addToWishList()
//            } label: {
//                Text("Add to seenlist")
//            }
//            
//            Button(role: .cancel) {
//            } label: {
//                Text("Cancel")
//            }
//        })
//        .alert("alert title", isPresented: $isAlertShowing, actions: {
//        }, message: {
//            Text("Add or remove")
//        })
        .onAppear {
            viewModel.loadData()
        }
    }
    
    func addToListView(isInWishlist: Bool, isInSeenlist: Bool) -> some View {
        HStack(alignment: .center, spacing: 8) {
            BorderedButton(text: isInWishlist ? "In wishlist" : "Wishlist",
                           systemImageName: "heart",
                           color: .pink,
                           isOn: isInWishlist,
                           action: {
                if isInWishlist {
                    viewModel.removeFromWishList()
                } else {
                    viewModel.addToWishList()
                }
            })
            
            BorderedButton(text: isInSeenlist ? "Seen" : "Seenlist",
                           systemImageName: "eye",
                           color: .green,
                           isOn: isInSeenlist,
                           action: {
                if isInSeenlist {
                    viewModel.removeFromSeenList()
                } else {
                    viewModel.addToSeenList()
                }
            })
        }
        .padding(.vertical, 8)
    }
    
    var headerSection: some View {
        Section {
            MovieDetailBasicInfoHeaderView(movie: viewModel.movie)
            
            addToListView(isInWishlist: viewModel.isInWishlist, isInSeenlist: viewModel.isInSeenlist)
            
            if let reviews = viewModel.reviews, !reviews.isEmpty {
                MovieDetailReviewsView(reviews: reviews)
            }
            
            MovieDetailOverviewView(movie: viewModel.movie)
        }
    }
    
    var bottomSection: some View {
        Section {
            if let keywords = viewModel.movie.keywords?.keywords, !keywords.isEmpty {
                KeywordsCardView(keywords: keywords)
            }
            
            if let cast = viewModel.cast {
                PeoplesListCardView(title: "Cast", peoples: cast.cast)
                PeoplesListCardView(title: "Crew", peoples: cast.crew)
            }
            
            if let movies = viewModel.similarMovies, !movies.isEmpty {
                MoviesListCardView(title: "Similar Movies", movies: movies)
            }
            
            if let movies = viewModel.recommendedMovies, !movies.isEmpty {
                MoviesListCardView(title: "Recommended Movies", movies: movies)
            }
            
            if let images = viewModel.movie.images?.posters, !images.isEmpty {
                MovieDetailPosterCardView(images: images)
            }
            
            if let images = viewModel.movie.images?.backdrops, !images.isEmpty {
                MovieDetailbackdropCardView(images: images)
            }
            
        }
    }
}

struct RightIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center, spacing: 8) {
            configuration.title
            configuration.icon
        }
    }
}
