//
//  MoviesGridView.swift
//  MovieDB
//
//  Created by Shubham on 05/07/25.
//

import SwiftUI

struct MoviesGridView: View {
    
    // MARK: - Variables
    var movies: [MovieNW]
    var title: String = ""
    
    // MARK: - Views
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 28, weight: .bold))
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
                    ForEach(movies) { movie in
                        MovieTileView(movie: movie, width: proxy.size.width / 3 - 24, height: (proxy.size.width / 3 - 24) * 1.35)
                    }
                }
                .padding(.top, 28)
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    MoviesGridView(movies: [testMovie])
        .environmentObject(MainViewModel())
}
