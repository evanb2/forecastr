//
//  FRIconImageView.swift
//  Forecastr
//
//  Created by Evan Butler on 5/30/21.
//

import UIKit

class FRIconImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(icon: String) {
        let iconPathArray = icon.split(separator: "/")
        let iconFolder = iconPathArray.contains("day") ? "day" : "night"
        
        guard let iconCode = iconPathArray.last?.split(separator: ".")[0] else { return }
        
        image = UIImage(named: "\(iconFolder)/\(iconCode)")
    }
    
    private func configure() {
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
