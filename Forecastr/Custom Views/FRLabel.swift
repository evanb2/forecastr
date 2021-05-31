//
//  FRLabel.swift
//  Forecastr
//
//  Created by Evan Butler on 5/31/21.
//

import UIKit

class FRLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(font: UIFont.TextStyle, textAlignment: NSTextAlignment = .left) {
        self.init(frame: .zero)
        self.font = UIFont.preferredFont(forTextStyle: font)
        self.textAlignment = textAlignment
    }
    
    private func configure() {
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
