//
//  MovieDetailView.swift
//  MovieDB
//
//  Created by Shubham on 04/07/25.
//

import SwiftUI

struct MovieDetailView: View {
    
    // MARK: - Variables
    @EnvironmentObject var mainViewModel: MainViewModel
    @ObservedObject var movie: MovieNW
    
    @State var movieDetail: MovieDetail?
    @State var castDetails: [CastMember] = []
    
    // MARK: - Views
    var body: some View {
        GeometryReader { proxy in
            let width: CGFloat = proxy.size.width
            let height: CGFloat = proxy.size.height
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    URLImageView(imageURLString: movie.posterPath, width: width, height: height * 0.7)
                        .overlay(alignment: .bottomLeading) {
                            Image(systemName: movie.isFavorite ? "heart.fill" : "heart")
                                .font(.system(size: 28, weight: .semibold))
                                .foregroundStyle(movie.isFavorite ? .red : .label)
                                .background {
                                    Circle()
                                        .foregroundStyle(.background)
                                        .padding(-12)
                                }
                                .onTapGesture {
                                    movie.isFavorite.toggle()
                                    
                                    if movie.isFavorite {
                                        mainViewModel.favoriteMovie(movieNW: movie)
                                    } else {
                                        mainViewModel.unfavoriteMovie(movieID: movie.id)
                                    }
                                }
                                .symbolEffect(.bounce, options: .speed(1.5), value: movie.isFavorite)
                                .padding(24)
                        }
                    
                    Text(movie.title ?? "")
                        .font(.system(size: 32, weight: .bold))
                        .padding(.top, 12)
                    
                    if let movieDetail {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), alignment: .leading) {
                            VStack(spacing: 12) {
                                Text("Runtime")
                                    .font(.system(size: 14, weight: .medium))
                                    .opacity(0.3)
                                    .textCase(.uppercase)
                                
                                Text(timeString(from: movieDetail.runtime ?? 0))
                                    .font(Montserrat.semibold.font(size: 20))
                            }
                            
                            VStack(spacing: 12) {
                                Text("Fans")
                                    .font(.system(size: 14, weight: .medium))
                                    .opacity(0.3)
                                    .textCase(.uppercase)
                                
                                Text("\(movieDetail.voteCount)")
                                    .font(Montserrat.semibold.font(size: 20))
                            }
                            
                            VStack(spacing: 12) {
                                Text("Rating")
                                    .font(.system(size: 14, weight: .medium))
                                    .opacity(0.3)
                                    .textCase(.uppercase)
                                
                                Text(movieDetail.voteAverage.clean(places: 1))
                                    .font(Montserrat.semibold.font(size: 20))
                            }
                        }
                        .padding(.top, 8)
                    }
                    
                    Text(movie.overview ?? "")
                        .font(Montserrat.regular.font(size: 15))
                        .lineSpacing(4)
                        .padding(.top, 12)
                        .padding(.trailing, 42)
                        .padding(.leading, 2)
                    
                    HStack {
                        Text("Top Cast")
                            .font(.system(size: 20, weight: .semibold))
                        
                        RoundedRectangle(cornerRadius: 4)
                            .opacity(0.4)
                            .frame(width: 80, height: 8)
                    }
                    
                    VStack(spacing: 16) {
                        ForEach(castDetails.prefix(10), id: \.id) { castMember in
                            CastView(castMember: castMember, width: 52, height: 52)
                        }
                    }
                    .padding(.top, 16)
                    
                    Spacer()
                        .frame(height: 100)
                }
                .padding(.leading, 24)
            }
        }
        .onAppear() {
            Task {
                self.movieDetail = await mainViewModel.getMovieDetails(movie.id)
                self.castDetails = await mainViewModel.getCastDetails(movie.id)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .medium))
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    
    // MARK: - Functions
    func timeString(from minutes: Int) -> String {
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        
        var result = ""
        if hours > 0 {
            result += "\(hours)h"
        }
        if remainingMinutes > 0 {
            if !result.isEmpty { result += " " }
            result += "\(remainingMinutes)m"
        }
        
        return result.isEmpty ? "0m" : result
    }
}

#Preview {
    NavigationStack {
        MovieDetailView(movie: testMovie)
            .environmentObject(MainViewModel())
    }
}
