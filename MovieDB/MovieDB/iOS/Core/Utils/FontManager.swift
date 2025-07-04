//
//  FontManager.swift
//  MovieDB
//
//  Created by Shubham on 01/07/25.
//

import SwiftUI

//enum ClashGrotestk {
//    case extralight
//    case light
//    case regular
//    case medium
//    case semibold
//    case bold
//    
//    
//    // MARK: - Functions
//    func font(size: CGFloat) -> Font {
//        switch self {
//        case .extralight:
//            return .custom("ClashGrotesk-Extralight", size: size)
//
//        case .light:
//            return .custom("ClashGrotesk-Light", size: size)
//
//        case .regular:
//            return .custom("ClashGrotesk-Regular", size: size)
//
//        case .medium:
//            return .custom("ClashGrotesk-Medium", size: size)
//            
//        case .semibold:
//            return .custom("ClashGrotesk-Semibold", size: size)
//
//        case .bold:
//            return .custom("ClashGrotesk-Bold", size: size)
//        }
//    }
//}


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
