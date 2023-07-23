//
//  Color+Extension.swift
//  MyMovies
//
//  Created by Christos Tzimas on 21/7/23.
//

import SwiftUI

extension Color {
    static func randomColor() -> Color {
        let red = Double.random(in: 0.0 ... 1.0)
        let green = Double.random(in: 0.0 ... 1.0)
        let blue = Double.random(in: 0.0 ... 1.0)
        return Color(red: red, green: green, blue: blue)
    }
}
