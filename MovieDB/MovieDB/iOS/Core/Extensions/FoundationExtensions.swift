//
//  FoundationExtensions.swift
//  MovieDB
//
//  Created by Shubham on 03/07/25.
//

import SwiftUI
import UIKit

extension Int {
    func appendZeros() -> String {
        if (self < 10) {
            return "0\(self)"
        } else {
            return "\(self)"
        }
    }
    
    func degreeToRadians() -> CGFloat {
        return  (CGFloat(self) * .pi) / 180
    }
    
    func toPhoneNumber() -> String {
        let stringNumber = String(self)
        return stringNumber.prefix(5) +  "-" + stringNumber.suffix(5)
    }
}

extension CGFloat {
    func clean(places: Int) -> String {
        return String(format: "%.\(places)f", self)
    }
    
    func toDouble() -> Double {
        return Double(self)
    }
}

extension Double {
    func convert(fromRange: (Double, Double), toRange: (Double, Double)) -> Double {
        var value = self
        value -= fromRange.0
        value /= Double(fromRange.1 - fromRange.0)
        value *= toRange.1 - toRange.0
        value += toRange.0
        return value
    }
    
    func clean(places: Int) -> String {
        return String(format: "%.\(places)f", self)
    }
    
    
    func convertToInt() -> Int {
        return Int(self)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
