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
    
    let tempLabel = UILabel()
    let unitsLabel = UILabel()
    let conditionsLabel = UILabel()
    let forecastButton = FRButton(title: "3 Day Forecast", backgroundColor: .systemBlue)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureUI()
        getForecast()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Boulder, CO"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureUI() {
        view.addSubview(tempLabel)
        view.addSubview(unitsLabel)
        view.addSubview(conditionsLabel)
        view.addSubview(forecastButton)
        
        configureForecastButton()
        
        tempLabel.textColor = .label
        tempLabel.textAlignment = .center
        tempLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        unitsLabel.text = "°F"
        unitsLabel.textColor = .label
        unitsLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        unitsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        conditionsLabel.textColor = .secondaryLabel
        conditionsLabel.textAlignment = .center
        conditionsLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        conditionsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tempLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            unitsLabel.leadingAnchor.constraint(equalTo: tempLabel.trailingAnchor, constant: 10),
            unitsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            unitsLabel.topAnchor.constraint(equalTo: tempLabel.topAnchor),
            
            conditionsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            conditionsLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 20),
            conditionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            conditionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func configureForecastButton() {
        forecastButton.addTarget(self, action: #selector(pushForecastListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            forecastButton.heightAnchor.constraint(equalToConstant: 50),
            forecastButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            forecastButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            forecastButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    @objc func pushForecastListVC() {
        guard let _ = weatherForecast else { return }
        
        let forecast = weatherForecast.forecast.forecastday
        let forecastDetailsVC = ForecastListVC(forecastDays: forecast)
        navigationController?.pushViewController(forecastDetailsVC, animated: true)
    }
    
    private func getForecast() {
        NetworkManager.shared.getForecast(for: location) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let weatherForecast):
                self.weatherForecast = weatherForecast
                DispatchQueue.main.async {
                    self.tempLabel.text = String(Int(weatherForecast.current.tempF))
                    self.conditionsLabel.text = weatherForecast.current.condition.text
                }
            case .failure(let error):
                // show alert or something with error message
                print(error.rawValue)
            }
        }
    }
}
