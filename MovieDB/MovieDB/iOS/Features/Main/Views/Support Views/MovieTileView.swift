//
//  MovieTileView.swift
//  MovieDB
//
//  Created by Shubham on 05/07/25.
//

import SwiftUI

struct MovieTileView: View {
    var movie: MovieNW
    var width: CGFloat = 150
    var height: CGFloat = 200
    
    // MARK: - Views
    var body: some View {
        NavigationLink(value: movie) {
            VStack {
                URLImageView(imageURLString: movie.posterPath, width: width, height: height)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 0.75)
                            .opacity(0.4)
                    }
                Text(movie.title ?? "")
                    .font(.system(size: 19, weight: .bold))
                    .lineLimit(2)
                
                Spacer()
            }
        }
        .buttonStyle(.plain)
    }
}


#Preview {
    MovieTileView(movie: testMovie)
}
