//
//  FRDayView.swift
//  Forecastr
//
//  Created by Evan Butler on 5/28/21.
//

import UIKit

class DayCell: UITableViewCell {
    
    static let reuseID = "DayCell"
    
    let dayLabel = UILabel()
    let minTempLabel = UILabel()
    let maxTempLabel = UILabel()
    let conditionLabel = UILabel()
    
    var forecastDay: ForecastDay!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(forecastDay: ForecastDay) {
        dayLabel.text = forecastDay.dateEpoch.convertToDayFormat()
        conditionLabel.text = forecastDay.day.condition.text
        minTempLabel.text = String(forecastDay.day.mintempF)
        maxTempLabel.text = String(forecastDay.day.maxtempF)
    }
    
    private func configure() {
        selectionStyle = .none
        
        addSubview(dayLabel)
        addSubview(conditionLabel)
        addSubview(minTempLabel)
        addSubview(maxTempLabel)
        
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        minTempLabel.textColor = .secondaryLabel
        minTempLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            conditionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            conditionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            dayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            dayLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            
            maxTempLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            maxTempLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            
            minTempLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            minTempLabel.trailingAnchor.constraint(equalTo: maxTempLabel.leadingAnchor, constant: -10),
        ])
    }
}
