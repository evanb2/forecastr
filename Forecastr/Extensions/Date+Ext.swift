//
//  Date+Ext.swift
//  Forecastr
//
//  Created by Evan Butler on 5/28/21.
//

import Foundation

extension Date {
    
    func convertToDayFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self)
    }
    
}
