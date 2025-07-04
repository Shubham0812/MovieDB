//
//  ContentView.swift
//  MovieDB
//
//  Created by Shubham on 29/06/25.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - Variables
    @Environment(\.managedObjectContext) private var managedObjectContext
    @EnvironmentObject var mainViewModel: MainViewModel
    
    
    // MARK: - Views
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                let width: CGFloat = proxy.size.width
                let height: CGFloat = proxy.size.height
                
                ZStack(alignment: .topLeading) {
                    Color(UIColor.systemBackground)
                        .ignoresSafeArea()
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        ZStack {
                            if let featuredMovie = mainViewModel.featuredMovie {
                                FeaturedMovie(movie: featuredMovie, cornerRadius: 20)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(lineWidth: 2)
                                            .opacity(0.3)
                                    }
                            } else {
                                RoundedRectangle(cornerRadius: 20)
                            }
                        }
                        .padding(.horizontal, 16)
                        .frame(height: height * 0.625)
                        .padding(.top, 24)
                        
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Top-Rated Movies")
                                    .font(.system(size: 24, weight: .bold))
                                    .tracking(1.025)
                                    .opacity(0.8)
                                
                                Spacer()
                                
                                Text("See all")
                                    .font(Montserrat.medium.font(size: 16))
                                    .opacity(0.7)
                            }
                            .padding(.top, 32)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    if !mainViewModel.topRatedMovies.isEmpty {
                                        ForEach(mainViewModel.topRatedMovies) { movie in
                                            SmallMoviePosterView(movie: movie, posterSize: .w200, width: width * 0.35, height: 210)
                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .stroke(lineWidth: 1.5)
                                                }
                                        }
                                    } else {
                                        ForEach( 0 ..< 10) { ix in
                                            RoundedRectangle(cornerRadius: 12)
                                                .foregroundStyle(Color.gray)
                                                .opacity(0.6)
                                                .frame(width: width * 0.35, height: 210)
                                        }
                                    }
                                }
                                
                                .padding(2)
                            }
                            .padding(.top, 6)
                            .safeAreaPadding(.trailing, 12)
                            .safeAreaPadding(.leading, 24)
                            .padding(.horizontal, -24)
                            
                            Text("Top 10 Movies Today")
                                .font(.system(size: 24, weight: .bold))
                                .tracking(1.025)
                                .opacity(0.8)
                                .padding(.top, 28)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 24) {
                                    if !mainViewModel.weeklyTopTenMovies.isEmpty {
                                        ForEach(Array(mainViewModel.weeklyTopTenMovies.enumerated()), id: \.offset) { ix, movie in
                                            MoviePosterWithNumber(movie: movie, index: ix + 1, width: width * 0.35, height: 210)
                                        }
                                    } else {
                                        ForEach( 0 ..< 10) { ix in
                                            RoundedRectangle(cornerRadius: 12)
                                                .foregroundStyle(Color.gray)
                                                .opacity(0.6)
                                                .frame(width: width * 0.4755, height: 210)
                                        }
                                    }
                                }
                                .padding(2)
                            }
                            .padding(.top, 6)
                            .safeAreaPadding(.trailing, 12)
                            .safeAreaPadding(.leading, 24)
                            .padding(.horizontal, -24)
                            
                            
                            Text("Popular Movies")
                                .font(.system(size: 24, weight: .bold))
                                .tracking(1.025)
                                .opacity(0.8)
                                .padding(.top, 28)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    if !mainViewModel.popularMovies.isEmpty {
                                        ForEach(mainViewModel.popularMovies) { movie in
                                            SmallMoviePosterView(movie: movie, posterSize: .w200, width: width * 0.35, height: 210)
                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .stroke(lineWidth: 1.5)
                                                }
                                        }
                                    } else {
                                        ForEach( 0 ..< 10) { ix in
                                            RoundedRectangle(cornerRadius: 12)
                                                .foregroundStyle(Color.gray)
                                                .opacity(0.6)
                                                .frame(width: width * 0.35, height: 210)
                                        }
                                    }
                                }
                                .padding(2)
                            }
                            .padding(.top, 6)
                            .safeAreaPadding(.trailing, 12)
                            .safeAreaPadding(.leading, 24)
                            .padding(.horizontal, -24)
                            
                            
                            Text("Trending Now")
                                .font(.system(size: 24, weight: .bold))
                                .tracking(1.025)
                                .opacity(0.8)
                                .padding(.top, 28)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(mainViewModel.dailyTrendingMovies.reversed()) { movie in
                                        SmallMoviePosterView(movie: movie, posterSize: .w200, width: width * 0.35, height: 210)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(lineWidth: 1.5)
                                            }
                                    }
                                }
                                .padding(2)
                            }
                            .padding(.top, 6)
                            .safeAreaPadding(.trailing, 12)
                            .safeAreaPadding(.leading, 24)
                            .padding(.horizontal, -24)
                            
                        }
                        .padding(.horizontal, 20)
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Image(.thumb)
                                .resizable()
                                .clipShape(Circle())
                                .overlay {
                                    Circle()
                                        .stroke(lineWidth: 0.5)
                                }
                                .frame(width: 38, height: 38)
                        }
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            NavigationLink(value: Route.favorites) {
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            .buttonStyle(.plain)
                        }
                        
                    }
                }
                .onAppear() {
                    Task {
                        await mainViewModel.fetchTopRatedMovies(page: 1)
                        await mainViewModel.fetchTrendingMovies()
                        await mainViewModel.fetchWeeklyTopTenMovies()
                        
                        await mainViewModel.fetchPopularMovies(page: 1)
                        await mainViewModel.fetchTopRatedMovies(page: 1)
                        mainViewModel.loadData(modelContext: managedObjectContext)
                    }
                }
            }
            .environmentObject(mainViewModel)
            .navigationDestination(for: MovieNW.self) { movie in
                MovieDetailView(movie: movie)
                    .environmentObject(mainViewModel)
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case Route.favorites:
                    FavoriteMoviesView()
                        .environmentObject(mainViewModel)
                }
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(MainViewModel())
        .environment(\.managedObjectContext, PersistenceController.shared.viewContext)
}
