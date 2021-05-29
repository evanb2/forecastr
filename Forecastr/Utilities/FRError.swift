//
//  FRError.swift
//  Forecastr
//
//  Created by Evan Butler on 5/28/21.
//

import Foundation

enum FRError: String, Error {
    case invalidLocation = "The location created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
