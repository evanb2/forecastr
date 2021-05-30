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
    let conditionIcon = FRIconImageView(frame: .zero)
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
        minTempLabel.text = String(Int(forecastDay.day.mintempF))
        maxTempLabel.text = String(Int(forecastDay.day.maxtempF))
        conditionIcon.set(icon: forecastDay.day.condition.icon)
    }
    
    private func configure() {
        selectionStyle = .none
        
        addSubview(dayLabel)
        addSubview(conditionIcon)
        addSubview(conditionLabel)
        addSubview(minTempLabel)
        addSubview(maxTempLabel)
        
        dayLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        conditionLabel.textAlignment = .center
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        minTempLabel.textColor = .secondaryLabel
        minTempLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            conditionIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            conditionIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            conditionIcon.heightAnchor.constraint(equalToConstant: 30),
            conditionIcon.widthAnchor.constraint(equalToConstant: 30),
            
            conditionLabel.topAnchor.constraint(equalTo: conditionIcon.bottomAnchor, constant: 5),
            conditionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            conditionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            conditionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            dayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            dayLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            
            maxTempLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            maxTempLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            
            minTempLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            minTempLabel.trailingAnchor.constraint(equalTo: maxTempLabel.leadingAnchor, constant: -10),
        ])
    }
}
