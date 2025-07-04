//
//  FontManager.swift
//  MovieDB
//
//  Created by Shubham on 01/07/25.
//

import SwiftUI

enum Montserrat {
    case regular
    case medium
    case semibold
    case bold
    
    func font(size: CGFloat) -> Font {
        switch self {
        case .regular:
            return .custom("Montserrat-Regular", size: size)
        case .medium:
            return .custom("Montserrat-Medium", size: size)
        case .semibold:
            return .custom("Montserrat-SemiBold", size: size)
        case .bold:
            return .custom("Montserrat-Bold", size: size)
        }
    }
}

enum Londrina {
    case regular
    
    func font(size: CGFloat) -> Font {
        switch self {
        case .regular:
            return .custom("LondrinaOutline-Regular", size: size)
        }
    }
}
