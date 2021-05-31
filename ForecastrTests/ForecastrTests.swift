//
//  ForecastrTests.swift
//  ForecastrTests
//
//  Created by Evan Butler on 5/27/21.
//

import XCTest
@testable import Forecastr

class ForecastrTests: XCTestCase {

    func testSetsIconImageFromPath() {
        var iconPath = "//cdn.weatherapi.com/weather/64x64/day/176.png"
        let iconImageView = FRIconImageView(frame: .zero)
        
        XCTAssertNil(iconImageView.image?.imageAsset, "FRIconImageView initialized without image.")

        iconImageView.set(icon: iconPath)
        
        XCTAssertNotNil(iconImageView.image?.imageAsset, "Renders the condition icon from a given icon path.")
        
        iconImageView.image = nil
        iconPath = "this/is/not/a/correct/path"
        iconImageView.set(icon: iconPath)
        
        XCTAssertNil(iconImageView.image?.imageAsset, "Renders no icon given incorrect icon path.")
    }

}
