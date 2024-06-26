//
//  Color+UIKit.swift
//  App
//
//  Created by BOURACHOT Guillaume on 26.06.2024.
//

import Foundation
import SwiftUI
import UIKit

extension Color {
    static func fromUIColor(_ name: String) -> Color {
        guard let uiColor = UIColor(named: name) else { return .clear }
        return Color(uiColor: uiColor)
    }
}
