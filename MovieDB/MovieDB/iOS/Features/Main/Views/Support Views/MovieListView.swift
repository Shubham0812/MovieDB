//
//  MovieListView.swift
//  MovieDB
//
//  Created by Shubham on 03/07/25.
//

import SwiftUI

protocol MovieListData {
    var id: Int64 { get }
    var title: String? { get }
    var overview: String? { get }
    
    var posterPath: String? { get }
    
    var isFavorite: Bool { get set }
    var genreIDs: String? { get }
    var releaseDate: String? { get }
    var voteAverage: Double { get }
}

struct MovieListView: View {
    
    // MARK: - Variables
    @Environment(\.managedObjectContext) private var managedObjectContext

    @State var movie: MovieListData
    
    var movieGenre: String = ""
    
    var addAction: () -> () = {}
    var removeAction: () -> () = {}
    
    // MARK: - Views
    var body: some View {
        HStack {
            URLImageView(imageURLString: movie.posterPath, width: 100, height: 120)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(lineWidth: 1.25)
                        .foregroundStyle(Color.label)
                        .opacity(0.4)
                }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(movie.title ?? "")
                        .lineLimit(2)
                        .font(.system(size: 23, weight: .semibold))
                        .padding(.trailing, 4)
                    Spacer()
                }
                .overlay(alignment: .trailing) {
                    Image(systemName: movie.isFavorite ? "heart.fill" : "heart")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle( .red)
                        .opacity(movie.isFavorite ? 1 : 0.7)
                        .padding(.top, 2.25)
                        .symbolEffect(.bounce, options: .speed(1.5), value: movie.isFavorite)
                        .onTapGesture {
                            movie.isFavorite.toggle()
                            if movie.isFavorite {
                                addAction()
                            } else {
                                removeAction()
                            }
                        }
                }
                Text(movieGenre)
                    .font(Montserrat.medium.font(size: 12))
                    .opacity(0.6)
                    .lineLimit(1)
                
                Text(movie.overview ?? "")
                    .font(Montserrat.medium.font(size: 12))
                    .lineLimit(2)
                    .padding(.top, 4)
                
                Spacer()
                
                HStack(spacing: 12) {
                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                        Text(movie.releaseDate?.components(separatedBy: "-")[0] ?? "")
                            .font(Montserrat.medium.font(size: 16))
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        
                        Text("\(movie.voteAverage.clean(places: 1))")
                            .font(Montserrat.medium.font(size: 16))
                    }
                }
                .opacity(0.8)
            }
            .padding(.leading, 4)
            
            Spacer()
        }
        
        .padding(12)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .stroke(lineWidth: 2.25)
                .opacity(0.15)
        }
    }
}

#Preview {
//    @Previewable @State var testMovie: Movie =  PreviewCoreDataProvider.shared.getSampleMovie()
    MovieListView(movie:PreviewCoreDataProvider.shared.getSampleMovie())
        .padding(12)
        .fixedSize(horizontal: false, vertical: true)
        .environment(\.managedObjectContext, PreviewCoreDataProvider.shared.container.viewContext)
}
