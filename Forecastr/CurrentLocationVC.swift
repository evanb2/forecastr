//
//  CurrentLocationVC.swift
//  Forecastr
//
//  Created by Evan Butler on 5/28/21.
//

import UIKit

class CurrentLocationVC: UIViewController {
    
    let location = "Boulder"
    var weatherForecast: WeatherForecast!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        getForecast()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Boulder, CO"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func getForecast() {
        NetworkManager.shared.getForecast(for: location) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let weatherForecast):
                self.weatherForecast = weatherForecast
                print(weatherForecast)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}
