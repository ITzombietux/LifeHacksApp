//
//  Style.swift
//  LifeHacksApp
//
//  Created by zombietux on 12/01/2019.
//  Copyright © 2019 zombietux. All rights reserved.
//

import Foundation
import UIKit

struct CodableColor: Codable {
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    let alpha: CGFloat
}

extension CodableColor {
    init(color: UIColor) {
        let ciColor = CIColor(color: color)
        red = ciColor.red
        green = ciColor.green
        blue = ciColor.blue
        alpha = ciColor.alpha
    }
    
    var color: UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

struct ColorScheme: Equatable {
    let name: String
    let titleColor: UIColor
    let buttonColor: UIColor
    
    static let defaultScheme = ColorScheme(name: "default", titleColor: .cloudBurst, buttonColor: .wedgewood)
    static let webScheme = ColorScheme(name: "web", titleColor: .cyan, buttonColor: .red)
}

extension ColorScheme: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case titleColor
        case buttonColor
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        titleColor = (try container.decode(CodableColor.self, forKey: .titleColor)).color
        buttonColor = (try container.decode(CodableColor.self, forKey: .buttonColor)).color
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(CodableColor(color: titleColor), forKey: .titleColor)
        try container.encode(CodableColor(color: buttonColor), forKey: .buttonColor)
    }
}
