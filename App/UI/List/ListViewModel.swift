//
//  ListViewModel.swift
//  App
//
//

import Global
import GlobalUI
import Combine

class ListViewModel {
    @Inject var service: ForecastService
    private var bag = Set<AnyCancellable>()

    var datas = CurrentValueSubject<[TableViewSection], Never>([])

    var showDetail: ((ForecastItem) -> Void)?

    var title: String = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as! String

    init() {
        service.subscribeToForecast()
        service.items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.createSection($0) }
            .store(in: &bag)
    }

    private func createSection(_ items: ForecastItems) {
        let datas: [TableViewData] = items.map { item in
            ListCellData(forecast: item)
                .set(trailingActions: [self.trailingAction(item: item)])
                .set(separator: .full)
                .set(separatorColor: .lightGray)
                .did(select: { _ in
                    self.routeToDetail(item: item)
                })
        }
        self.datas.send([TableViewSection(identifier: "section",
                                          datas: datas)])
    }

    private func trailingAction(item: ForecastItem) -> TableViewContextualAction {
        let action: ((TableViewData) -> Void)? = { datas in
            let tableViewSection = self.datas.value
            let tableViewDatas: [TableViewData] = tableViewSection.first?.datas ?? []
            let filteredTableViewDatas = tableViewDatas.filter({ data in
                guard let listCellData = data as? ListCellData else {
                    return false
                }
                return !listCellData.contains(forecast: item)
            })
            self.datas.send([TableViewSection(identifier: "section",
                                              datas: filteredTableViewDatas)])
        }
        return TableViewContextualAction(title: "Delete", style: .destructive, backgroundColor: .red, action: action)
    }
    
    private func routeToDetail(item: ForecastItem) {
        self.showDetail?(item)
    }
}
