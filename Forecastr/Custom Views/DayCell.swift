//
//  FRDayView.swift
//  Forecastr
//
//  Created by Evan Butler on 5/28/21.
//

import UIKit

class DayCell: UITableViewCell {
    
    static let reuseID = "DayCell"
    
    let dayLabel = FRLabel(font: .title2)
    let minTempLabel = FRSecondaryLabel()
    let maxTempLabel = FRLabel()
    let conditionIcon = FRIconImageView(frame: .zero)
    let conditionLabel = FRSecondaryLabel()
    
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
        
        conditionLabel.textAlignment = .center
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            conditionIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            conditionIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            conditionIcon.heightAnchor.constraint(equalToConstant: 30),
            conditionIcon.widthAnchor.constraint(equalToConstant: 30),
            
            conditionLabel.topAnchor.constraint(equalTo: conditionIcon.bottomAnchor, constant: 5),
            conditionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            conditionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            conditionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            
            dayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            dayLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            
            maxTempLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            maxTempLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            
            minTempLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            minTempLabel.trailingAnchor.constraint(equalTo: maxTempLabel.leadingAnchor, constant: -padding),
        ])
    }
}
