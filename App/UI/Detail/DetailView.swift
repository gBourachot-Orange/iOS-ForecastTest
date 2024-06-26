//
//  DetailView.swift
//  App
//
//

import SwiftUI

struct DetailView: View {
    var forecastItem : ForecastItem
    var body: some View {
        VStack {
            Spacer()
            Text("Day: \(forecastItem.day)")
                .foregroundColor(Color.fromUIColor("textForeground"))
            Text("Will be: \(forecastItem.description)")
                .foregroundColor(Color.fromUIColor("textForeground"))
            if let image = forecastItem.image {
                image
                    .renderingMode(.template)
                    .foregroundColor(Color.fromUIColor("textForeground"))
            }
            HStack {
                Text("Chance of rain:")
                    .foregroundColor(Color.fromUIColor("textForeground"))
                Text(forecastItem.chanceRain, format: .percent)
                    .foregroundColor(Color.fromUIColor("textForeground"))
            }
            Spacer()
        }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .center
        )
        .background(Color.fromUIColor("background"))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(forecastItem: .init(day: "3",
                                       description: "Sunny",
                                       sunrise: 2,
                                       sunset: 1,
                                       chanceRain: 0.1,
                                       type: "sunny"))
    }
}
