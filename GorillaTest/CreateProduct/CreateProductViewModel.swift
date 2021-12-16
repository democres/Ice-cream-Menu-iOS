//
//  CreateProductViewModel.swift
//  GorillaTest
//
//  Created by David Figueroa on 1/11/21.
//

import Foundation

class CreateProductViewModel {
    
    var title = ""
    var mainColor = ""
    var secondaryColor = ""
    var flavors = [Product]()
    var toppings = [Product]()
    var nextFlavor: Product?
    var previousFlavor: Product?
    let apiService = NetworkEngine()
    let backgroundQueue = DispatchQueue(label: "com.background", qos: .userInteractive, attributes: .concurrent)
    let dispatchGroup = DispatchGroup()
    var didLoadData = true
    
    init(){}
    
    func getData(success: @escaping (Bool) -> ()) {
        getInitialConfig()
        getToppings()
        getFlavors()
        dispatchGroup.notify(queue: backgroundQueue) { [weak self] in
            success(self?.didLoadData ?? true)
        }
    }
    
    func getInitialConfig() {
        guard let request = apiService.createRequestWithURLComponents(requestType: .getConfig) else { return }
        dispatchGroup.enter()
        apiService.sendRequest(model: Store.self, request: request) { [weak self] resultResponse in
            switch resultResponse {
            case .success(let data):
                self?.title = data.storeName
                self?.mainColor = data.colors.main
                self?.secondaryColor = data.colors.secondary
            case .failure(let error):
                print(error)
                self?.didLoadData = false
            }
            self?.dispatchGroup.leave()
        }

    }
    
    func getToppings() {
        guard let request = apiService.createRequestWithURLComponents(requestType: .getToppings) else { return }
        dispatchGroup.enter()
        apiService.sendRequest(model: [Product].self, request: request) { [weak self] resultResponse in
            switch resultResponse {
            case .success(let data):
                self?.toppings = data
            case .failure(let error):
                print(error)
                self?.didLoadData = false
            }
            self?.dispatchGroup.leave()
        }
    }
    
    func getFlavors() {
        guard let request = apiService.createRequestWithURLComponents(requestType: .getFlavors) else { return }
        dispatchGroup.enter()
        apiService.sendRequest(model: [Product].self, request: request) { [weak self] resultResponse in
            switch resultResponse {
            case .success(let data):
                self?.flavors = data
            case .failure(let error):
                print(error)
                self?.didLoadData = false
            }
            self?.dispatchGroup.leave()
        }
    }

}
