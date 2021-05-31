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
    
    let padding: CGFloat = 20
    let tempLabel = FRLabel(font: .largeTitle, textAlignment: .center)
    let unitsLabel = FRLabel(font: .subheadline)
    let conditionsLabel = FRSecondaryLabel(font: .title1, textAlignment: .center)
    let conditionIcon = FRIconImageView(frame: .zero)
    let forecastButton = FRButton(title: "Forecast", backgroundColor: .systemBlue)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        
        unitsLabel.text = "°F"
        
        conditionsLabel.lineBreakMode = .byWordWrapping
        conditionsLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            tempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tempLabel.bottomAnchor.constraint(equalTo: conditionIcon.topAnchor, constant: -10),
            
            unitsLabel.leadingAnchor.constraint(equalTo: tempLabel.trailingAnchor, constant: 10),
            unitsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            unitsLabel.topAnchor.constraint(equalTo: tempLabel.topAnchor),
            
            conditionIcon.bottomAnchor.constraint(equalTo: conditionsLabel.topAnchor),
            conditionIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            conditionIcon.heightAnchor.constraint(equalToConstant: 50),
            conditionIcon.widthAnchor.constraint(equalToConstant: 50),
            
            conditionsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            conditionsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            conditionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            conditionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        ])
    }
    
    private func configureForecastButton() {
        forecastButton.addTarget(self, action: #selector(pushForecastListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            forecastButton.heightAnchor.constraint(equalToConstant: 50),
            forecastButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            forecastButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            forecastButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
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
