//
//  ForecastService.swift
//  App
//
//

import Combine
import Global

protocol ForecastService {
    var items: CurrentValueSubject<ForecastItems, Never> { get }
    func subscribeToForecast()
}

class ForecastServiceImpl: ForecastService {
    @Inject var forecastNetwork: ForecastNetworkService
    var items = CurrentValueSubject<ForecastItems, Never>([])
    var isDemoMode: Bool {
        #if DemoTarget
        return true
        #else
        return false
        #endif
    }
    private var bag = Set<AnyCancellable>()
    
    func subscribeToForecast() {
        if isDemoMode {
            guard let jsonData = self.loadDataFromJSON(with: "ForecastDemoData"),
                  let forecastItemDTO = try? JSONDecoder().decode([ForecastItemDTO].self, from: jsonData) else {
                self.items.send([])
                return
            }
            self.items.send(forecastItemDTO.map({ ForecastItem.init(from: $0)}))
        } else {
            forecastNetwork.getForecast()
                .sink(receiveCompletion: {
                    completion in
                    switch completion {
                    case .finished: break
                    case .failure:
                        // Manage error here
                        break
                    }
                },
                      receiveValue: { [weak self] forecastItems in
                    self?.items.send(forecastItems.map({ ForecastItem.init(from: $0)}))
                }).store(in: &bag)
        }
    }
    
    private func loadDataFromJSON(with name : String) -> Data? {
        let path = Bundle(for: ForecastServiceImpl.self).path(forResource: name, ofType: "json")!
        return try? Data(contentsOf: URL(fileURLWithPath : path))
    }
}
