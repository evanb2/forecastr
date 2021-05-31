//
//  CurrentLocationVC.swift
//  Forecastr
//
//  Created by Evan Butler on 5/28/21.
//

import UIKit

class CurrentLocationVC: FRDataLoadingVC {
    
    let location = "Boulder"
    var weatherForecast: WeatherForecast!
    
    let tempLabel = UILabel()
    let unitsLabel = UILabel()
    let conditionsLabel = UILabel()
    let conditionIcon = FRIconImageView(frame: .zero)
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
        view.addSubview(conditionIcon)
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
        conditionsLabel.lineBreakMode = .byWordWrapping
        conditionsLabel.numberOfLines = 4
        conditionsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tempLabel.bottomAnchor.constraint(equalTo: conditionIcon.topAnchor, constant: -10),
            
            unitsLabel.leadingAnchor.constraint(equalTo: tempLabel.trailingAnchor, constant: 10),
            unitsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            unitsLabel.topAnchor.constraint(equalTo: tempLabel.topAnchor),
            
            conditionIcon.bottomAnchor.constraint(equalTo: conditionsLabel.topAnchor, constant: -20),
            conditionIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            conditionIcon.heightAnchor.constraint(equalToConstant: 50),
            conditionIcon.widthAnchor.constraint(equalToConstant: 50),
            
            conditionsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            conditionsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
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
        showLoadingView()
        
        NetworkManager.shared.getForecast(for: location) { [weak self] result in
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
            case .success(let weatherForecast):
                self.weatherForecast = weatherForecast
                DispatchQueue.main.async {
                    self.tempLabel.text = String(Int(weatherForecast.current.tempF))
                    self.conditionsLabel.text = weatherForecast.current.condition.text
                    self.conditionIcon.set(icon: weatherForecast.current.condition.icon)
                }
            case .failure(let error):
                // show alert or something with error message
                print(error.rawValue)
            }
        }
    }
}
