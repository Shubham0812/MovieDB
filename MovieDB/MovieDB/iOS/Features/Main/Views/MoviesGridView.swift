//
//  MoviesGridView.swift
//  MovieDB
//
//  Created by Shubham on 05/07/25.
//

import SwiftUI

struct MoviesGridView: View {
    
    // MARK: - Variables
    @EnvironmentObject var mainViewModel: MainViewModel
    
    // MARK: - Views
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text(mainViewModel.selectedTitle)
                        .font(.system(size: 28, weight: .bold))
                        .padding(.top, 12)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
                        ForEach(mainViewModel.selectedMovies) { movie in
                            MovieTileView(movie: movie, width: proxy.size.width / 3 - 24, height: (proxy.size.width / 3 - 24) * 1.35)
                        }
                    }
                    .padding(.top, 20)
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    MoviesGridView()
        .environmentObject(MainViewModel())
}
