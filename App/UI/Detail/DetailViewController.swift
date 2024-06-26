//
//  DetailViewController.swift
//  App
//
//

import UIKit
import Combine
import GlobalUI

class DetailViewController: UIViewController {

    var forecastItem: ForecastItem
    
    public init(forecastItem: ForecastItem) {
        self.forecastItem = forecastItem
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addFullScreenView(DetailView(forecastItem: self.forecastItem))
    }
}
