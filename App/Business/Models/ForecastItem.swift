//
//  ForecastItem.swift
//  App
//
//

import Foundation
import SwiftUI
import UIKit

struct ForecastItem: Equatable {
    let day: String
    let description: String
    var image: Image? {
        guard let uiImage = UIImage(named: type) else { return nil }
        return Image(uiImage: uiImage)
    }
    let sunrise, sunset: Int
    let chanceRain: Double
    let type: String
}

extension ForecastItem {
    // ForecastItemDTO mapper
    init(from forecastItemDTO: ForecastItemDTO) {
        self.day = forecastItemDTO.day
        self.description = forecastItemDTO.description
        self.sunrise = forecastItemDTO.sunrise
        self.sunset = forecastItemDTO.sunset
        self.chanceRain = forecastItemDTO.chanceRain
        self.type = forecastItemDTO.type
    }
}

typealias ForecastItems = [ForecastItem]
